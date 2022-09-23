DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_hiv_tx_status;

CREATE PROCEDURE sp_compute_obs_hiv_tx_status(IN encounterid INT,
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

    DECLARE status_concept INT;
    DECLARE status_value_old INT;
    DECLARE status_value_new INT;

    DECLARE deceased INT;
    DECLARE transfer_out INT;
    DECLARE interrupted INT;

    DECLARE death_date DATETIME DEFAULT NULL;
    DECLARE enrollment_date DATETIME DEFAULT NULL;
    DECLARE re_enrollment_date DATETIME DEFAULT NULL;
    DECLARE transfer_out_date DATETIME DEFAULT NULL;
    DECLARE next_appointment_date DATETIME DEFAULT NULL;

    DECLARE lost_to_followup_duration INT DEFAULT 28; -- for most recent Follow Up is > 28  days

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

    -- Init hiv_tx_status
    SELECT m.concept_id INTO status_concept FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'hiv_tx_status';

    -- Fetch the currently stored HIV TX Status Id & Value that was previously computed (if any) for this patient
    SELECT o.value_coded INTO status_value_old FROM obs o
        INNER JOIN encounter e on o.encounter_id = e.encounter_id
        WHERE o.concept_id = status_concept
          AND e.encounter_type = computed_obs_encounter_type AND o.person_id = patientid
        ORDER BY obs_id DESC LIMIT 1;

    -- Init hiv_tx_status_deceased
    SELECT m.concept_id INTO deceased FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'hiv_tx_status_deceased';

    -- This Patient already has a computed 'DECEASED' tx_status
    IF(status_value_old IS NOT NULL AND (status_value_old = deceased)) THEN
        LEAVE sp;
    END IF;

    -- Init hiv_tx_status_transferred_out
    SELECT m.concept_id INTO transfer_out FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'hiv_tx_status_transferred_out';

    -- Init hiv_tx_status_interrupted
    SELECT m.concept_id INTO interrupted FROM mamba_obs_compute_metadata m
        WHERE m.concept_label = 'hiv_tx_status_interrupted';

    -- Fetch Date of Death for Patient
    SELECT o.value_datetime INTO death_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'date_of_death'
            AND o.person_id = patientid AND o.value_datetime IS NOT NULL
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch HIV Care Enrollment Date for Patient
    SELECT o.value_datetime INTO enrollment_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'hiv_care_enrollment_date'
          AND o.person_id = patientid AND o.value_datetime IS NOT NULL
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch HIV Care Re-Enrollment Date for Patient
    SELECT o.value_datetime INTO re_enrollment_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'hiv_care_re_enrollment_date'
            AND o.person_id = patientid AND o.value_datetime IS NOT NULL
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch Transfer-Out Date for Patient
    SELECT o.value_datetime INTO transfer_out_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'date_transferred_out'
          AND o.person_id = patientid AND o.value_datetime IS NOT NULL
    ORDER BY obs_id DESC LIMIT 1;

    -- Fetch Next Appointment Date for Patient
    SELECT o.value_datetime INTO next_appointment_date FROM obs o
        INNER JOIN mamba_obs_compute_metadata m ON o.concept_id = m.concept_id
        WHERE m.concept_label = 'return_visit_date'
          AND o.person_id = patientid AND o.value_datetime IS NOT NULL
    ORDER BY obs_id DESC LIMIT 1;

    -- Set 'DECEASED' if (HIV Enrolment date is not null && Date of death is not null)
    IF(enrollment_date IS NOT NULL AND death_date IS NOT NULL) THEN
        SET status_value_new = deceased;

    -- Set 'Transfer-Out' if (HIV Enrolment date is not null && Transfer-Out Date is not null &&  Date of Re-enrolment < Transfer-Out Date)
    ELSEIF (enrollment_date IS NOT NULL AND transfer_out_date IS NOT NULL) THEN
        IF (DATEDIFF(re_enrollment_date, transfer_out_date) < 0) THEN
            SET status_value_new = transfer_out;
        END IF;

    -- Set 'Tx Interrupted' if (HIV Enrolment date is not null && Reporting date >  (Next appointment + 28  days))
    ELSEIF (enrollment_date IS NOT NULL) THEN
        IF (DATEDIFF(NOW(), next_appointment_date) > lost_to_followup_duration) THEN
            SET status_value_new = interrupted;
        END IF;

    END IF;

    INSERT INTO TEMPO_TABLE (log_value)
        VALUES (status_value_new);

    -- if no status is computed no need to proceed
     IF(status_value_new IS NULL) THEN
         LEAVE sp;
    END IF;

    -- Insert/Update computed Obs Status
    IF(status_value_old IS NULL) THEN
        INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
            VALUES (NOW(), NOW(), computed_obs_encounter_id, patientid, status_concept, status_value_new, UUID(), 1);
    ELSE
        UPDATE obs SET value_coded = status_value_new
            WHERE concept_id = status_concept AND encounter_id = computed_obs_encounter_id AND person_id = patientid;
    END IF;

END;
//

DELIMITER ;