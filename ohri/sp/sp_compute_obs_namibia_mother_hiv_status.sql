DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_namibia_mother_hiv_status;

CREATE PROCEDURE sp_compute_obs_namibia_mother_hiv_status(IN encounterid INT,
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

    DECLARE computed_obs_concept INT;
    DECLARE computed_obs_value_curr INT;
    DECLARE computed_obs_value_new INT;

    DECLARE ptracker_id_concept INT;
    DECLARE ptracker_id_value NVARCHAR(20);

    DECLARE hiv_positive INT;
    DECLARE hiv_negative INT;
    DECLARE hiv_status_unknown INT;
    DECLARE hiv_status_missing INT;
    DECLARE previously_known_hiv_positive INT;
    DECLARE hiv_test_done_in_this_visit INT;
    DECLARE hiv_test_not_done_in_this_visit INT;

    DECLARE hiv_test_result INT;
    DECLARE hiv_test_status_answer INT;

    -- Initialise all relevant variables
    SELECT m.computed_obs_encounter_type_id,
           m.obs_encounter_type_id,
           m.compute_procedure_name,
           m.concept_label,
           e.encounter_type
    INTO computed_obs_encounter_type, concept_encounter_type, compute_procedure, concept_label, request_encounter_type
    FROM mamba_obs_compute_metadata m
             INNER JOIN encounter e ON m.obs_encounter_type_id = e.encounter_type
    WHERE e.encounter_id = encounterid
      AND e.patient_id = patientid
      AND m.concept_id = conceptid;

    -- Don't Compute if obs is not computable (i.e. we didn't find a procedure name)
    -- If above result returns empty/null, exit
    IF (compute_procedure IS NULL) THEN
        LEAVE sp;
    END IF;

    -- Init the corresponding pTrackerId obs ID concept
    SELECT m.concept_id
    INTO ptracker_id_concept
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'ptracker_id';

    -- Init the corresponding pTrackerId obs ID Value
    SELECT o.value_text
    INTO ptracker_id_value
    FROM obs o
    WHERE o.concept_id = ptracker_id_concept
      AND o.encounter_id = encounterid
      AND o.person_id = patientid
      AND o.voided = 0;

    -- Fetch the saved computed Obs Encounter Id (for PMTCT computed obs Encounter type) for this Patient
    SELECT DISTINCT (e.encounter_id)
    INTO computed_obs_encounter_id
    FROM obs o
             INNER JOIN encounter e on o.encounter_id = e.encounter_id
    WHERE e.encounter_type = computed_obs_encounter_type
      AND e.patient_id = patientid
      AND o.concept_id = ptracker_id_concept
      AND o.value_text = ptracker_id_value
      AND o.voided = 0;

    -- Create a new computed Obs Encounter for this patient (if none exists)
    IF computed_obs_encounter_id IS NULL THEN

        SET @encounter_uuid = UUID();

        INSERT INTO encounter(encounter_type, patient_id, encounter_datetime, creator, date_created, uuid)
        VALUES (computed_obs_encounter_type, patientid, NOW(), 1, NOW(), @encounter_uuid);

        -- Fetch the newly persisted encounter Id
        SELECT encounter_id
        INTO computed_obs_encounter_id
        FROM encounter
        WHERE uuid = @encounter_uuid;

    END IF;

    -- Init computed obs ID - computed_mother_hiv_status
    SELECT m.concept_id
    INTO computed_obs_concept
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'computed_mother_hiv_status';

    -- Fetch the currently stored computed Obs for the Mother's HIV status Value that was previously computed (if any) for this Patient
    SELECT o.value_coded
    INTO computed_obs_value_curr
    FROM obs o
    WHERE o.encounter_id = computed_obs_encounter_id
      AND o.concept_id = computed_obs_concept
      AND o.person_id = patientid
      AND o.value_coded IS NOT NULL
      AND o.voided = 0
    ORDER BY obs_id DESC
    LIMIT 1;

    -- Init hiv_positive
    SELECT DISTINCT (m.concept_id)
    INTO hiv_positive
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_positive'
      and m.obs_encounter_type_id IS NULL;

    -- This Patient already has a computed 'HIV Positive' computed_mother_hiv_status
    IF (computed_obs_value_curr = hiv_positive) THEN
        LEAVE sp;
    END IF;

    -- Init previously_known_hiv_positive
    SELECT DISTINCT (m.concept_id)
    INTO previously_known_hiv_positive
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'previously_known_hiv_positive'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_test_done_in_this_visit
    SELECT DISTINCT (m.concept_id)
    INTO hiv_test_done_in_this_visit
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_test_done_in_this_visit'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_test_not_done_in_this_visit
    SELECT DISTINCT (m.concept_id)
    INTO hiv_test_not_done_in_this_visit
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_test_not_done_in_this_visit'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_test_result
    SELECT DISTINCT (m.concept_id)
    INTO hiv_test_result
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_test_result'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_status_unknown
    SELECT DISTINCT (m.concept_id)
    INTO hiv_status_unknown
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_status_unknown'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_status_missing
    SELECT DISTINCT (m.concept_id)
    INTO hiv_status_missing
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_status_missing'
      and m.obs_encounter_type_id IS NULL;

    -- Init hiv_negative
    SELECT DISTINCT (m.concept_id)
    INTO hiv_negative
    FROM mamba_obs_compute_metadata m
    WHERE m.concept_label = 'hiv_negative'
      and m.obs_encounter_type_id IS NULL;

    -- Fetch the Response to the HIV Test performed obs question in this Encounter
    SELECT o.value_coded
    INTO hiv_test_status_answer
    FROM obs o
    WHERE o.concept_id = conceptid
      AND o.encounter_id = encounterid
      AND o.person_id = patientid
      AND o.voided = 0
    ORDER BY obs_id DESC
    LIMIT 1;

    -- Set 'UNKNOWN' if (Not tested for HIV during this visit)
    IF (hiv_test_status_answer = hiv_test_not_done_in_this_visit) THEN
        SET computed_obs_value_new = hiv_status_unknown;
    END IF;

    -- Set 'MISSING' if (Missing)
    IF (hiv_test_status_answer = hiv_status_missing) THEN
        SET computed_obs_value_new = hiv_status_missing;
    END IF;

    -- Set 'PREV. +VE' if (Previously known Positive)
    IF (hiv_test_status_answer = previously_known_hiv_positive) THEN
        SET computed_obs_value_new = previously_known_hiv_positive;
    END IF;

    -- If no status is computed no need to proceed
    IF (computed_obs_value_new IS NULL) THEN
        LEAVE sp;
    END IF;

    -- If similar status no need to proceed
    IF (computed_obs_value_new = computed_obs_value_curr) THEN
        LEAVE sp;
    END IF;

    -- Insert/Update computed Obs Status
    IF (computed_obs_value_curr IS NULL) THEN

        -- Mother hiv status computed Obs
        INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_coded, uuid, creator)
        VALUES (NOW(), NOW(), computed_obs_encounter_id, patientid, computed_obs_concept, computed_obs_value_new,
                UUID(), 1);

        -- ptracker Id
        INSERT INTO obs(date_created, obs_datetime, encounter_id, person_id, concept_id, value_text, uuid, creator)
        VALUES (NOW(), NOW(), computed_obs_encounter_id, patientid, ptracker_id_concept, ptracker_id_value, UUID(), 1);

    ELSE
        UPDATE obs
        SET value_coded = computed_obs_value_new
        WHERE concept_id = computed_obs_concept
          AND encounter_id = computed_obs_encounter_id
          AND person_id = patientid;
    END IF;

END;
//

DELIMITER ;

