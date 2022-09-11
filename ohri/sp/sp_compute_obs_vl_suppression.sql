DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_vl_suppression;

CREATE PROCEDURE sp_compute_obs_vl_suppression(IN encounterid INT,
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
    DECLARE vl_result INT;
    DECLARE vl_copies INT;
    DECLARE vl_copies_id INT;
    DECLARE vl_not_detected_id INT;
    DECLARE vl_detected_id INT;
    DECLARE vl_test_date DATETIME DEFAULT NULL;
    DECLARE vl_result_id INT;
    DECLARE vl_result_already_computed BOOLEAN DEFAULT FALSE; -- TRUE (yes) or NULL/FALSE
    DECLARE art_start_date DATETIME DEFAULT NULL;
    DECLARE number_of_days_on_art INT DEFAULT 0;
    DECLARE art_consistency_period INT DEFAULT 90; -- 90 days on ART
    DECLARE vl_result_validity INT DEFAULT 365; -- 12 months
    DECLARE is_vl_valid BOOLEAN DEFAULT FALSE;

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

    -- Fetch the ART start date for use
    SELECT  o.value_datetime INTO art_start_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        INNER JOIN encounter e on o.encounter_id = e.encounter_id
        WHERE m.concept_label = 'start_date'
          AND e.encounter_type = m.obs_encounter_type_id AND o.person_id = patientid and o.value_datetime IS NOT NULL
    ORDER BY obs_id ASC LIMIT 1;

    -- Can't compute VL, if we can't tell if this patient is on ART or Not & for how long
    IF (art_start_date IS NULL) THEN
        LEAVE sp;
    END IF;

    -- Only VL of patients who have been on ART for at-least 3 months should be considered
    SET number_of_days_on_art = DATEDIFF(NOW(), STR_TO_DATE(art_start_date, '%Y-%m-%d %H:%i:%s'));
    IF number_of_days_on_art < art_consistency_period THEN
        LEAVE sp;
    END IF;

    -- Fetch the Regimen id & the value that was computed (if any) for this patient
    -- SELECT o.concept_id, o.value_coded, o.obs_datetime INTO regimen_id, regimen FROM obs o
    --     INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
    --     INNER JOIN encounter e on o.encounter_id = e.encounter_id
    --     WHERE m.concept_label = 'regimen'
    --       AND e.encounter_type = m.computed_obs_encounter_type_id AND o.person_id = patientid
    -- ORDER BY obs_id DESC LIMIT 1;

    -- Fetch the vl_test_date -- This should be fetched from the obs_date_time of the vl_copies obs to avoid inconsistencies
    -- SELECT o.value_datetime INTO vl_test_date FROM obs o
    --     INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
    --     WHERE m.concept_label = 'vl_test_date' AND o.encounter_id = encounterid AND o.person_id = patientid
    -- ORDER BY obs_id DESC LIMIT 1;

    -- Fetch the vl_copies_id & the vl_copies
    -- If a patient has more than 1 VL result during the past 12 months, consider the most recent result
    SELECT o.concept_id , o.value_numeric, o.obs_datetime INTO vl_copies_id, vl_copies, vl_test_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'vl_copies' AND o.encounter_id = encounterid AND o.person_id = patientid
    ORDER BY obs_datetime DESC LIMIT 1;

    -- The VL is valid if there is a valid Test Result Date
    IF (vl_test_date IS NULL) THEN
        LEAVE sp;
    END IF;

    -- The VL is valid if done within the past 12 months
    SET is_vl_valid = DATEDIFF(NOW(), STR_TO_DATE(vl_test_date, '%Y-%m-%d %H:%i:%s')) < vl_result_validity;

    IF (is_vl_valid IS FALSE) THEN
        LEAVE sp;
    END IF;

    -- The VL copies/ml result is NOT yet fetched from the central labaratory
    IF (vl_copies IS NULL ) THEN
        LEAVE sp;
    END IF;

    -- Fetch the vl_detected_id
    SELECT m.concept_id INTO vl_detected_id FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'vl_detected' AND m.obs_encounter_type_id = concept_encounter_type;

    -- Fetch the vl_not_detected_id
    SELECT m.concept_id INTO vl_not_detected_id FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'vl_not_detected' AND m.obs_encounter_type_id = concept_encounter_type;

    IF (vl_copies >= 1000) THEN
        -- If VL is > = 1000 copies/ml, the status is Not suppressed
        SET vl_result = vl_detected_id;
    ELSE
        -- If VL is < 1000 copies/ml or Undetectable, the status is Suppressed
        SET vl_result = vl_not_detected_id;
    END IF;

    -- Fetch the vl_not_detected_id
    SELECT m.concept_id INTO vl_result_id FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'vl_result' AND m.obs_encounter_type_id = concept_encounter_type;

    -- Fetch the saved computed Obs Encounter Id for this Patient
    SELECT e.encounter_id INTO computed_obs_encounter_id FROM encounter e
        WHERE e.encounter_type = computed_obs_encounter_type AND e.patient_id = patientid;

    -- Create a new computed Obs Encounter for this patient
    IF computed_obs_encounter_id IS NULL THEN

        INSERT INTO encounter(encounter_type, patient_id, encounter_datetime, creator, date_created, uuid)
            VALUES (computed_obs_encounter_type, patientid, NOW(), 1, NOW(), UUID());

        -- Set the computed obs encounter id with the newly persisted computed Obs Encounter id
        SELECT encounter_id INTO computed_obs_encounter_id FROM encounter e
            WHERE encounter_type = computed_obs_encounter_type AND e.patient_id = patientid
        ORDER BY encounter_id DESC LIMIT 1;

    END IF;

    -- check if there is already a computed obs for this concept and patient
    SELECT TRUE INTO vl_result_already_computed FROM obs o
        WHERE concept_id = vl_result_id AND encounter_id = computed_obs_encounter_id AND person_id = patientid;

    IF vl_result_already_computed IS NOT NULL AND vl_result_already_computed THEN

        UPDATE obs SET value_coded = vl_result
            WHERE concept_id = vl_result_id AND encounter_id = computed_obs_encounter_id AND person_id = patientid;
    ELSE

        INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
            VALUES (now(), vl_test_date, computed_obs_encounter_id, patientid, vl_result_id, vl_result, uuid(), 1);
    END IF;

END;
//

DELIMITER ;