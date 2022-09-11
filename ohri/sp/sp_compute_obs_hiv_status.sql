DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_hiv_status;

CREATE PROCEDURE sp_compute_obs_hiv_status(IN encounterid INT,
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
    DECLARE finalhiv_status INT;
    DECLARE test_result_date DATETIME DEFAULT NULL;
    DECLARE previous_test_result_date DATETIME DEFAULT NULL;
    DECLARE final_hiv_status_concept_id INT;
    DECLARE days_interval INT DEFAULT 0;
    DECLARE hiv_status INT;
    DECLARE hiv_positive_concept_id INT;
    DECLARE hiv_negative_concept_id INT;
    DECLARE hiv_unknown_concept_id INT;
    DECLARE testresult_date_difference INT DEFAULT 0;

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

     -- Fetch the FinalHIV result concept_id and the value_coded that was entered for this Encounter
    SELECT o.concept_id , o.value_coded
    INTO final_hiv_status_concept_id,finalhiv_status
    FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'final hiv test result' AND o.encounter_id = encounterid AND o.person_id = patientid
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch the saved computed Obs Encounter Id for this Patient
     SELECT e.encounter_id INTO computed_obs_encounter_id FROM encounter e
        WHERE e.encounter_type = computed_obs_encounter_type AND e.patient_id = patientid;

        -- Get conceptId that specifies the actual outcome
        SELECT
            CASE WHEN name like '%Positive%' then concept_id end as pos_con,
            CASE WHEN name like '%Negative%' then concept_id end as Neg_con,
            CASE WHEN name like '%Inconclusive%' then concept_id end as unk_con
        INTO hiv_positive_concept_id, hiv_negative_concept_id, hiv_unknown_concept_id
        FROM concept_name
            WHERE concept_id = finalhiv_status and locale ='en' and locale_preferred=1 and voided=0
            LIMIT 1;

    IF (concept_label = 'HIV test date') THEN
        SELECT value_datetime INTO test_result_date FROM obs o
            WHERE o.encounter_id = encounterid AND o.concept_id = conceptid AND o.person_id = patientid AND value_datetime IS NOT NULL
        ORDER BY obs_id DESC LIMIT 1;

        -- Fetch the saved (computed) HIV test date for this Patient
        SELECT o.obs_datetime INTO previous_test_result_date FROM obs o
            WHERE o.encounter_id = computed_obs_encounter_id AND o.concept_id = final_hiv_status_concept_id AND o.person_id = patientid -- To do:check final_hiv_status_concept_id
        ORDER BY obs_id DESC LIMIT 1;


        IF (computed_obs_encounter_id IS NULL || previous_test_result_date IS NULL) THEN -- There is NO HIV Status computed obs Encounter for this Patient

        -- Create a new computed Obs Encounter for this patient
            IF computed_obs_encounter_id IS NULL THEN

                INSERT INTO encounter(encounter_type, patient_id, encounter_datetime, creator, date_created, uuid)
                VALUES (computed_obs_encounter_type, patientid, NOW(), 1, NOW(), UUID());

                -- Set the computed obs encounter id with the newly persisted computed Obs Encounter id
                SELECT encounter_id INTO computed_obs_encounter_id FROM encounter e
                    WHERE encounter_type = computed_obs_encounter_type AND e.patient_id = patientid
                ORDER BY encounter_id DESC LIMIT 1;
            END IF;

            -- Insert the Final HIV Status  & the Date
            IF  hiv_positive_concept_id IS NOT NULL THEN
                SET hiv_status = hiv_positive_concept_id;

            ELSEIF hiv_negative_concept_id IS NOT NULL THEN

                SET days_interval = DATEDIFF(CURDATE(), STR_TO_DATE(test_result_date, '%Y-%m-%d %H:%i:%s'));

                IF (days_interval <= 90 ) THEN
                    SET hiv_status = hiv_negative_concept_id;
                ELSE
                    SET hiv_status = hiv_unknown_concept_id;
                END IF;

            ELSE
                SET hiv_status = hiv_unknown_concept_id;
            END IF;

            INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
            VALUES (now(), test_result_date, computed_obs_encounter_id, patientid, final_hiv_status_concept_id, hiv_status, uuid(), 1); -- To do:check final_hiv_status_concept_id

        ELSE
            -- Compare previously computed/stored test result date with this new test result date
            SET testresult_date_difference = DATEDIFF(test_result_date, STR_TO_DATE(previous_test_result_date, '%Y-%m-%d %H:%i:%s'));
            IF testresult_date_difference >= 0 THEN

                UPDATE obs SET value_coded = hiv_status
                WHERE concept_id = final_hiv_status_concept_id AND encounter_id = computed_obs_encounter_id AND person_id = patientid;
            END IF;

        END IF;
    end if;
END;
//

DELIMITER ;