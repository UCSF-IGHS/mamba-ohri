DELIMITER //

DROP PROCEDURE IF EXISTS sp_generate_fact;

CREATE PROCEDURE sp_generate_fact(
    IN report_name NVARCHAR(100),
    IN output_table_name NVARCHAR(100)
)
BEGIN

    SET session group_concat_max_len = 20000;
    SET @sql := NULL;
    SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe'; -- put in parameter list
    SET @report_name = report_name;

    SET @drop_table = CONCAT('DROP TABLE IF EXISTS `', output_table_name, '`');

    SELECT
      GROUP_CONCAT(DISTINCT
        CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', fn_get_obs_value_column(concept_datatype), ' END) ', column_label)
      ) INTO @sql
    FROM mamba_dim_concept_metadata
        WHERE report_name = @report_name;

    SET @create_table = CONCAT(
            'CREATE TABLE `', output_table_name ,'` SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
            FROM mamba_z_encounter_obs eo
                INNER JOIN mamba_dim_concept_metadata cm ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
            WHERE eo.encounter_type_uuid = ''', @encounter_type_uuid, '''
            GROUP BY eo.encounter_id;');


    PREPARE deletetb FROM @drop_table;
    PREPARE createtb FROM @create_table;

    EXECUTE deletetb;
    EXECUTE createtb;

    DEALLOCATE PREPARE deletetb;
    DEALLOCATE PREPARE createtb;

END//

DELIMITER ;