DELIMITER //

DROP PROCEDURE IF EXISTS sp_flatten_encounter;

CREATE PROCEDURE sp_flatten_encounter(
    IN report NVARCHAR(255),
    IN output_table_name NVARCHAR(255),
    IN encounter_type_uuid NVARCHAR(255)
)
BEGIN

    SET session group_concat_max_len = 20000;
    SET @sql := NULL;
    SET @report_nm = report;

    SET @drop_table = CONCAT('DROP TABLE IF EXISTS `', output_table_name, '`');

    SELECT
      GROUP_CONCAT(DISTINCT
        CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', fn_get_obs_value_column(concept_datatype), ' END) ', column_label)
      ) INTO @sql
    FROM mamba_dim_concept_metadata
        WHERE report_name = @report_nm;

    SET @create_table = CONCAT(
            'CREATE TABLE `', output_table_name ,'` SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
            FROM mamba_z_encounter_obs eo
                INNER JOIN mamba_dim_concept_metadata cm
                ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
            WHERE eo.encounter_type_uuid = ''', encounter_type_uuid, '''
            AND cm.report_name = ''', report, '''
            GROUP BY eo.encounter_id;');

    PREPARE deletetb FROM @drop_table;
    PREPARE createtb FROM @create_table;

    EXECUTE deletetb;
    EXECUTE createtb;

    DEALLOCATE PREPARE deletetb;
    DEALLOCATE PREPARE createtb;

END//

DELIMITER ;