DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_queue_insert;

CREATE PROCEDURE sp_compute_obs_queue_insert(
    IN obs_encounter_id INT,
    IN obs_concept_id INT,
    IN person_id INT
)
BEGIN

    DECLARE compute_sp_name NVARCHAR(50);
    DECLARE compute_status TINYINT;

    DECLARE done INT DEFAULT FALSE;
    DECLARE cursor_affected_computations CURSOR FOR
        SELECT compute_procedure_name
        FROM mamba_obs_compute_metadata
        WHERE concept_id = obs_concept_id
          AND compute_procedure_name IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_affected_computations;
    get_computation:
    LOOP

        FETCH cursor_affected_computations INTO compute_sp_name;

        IF done THEN
            LEAVE get_computation;
        END IF;

        SELECT s.computed
        INTO compute_status
        FROM mamba_computed_obs_queue s
        WHERE s.compute_procedure_name = compute_sp_name
          AND s.patient_id = person_id
          AND s.encounter_id = obs_encounter_id
          AND s.concept_id = obs_concept_id;

        IF compute_status IS NULL THEN
            INSERT INTO mamba_computed_obs_queue(patient_id, concept_id, encounter_id, compute_procedure_name)
            VALUES (person_id, obs_concept_id, obs_encounter_id, compute_sp_name);

        ELSEIF compute_status = 1 THEN
            UPDATE mamba_computed_obs_queue s
            SET s.computed = 0
            WHERE s.compute_procedure_name = compute_sp_name
              AND s.patient_id = person_id
              AND s.encounter_id = obs_encounter_id
              AND s.concept_id = obs_concept_id;

        END IF;

    END LOOP get_computation;
    CLOSE cursor_affected_computations;

END;
//

DELIMITER ;