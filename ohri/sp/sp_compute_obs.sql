DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs;

CREATE PROCEDURE sp_compute_obs(
    IN procedure_name VARCHAR(50),
    IN obs_encounter_id INT,
    IN obs_concept_id INT,
    IN person_id INT
)
BEGIN
    SET @compute_obs_procedure_sql = CONCAT('CALL ', procedure_name, '(?,?,?);');
    SET @obs_encounter_id = obs_encounter_id;
    SET @obs_concept_id = obs_concept_id;
    SET @person_id = person_id;

    PREPARE prepared_statement FROM @compute_obs_procedure_sql;
    EXECUTE prepared_statement USING @obs_encounter_id, @obs_concept_id, @person_id;
    DEALLOCATE PREPARE prepared_statement;
END;
//

DELIMITER ;
