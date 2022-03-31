DELIMITER //

DROP PROCEDURE IF EXISTS sp_flat_encounter_table_create;

CREATE PROCEDURE sp_flat_encounter_table_create(
    IN report NVARCHAR(255),
    IN output_table_name NVARCHAR(255)
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
            'CREATE TABLE `', output_table_name ,'` SELECT encounter_id, person_id AS client_id, ', @sql, '
            FROM mamba_z_encounter_obs limit 0;');

    PREPARE deletetb FROM @drop_table;
    PREPARE createtb FROM @create_table;

    EXECUTE deletetb;
    EXECUTE createtb;

    DEALLOCATE PREPARE deletetb;
    DEALLOCATE PREPARE createtb;

END//

DELIMITER ;