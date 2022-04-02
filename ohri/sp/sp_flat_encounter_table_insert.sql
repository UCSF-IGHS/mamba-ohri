DELIMITER //

DROP PROCEDURE IF EXISTS sp_flat_encounter_table_insert;

CREATE PROCEDURE sp_flat_encounter_table_insert(
    IN flat_encounter_table_name NVARCHAR(255)
)
BEGIN

    SET session group_concat_max_len = 20000;

    SET @column_labels = (SELECT GROUP_CONCAT(COLUMN_NAME SEPARATOR ', ')
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE TABLE_NAME = flat_encounter_table_name
                            AND TABLE_SCHEMA = Database());

    TRUNCATE TABLE flat_encounter_table_name;

    SET @create_table = CONCAT(
            'INSERT INTO `', flat_encounter_table_name, '` SELECT ', @column_labels, '
            FROM mamba_z_encounter_obs eo
                INNER JOIN mamba_dim_concept_metadata cm
                ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
            WHERE cm.flat_table_name = ''', flat_encounter_table_name, '''
            AND eo.encounter_type_uuid = cm.encounter_type_uuid
            GROUP BY eo.encounter_id;');

    PREPARE createtb FROM @create_table;
    EXECUTE createtb;
    DEALLOCATE PREPARE createtb;

END//

DELIMITER ;