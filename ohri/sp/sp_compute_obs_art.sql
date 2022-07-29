
DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_art;

CREATE PROCEDURE sp_compute_obs_art(IN encounterid INT,
                                    IN conceptid INT,
                                    IN patientid INT)
sp:
BEGIN

    DECLARE computed_obs_encounter_type INT;
    DECLARE computed_obs_encounter_id INT;
    DECLARE request_encounter_type INT;
    DECLARE concept_encounter_type INT;
    DECLARE compute_procedure NVARCHAR(50);
    DECLARE concept_label NVARCHAR(50);
    DECLARE regimen INT;
    DECLARE regimen_line INT;
    DECLARE regimen_date DATETIME DEFAULT NULL;
    DECLARE previous_regimen_date DATETIME DEFAULT NULL;
    DECLARE regimen_id INT;
    DECLARE regimen_line_id INT;
    DECLARE regimen_date_difference INT DEFAULT 0;

    -- Initialise all relevant variables
    SELECT m.computed_obs_encounter_type_id,
           m.obs_encounter_type_id,
           m.compute_procedure_name,
           m.concept_label,
           e.encounter_type
    INTO computed_obs_encounter_type, concept_encounter_type, compute_procedure, concept_label, request_encounter_type
    FROM mamba_obs_compute_metadata m INNER JOIN encounter e ON m.obs_encounter_type_id = e.encounter_type
    WHERE e.encounter_id = encounterid AND e.patient_id = patientid AND m.concept_id = conceptid;

    -- Don't Compute if obs is not computable (i.e. we didn't find a procedure name)
    IF (compute_procedure IS NULL) THEN
        LEAVE sp;
    END IF;

    -- Fetch the Regimen concept_id & the Regimen value_coded (if any) that was captured in this Encounter
    SELECT o.concept_id , o.value_coded INTO regimen_id, regimen FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'regimen' AND o.encounter_id = encounterid AND o.person_id = patientid
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch the Regimen Line concept_id & the Regimen  Line value_coded (if any) that was captured in this Encounter
    SELECT o.concept_id , o.value_coded INTO regimen_line_id, regimen_line FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'regimen_line' AND o.encounter_id = encounterid AND o.person_id = patientid
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch the saved computed Obs Encounter Id for this Patient
     SELECT e.encounter_id INTO computed_obs_encounter_id FROM encounter e
        WHERE e.encounter_type = computed_obs_encounter_type AND e.patient_id = patientid;

    IF (concept_label = 'stop_date') THEN

        -- Delete both the computed Regimen & Regimen Line (if any) for this Patient since they have Stopped TX
        DELETE FROM obs WHERE encounter_id = computed_obs_encounter_id AND person_id = patientid AND concept_id in (regimen_id, regimen_line_id);
        LEAVE sp;

    ELSEIF (concept_label = 'start_date'
        OR concept_label = 'switch_date'
        OR concept_label = 'substitute_date'
        OR concept_label = 'restart_date') THEN

        SELECT value_datetime INTO regimen_date FROM obs o
            WHERE o.encounter_id = encounterid AND o.concept_id = conceptid AND o.person_id = patientid AND value_datetime IS NOT NULL
        ORDER BY obs_id DESC LIMIT 1;

        -- Fetch the saved (computed) Regimen date for this Patient
        SELECT o.obs_datetime INTO previous_regimen_date FROM obs o
            WHERE o.encounter_id = computed_obs_encounter_id AND o.concept_id = regimen_id AND o.person_id = patientid
        ORDER BY obs_id DESC LIMIT 1;

        IF (computed_obs_encounter_id IS NULL || previous_regimen_date IS NULL) THEN -- There is NO ART computed obs Encounter for this Patient

        -- Create a new computed Obs Encounter for this patient
            IF computed_obs_encounter_id IS NULL THEN

                INSERT INTO encounter(encounter_type, patient_id, encounter_datetime, creator, date_created, uuid)
                VALUES (computed_obs_encounter_type, patientid, NOW(), 1, NOW(), UUID());

                -- Set the computed obs encounter id with the newly persisted computed Obs Encounter id
                SELECT encounter_id INTO computed_obs_encounter_id FROM encounter e
                    WHERE encounter_type = computed_obs_encounter_type AND e.patient_id = patientid
                ORDER BY encounter_id DESC LIMIT 1;
            END IF;

            -- Insert the regimen & the Date
            INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
            VALUES (now(), regimen_date, computed_obs_encounter_id, patientid, regimen_id, regimen, uuid(), 1);

            -- Insert the regimen Line & the Date
            INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
            VALUES (now(), regimen_date, computed_obs_encounter_id, patientid, regimen_line_id, regimen_line, uuid(), 1);

        ELSE
            -- Compare previously computed/stored Regimen Date with this new Regimen Date
            SET regimen_date_difference = DATEDIFF(regimen_date, STR_TO_DATE(previous_regimen_date, '%Y-%m-%d %H:%i:%s'));
            IF regimen_date_difference >= 0 THEN

                UPDATE obs SET value_coded = regimen
                WHERE concept_id = regimen_id AND encounter_id = computed_obs_encounter_id AND person_id = patientid;

                UPDATE obs SET value_coded = regimen_line
                WHERE concept_id = regimen_line_id AND encounter_id = computed_obs_encounter_id AND person_id = patientid;
            END IF;
        END IF;

    END IF;
END;
//

DELIMITER ;