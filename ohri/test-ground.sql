-- The PLAN --

-- Select ALL columns from metadata belonging to a given report name
-- Select column_name, uuid where report_name='fact_hts'
-- iterate over these instead of using column_number
-- TODO: extract the datatype case statement check into a function that takes cm.concept_datatype & returns the obs value column

-- TRIAL ONE - Using Sub-Selects - No Function
SET session group_concat_max_len = 20000;-- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
SET @sql = NULL;
SET @sub_select_sql = NULL;
SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
SET @report_name = 'fact_hts';

SELECT
     GROUP_CONCAT(
        CONCAT('(SELECT (CASE cm.concept_datatype
                        WHEN ''Text'' THEN eo.obs_value_text
                        WHEN ''Coded'' THEN eo.obs_value_text
                        WHEN ''N/A'' THEN eo.obs_value_text
                        WHEN ''Boolean'' THEN eo.obs_value_text
                        WHEN ''Date'' THEN eo.obs_value_datetime
                        WHEN ''Numeric'' THEN eo.obs_value_numeric
               END)
            FROM mamba_z_encounter_obs eo
                INNER JOIN mamba_dim_concept_metadata cm ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
            WHERE eo.encounter_id = o.encounter_id
                AND cm.column_label = ''', column_label, '''
            ORDER BY eo.obs_datetime DESC
            LIMIT 1) AS ''', column_label, ''' ')) INTO @sub_select_sql
FROM mamba_dim_concept_metadata
    WHERE report_name = @report_name;

SET @sql = CONCAT(
        'SELECT o.encounter_id, o.person_id AS client_id,
            ', @sub_select_sql, '
        FROM mamba_z_encounter_obs o
        WHERE o.encounter_type_uuid IN (''', @encounter_type_uuid, ''')
        GROUP BY o.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


-- TRIAL TWO - Using Sub-selects - with function --
SET session group_concat_max_len = 20000;-- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
SET @sql = NULL;
SET @sub_select_sql = NULL;
SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
SET @report_name = 'fact_hts';

SELECT
     GROUP_CONCAT(
        CONCAT('(SELECT ',fn_get_obs_value_column(concept_datatype), '
            FROM mamba_z_encounter_obs eo
                INNER JOIN mamba_dim_concept_metadata cm ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
            WHERE eo.encounter_id = o.encounter_id
                AND cm.column_label = ''', column_label, '''
            ORDER BY eo.obs_datetime DESC
            LIMIT 1) AS ''', column_label, ''' ')) INTO @sub_select_sql
FROM mamba_dim_concept_metadata
    WHERE report_name = @report_name;

SET @sql = CONCAT(
        'SELECT o.encounter_id, o.person_id AS client_id, ', @sub_select_sql, '
        FROM mamba_z_encounter_obs o
        WHERE o.encounter_type_uuid IN (''', @encounter_type_uuid, ''')
        GROUP BY o.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



-- TRIAL THREE - Using MAX - No Function --
SET session group_concat_max_len = 20000; -- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
SET @sql := NULL;
SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
SET @report_name = 'fact_hts';
SET @obs_check = 'CASE concept_datatype
                        WHEN ''Text'' THEN eo.obs_value_text
                        WHEN ''Coded'' THEN eo.obs_value_text
                        WHEN ''N/A'' THEN eo.obs_value_text
                        WHEN ''Boolean'' THEN eo.obs_value_text
                        WHEN ''Date'' THEN eo.obs_value_datetime
                        WHEN ''Numeric'' THEN eo.obs_value_numeric
               END';

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', @obs_check, ' END) ', column_label)
  ) INTO @sql
FROM mamba_dim_concept_metadata
    WHERE report_name = @report_name;;

SET @sql = CONCAT(
        'SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
        FROM mamba_z_encounter_obs eo
            INNER JOIN mamba_dim_concept_metadata cm ON IF(cm.concept_answer_obs=1, cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
        WHERE eo.encounter_type_uuid = ''', @encounter_type_uuid, '''
        GROUP BY eo.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



-- TRIAL FOUR - Using MAX - with Function --

    SET session group_concat_max_len = 20000; -- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
    SET @sql := NULL;
    SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
    SET @report_name = 'fact_hts';
    SET @output_table_name = 'fact_hts';

    SET @drop_table = CONCAT('DROP TABLE IF EXISTS `', @output_table_name, '`');

    SELECT
      GROUP_CONCAT(DISTINCT
        CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', fn_get_obs_value_column(concept_datatype), ' END) ', column_label)
      ) INTO @sql
    FROM mamba_dim_concept_metadata
        WHERE report_name = @report_name;;

    SET @create_table = CONCAT(
            'CREATE TABLE `', @output_table_name ,'` SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
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


-- TODO:
-- SELECT INTO table_name hts_facts
-- Add extra param to capture table_name
-- Create procedure to call above code
-- Work on scripts under the xf-system





-- select tables
SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema='analysis';
-- select views
SELECT table_name FROM information_schema.tables WHERE table_type = 'VIEW' AND table_schema='analysis';
-- select functions
SELECT * FROM information_schema.routines WHERE routine_type = 'FUNCTION' AND routine_schema = 'analysis';
-- select procedures
SELECT routine_name FROM information_schema.routines WHERE routine_type = 'PROCEDURE' AND routine_schema = 'analysis';



SHOW tables;

SHOW FULL TABLES;