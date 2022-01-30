
-- START HERE -----
DROP TABLE IF EXISTS base_z_obs_value_text;

CREATE TABLE base_z_obs_value_text
SELECT
	zeo.encounter_id,
    zeo.person_id,
	zeo.obs_answer_uuid,
	cm.column_label,
	zeo.obs_value_text
FROM
	base_z_encounter_obs zeo
INNER JOIN
	base_dim_concept_metadata cm
	ON cm.concept_uuid = zeo.obs_answer_uuid
WHERE
	cm.concept_datatype IN ('Text', 'Coded');

-- ISSUE: Query has an issue - means we have to Have ALL concept answers in the metadata table

select * from base_z_obs_value_text;




-- -----
DROP TABLE IF EXISTS base_z_obs_value_numeric;

CREATE TABLE base_z_obs_value_numeric
SELECT
	zeo.encounter_id,
	zeo.obs_answer_uuid,
	cm.column_label,
	zeo.obs_value_numeric
FROM
	base_z_encounter_obs zeo
INNER JOIN
	base_dim_concept_metadata cm
	ON cm.concept_uuid = zeo.obs_answer_uuid
WHERE
	cm.concept_datatype IN ('Numeric');



-- -----
DROP TABLE IF EXISTS base_z_obs_value_datetime;

CREATE TABLE base_z_obs_value_datetime
SELECT
	zeo.encounter_id,
	zeo.obs_answer_uuid,
	cm.column_label,
	zeo.obs_value_datetime
FROM
	base_z_encounter_obs zeo
INNER JOIN
	base_dim_concept_metadata cm
	ON cm.concept_uuid = zeo.obs_answer_uuid
WHERE
	cm.concept_datatype IN ('Date');

select * from base_dim_concept_metadata ;



-- z_vt ---------------
DROP TABLE IF EXISTS z_vt;
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when column_label = ''',
      column_label,
      ''' then obs_value_text end) ',
      column_label
    )
  ) INTO @sql
FROM
  base_z_obs_value_text;

SET @sql = CONCAT('CREATE TABLE IF NOT EXISTS z_vt SELECT encounter_id, person_id, ', @sql, '
                    FROM base_z_obs_value_text
                    GROUP BY encounter_id'); -- Maybe here we should be able to filter which columns we want based on the report needed

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


-- z_vn---------------
DROP TABLE IF EXISTS z_vn;
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when column_label = ''',
      column_label,
      ''' then obs_value_numeric end) ',
      column_label
    )
  ) INTO @sql
FROM
  base_z_obs_value_numeric;

SET @sql = CONCAT('CREATE TABLE IF NOT EXISTS z_vn SELECT encounter_id as encounter_id_n, ', @sql, '
                    FROM base_z_obs_value_numeric
                    GROUP BY encounter_id_n'); -- Maybe here we should be able to filter which columns we want based on the report needed

PREPARE stmt2 FROM @sql;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;


-- z_vd---------------
DROP TABLE IF EXISTS z_vd;
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when column_label = ''',
      column_label,
      ''' then obs_value_datetime end) ',
      column_label
    )
  ) INTO @sql
FROM
  base_z_obs_value_date;

SET @sql = CONCAT('CREATE TABLE IF NOT EXISTS z_vd SELECT encounter_id as encounter_id_d, ', @sql, '
                    FROM base_z_obs_value_date
                    GROUP BY encounter_id_d'); -- Maybe here we should be able to filter which columns we want based on the report needed

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ISSUE: If Records are NULL or empty, query throws up
-- sql to generate sql in 2 statements (to generate table & to fill it) OR use a select & INSERT INTO (in 1 statement)

-- ----------------
DROP TABLE IF EXISTS test_facts;
CREATE TABLE test_facts
SELECT
	z_vt.*,
	z_vd.*,
    z_vn.*
FROM
	z_vt
INNER JOIN
	z_vd ON z_vt.encounter_id = z_vd.encounter_id_d
INNER JOIN
	z_vn ON z_vt.encounter_id = z_vn.encounter_id_n

-- GROUP BY encounter_id
;

-- ISSUE: Joining without encounter_id (If I add encounter Id to all, we've duplicate column Errors)
-- z_vt, z_vd & z_vn eliminate NULL values so can't join with encounter id since tables are not proportional

















SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when column_label = ''',
      column_label,
      ''' then obs_value_text end) ',
      column_label
    )
  )
FROM
  base_z_obs_value_text;


SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when column_label = ''',
      column_label,
      ''' then obs_value_numeric end) ',
      column_label
    )
  )
FROM
  base_z_obs_value_numeric;



SELECT
       encounter_id,
        max(case when column_label = 'key_pop_AGYW' then obs_value_text end) key_pop_AGYW,
        max(case when column_label = 'key_pop_fisher_folk' then obs_value_text end) key_pop_fisher_folk,
        max(case when column_label = 'key_pop_fsw' then obs_value_text end) key_pop_fsw,
        max(case when column_label = 'key_pop_migrant_worker' then obs_value_text end) key_pop_migrant_worker,
        max(case when column_label = 'key_pop_prisoners' then obs_value_text end) key_pop_prisoners,
        max(case when column_label = 'key_pop_pwd' then obs_value_text end) key_pop_pwd,
        max(case when column_label = 'key_pop_pwid' then obs_value_text end) key_pop_pwid,
        max(case when column_label = 'key_pop_refugees' then obs_value_text end) key_pop_refugees,
        max(case when column_label = 'key_pop_transgender' then obs_value_text end) key_pop_transgender,
        max(case when column_label = 'key_pop_uniformed_forces' then obs_value_text end) key_pop_uniformed_forces
FROM base_z_obs_value_text
GROUP BY encounter_id;


-- END HERE -----




-- THE IDEA --------


DROP TABLE IF EXISTS z_vd;
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('max(case when column_label = ''', column_label, ''' then obs_value_datetime end) ', column_label)
  ) INTO @sql
FROM
  base_z_obs_value_date;

SET @sql = CONCAT('CREATE TABLE IF NOT EXISTS z_vd SELECT encounter_id as encounter_id_d, ', @sql, '
                    FROM base_z_obs_value_date
                    GROUP BY encounter_id_d'); -- Maybe here we should be able to filter which columns we want based on the report needed

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



    -- The PLAN --

-- Select ALL columns from metadata belonging to a given report name
-- Select column_name, uuid where report_name='fact_hts'
-- iterate over these instead of using column_number
-- TODO: extract the datatype case statement check into a function that takes cm.concept_datatype & returns the obs value column

-- TRIAL ONE --
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
                        WHEN ''Date'' THEN eo.obs_value_datetime
                        WHEN ''Numeric'' THEN eo.obs_value_numeric
               END)
            FROM base_z_encounter_obs eo
                INNER JOIN base_dim_concept_metadata cm ON cm.concept_uuid = eo.obs_question_uuid
            WHERE eo.encounter_id = o.encounter_id
                AND cm.column_label = ''', column_label, '''
            ORDER BY eo.obs_datetime DESC
            LIMIT 1) AS ''', column_label, ''' ')) INTO @sub_select_sql
FROM base_dim_concept_metadata
    WHERE report_name = @report_name;

SET @sql = CONCAT(
        'SELECT o.encounter_id, o.person_id AS client_id,
            ', @sub_select_sql, '
        FROM base_z_encounter_obs o
        WHERE o.encounter_type_uuid IN (''', @encounter_type_uuid, ''')
        GROUP BY o.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



-- TRIAL TWO --
SET session group_concat_max_len = 20000; -- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
SET @sql := NULL;
SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
SET @report_name = 'fact_hts';
SET @obs_check = 'CASE concept_datatype
                        WHEN ''Text'' THEN eo.obs_value_text
                        WHEN ''Coded'' THEN eo.obs_value_text
                        WHEN ''Date'' THEN eo.obs_value_datetime
                        WHEN ''Numeric'' THEN eo.obs_value_numeric
               END';

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', @obs_check, ' END) ', column_label)
  ) INTO @sql
FROM base_dim_concept_metadata
    WHERE report_name = @report_name;;

SET @sql = CONCAT(
        'SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
        FROM base_z_encounter_obs eo
            INNER JOIN base_dim_concept_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
        WHERE eo.encounter_type_uuid = ''', @encounter_type_uuid, '''
        GROUP BY eo.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


-- TRIAL THREE --
SET session group_concat_max_len = 20000; -- to prevent truncating of group_concat results Rd: https://logic.edchen.org/how-to-resolve-returned-string-that-was-truncated-by-mysql/
SET @sql := NULL;
SET @encounter_type_uuid = '79c1f50f-f77d-42e2-ad2a-d29304dde2fe';
SET @report_name = 'fact_hts';

CREATE FUNCTION fn_get_obs_value_column(conceptDatatype VARCHAR(20)) RETURNS VARCHAR(20)
    DETERMINISTIC
BEGIN
    DECLARE obsValueColumn VARCHAR(20);

    IF (conceptDatatype = 'Text' OR conceptDatatype = 'Coded') THEN
        SET obsValueColumn = 'obs_value_text';
    ELSEIF conceptDatatype = 'Date' THEN
        SET obsValueColumn = 'obs_value_datetime';
    ELSEIF conceptDatatype = 'Numeric' THEN
        SET obsValueColumn = 'obs_value_numeric';
    END IF;

    RETURN (obsValueColumn);
END;

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ', fn_get_obs_value_column(concept_datatype), ' END) ', column_label)
  ) INTO @sql
FROM base_dim_concept_metadata
    WHERE report_name = @report_name;;

SET @sql = CONCAT(
        'SELECT eo.encounter_id, eo.person_id AS client_id, ', @sql, '
        FROM base_z_encounter_obs eo
            INNER JOIN base_dim_concept_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
            INNER JOIN base_dim_concept_metadata cm ON IF(cm.concept_datatype=''Coded'', cm.concept_uuid=eo.obs_value_coded_uuid, cm.concept_uuid=eo.obs_question_uuid)
        WHERE eo.encounter_type_uuid = ''', @encounter_type_uuid, '''
        GROUP BY eo.encounter_id');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;








select * from openmrs_working.concept where uuid='e407ad47-0efd-4429-ab6b-3506dbf9580a';
select cn.name, ca.concept_id, ca.answer_concept, ca.uuid from openmrs_working.concept_answer ca inner join openmrs_working.concept_name cn on ca.concept_id=cn.concept_id where ca.concept_id='993';
select * from openmrs_working.concept_answer where concept_id='970';

select * from openmrs_working.concept_answer where answer_concept='30'; -- Fisher Folk

SELECT cn.name AS 'question_name',
       (SELECT MAX(name) from openmrs_working.concept_name where concept_id= ca.answer_concept) AS 'answer_name',
       ca.concept_id,
       ca.answer_concept
FROM openmrs_working.concept_answer ca
    INNER JOIN openmrs_working.concept_name cn on ca.concept_id=cn.concept_id
WHERE ca.concept_id='108';


SELECT cn.name AS 'question_name',
       (SELECT MAX(name) from openmrs_working.concept_name where concept_id= ca.answer_concept) AS 'answer_name',
       ca.concept_id,
       ca.answer_concept
FROM openmrs_working.concept_answer ca
    INNER JOIN openmrs_working.concept_name cn on ca.answer_concept=cn.concept_id
    INNER JOIN openmrs_working.concept c on ca.answer_concept=c.concept_id
WHERE cn.locale_preferred='1'
AND cn.locale='en'
AND c.datatype_id='2';



select * from openmrs_working.concept c
    INNER JOIN openmrs_working.concept_name cn on c.concept_id=cn.concept_id
where c.concept_id='30'; -- Sex Worker

SELECT *
    FROM openmrs_working.concept_answer ca
WHERE ca.answer_concept in (SELECT ca.concept_id FROM openmrs_working.concept_answer);

max(case when column_label = 'key_pop_fisher_folk' then obs_value_text end) key_pop_fisher_folk
MAX(if(cm.column_number = 1, eo.obs_value_text, NULL)),


SET @sql = CONCAT('SELECT encounter_id, person_id AS client_id, ', @sql, '
                    FROM base_z_obs_value_text
                    GROUP BY encounter_id');



 SELECT
        eo.encounter_id,
        eo.person_id AS client_id,
         max(case WHEN column_label = 'community_service_point' THEN (
             CASE concept_datatype
                        WHEN 'Text' THEN eo.obs_value_text
                        WHEN 'Coded' THEN eo.obs_value_text
                        WHEN 'Date' THEN eo.obs_value_datetime
                        WHEN 'Numeric' THEN eo.obs_value_numeric
               END)
             END) community_service_point,
         max(case when column_label = 'date_test_conducted' then eo.obs_value_text end) date_test_conducted,
         max(case when column_label = 'facility_service_point' then eo.obs_value_text end) facility_service_point,
         max(case when column_label = 'hts_approach' then eo.obs_value_text end) hts_approach,
         max(case when column_label = 'initial_kit_name' then eo.obs_value_text end) initial_kit_name,
         max(case when column_label = 'key_pop_AGYW' then eo.obs_value_text end) key_pop_AGYW,
         max(case when column_label = 'key_pop_fisher_folk' then eo.obs_value_text end) key_pop_fisher_folk,
         max(case when column_label = 'key_pop_fsw' then eo.obs_value_text end) key_pop_fsw,
         max(case when column_label = 'key_pop_migrant_worker' then eo.obs_value_text end) key_pop_migrant_worker,
         max(case when column_label = 'key_pop_msm' then eo.obs_value_text end) key_pop_msm,
         max(case when column_label = 'key_pop_prisoners' then eo.obs_value_text end) key_pop_prisoners,
         max(case when column_label = 'key_pop_pwd' then eo.obs_value_text end) key_pop_pwd,
         max(case when column_label = 'key_pop_pwid' then eo.obs_value_text end) key_pop_pwid,
         max(case when column_label = 'key_pop_refugees' then eo.obs_value_text end) key_pop_refugees,
         max(case when column_label = 'key_pop_transgender' then eo.obs_value_text end) key_pop_transgender,
         max(case when column_label = 'key_pop_truck_driver' then eo.obs_value_text end) key_pop_truck_driver,
         max(case when column_label = 'key_pop_type' then eo.obs_value_text end) key_pop_type,
         max(case when column_label = 'key_pop_uniformed_forces' then eo.obs_value_text end) key_pop_uniformed_forces,
         max(case when column_label = 'last_viral_load' then eo.obs_value_text end) last_viral_load,
         max(case when column_label = 'pop_type' then eo.obs_value_text end) pop_type,
         max(case when column_label = 'sexually_active' then eo.obs_value_text end) sexually_active,
         max(case when column_label = 'test_setting' then eo.obs_value_text end) test_setting

    FROM analysis.z_encounter_obs eo
    INNER JOIN base_dim_concept_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_type_uuid='79c1f50f-f77d-42e2-ad2a-d29304dde2fe'
    GROUP BY eo.encounter_id;



 max(case when column_label = 'community_service_point' then eo.obs_value_text end) community_service_point,
 max(case when column_label = 'date_test_conducted' then eo.obs_value_text end) date_test_conducted,
 max(case when column_label = 'facility_service_point' then eo.obs_value_text end) facility_service_point,
 max(case when column_label = 'hts_approach' then eo.obs_value_text end) hts_approach,
 max(case when column_label = 'initial_kit_name' then eo.obs_value_text end) initial_kit_name,
 max(case when column_label = 'key_pop_type' then eo.obs_value_text end) key_pop_type,
 max(case when column_label = 'last_viral_load' then eo.obs_value_text end) last_viral_load,
 max(case when column_label = 'pop_type' then eo.obs_value_text end) pop_type,
 max(case when column_label = 'sexually_active' then eo.obs_value_text end) sexually_active,
 max(case when column_label = 'test_setting' then eo.obs_value_text end) test_setting


 max(case when column_label = 'community_service_point' then eo.obs_value_text end) community_service_point,
 max(case when column_label = 'date_test_conducted' then eo.obs_value_text end) date_test_conducted,
 max(case when column_label = 'facility_service_point' then eo.obs_value_text end) facility_service_point,
 max(case when column_label = 'hts_approach' then eo.obs_value_text end) hts_approach,
 max(case when column_label = 'initial_kit_name' then eo.obs_value_text end) initial_kit_name,
 max(case when column_label = 'key_pop_AGYW' then eo.obs_value_text end) key_pop_AGYW,
 max(case when column_label = 'key_pop_fisher_folk' then eo.obs_value_text end) key_pop_fisher_folk,
 max(case when column_label = 'key_pop_fsw' then eo.obs_value_text end) key_pop_fsw,
 max(case when column_label = 'key_pop_migrant_worker' then eo.obs_value_text end) key_pop_migrant_worker,
 max(case when column_label = 'key_pop_msm' then eo.obs_value_text end) key_pop_msm,
 max(case when column_label = 'key_pop_prisoners' then eo.obs_value_te


  max(case when column_label = 'community_service_point' then eo.obs_value_text end) community_service_point,
 max(case when column_label = 'date_test_conducted' then eo.obs_value_text end) date_test_conducted,
 max(case when column_label = 'facility_service_point' then eo.obs_value_text end) facility_service_point,
 max(case when column_label = 'hts_approach' then eo.obs_value_text end) hts_approach,
 max(case when column_label = 'initial_kit_name' then eo.obs_value_text end) initial_kit_name,
 max(case when column_label = 'key_pop_AGYW' then eo.obs_value_text end) key_pop_AGYW,
 max(case when column_label = 'key_pop_fisher_folk' then eo.obs_value_text end) key_pop_fisher_folk,
 max(case when column_label = 'key_pop_fsw' then eo.obs_value_text end) key_pop_fsw,
 max(case when column_label = 'key_pop_migrant_worker' then eo.obs_value_text end) key_pop_migrant_worker,
 max(case when column_label = 'key_pop_msm' then eo.obs_value_text end) key_pop_msm,
 max(case when column_label = 'key_pop_prisoners' then eo.obs_value_text end) key_pop_prisoners,
 max(case when column_label = 'key_pop_pwd' then eo.obs_value_text end) key_pop_pwd,
 max(case when column_label = 'key_pop_pwid' then eo.obs_value_text end) key_pop_pwid,
 max(case when column_label = 'key_pop_refugees' then eo.obs_value_text end) key_pop_refugees,
 max(case when column_label = 'key_pop_transgender' then eo.obs_value_text end) key_pop_transgender,
 max(case when column_label = 'key_pop_truck_driver' then eo.obs_value_text end) key_pop_truck_driver,
 max(case when column_label = 'key_pop_type' then eo.obs_value_text end) key_pop_type,
 max(case when column_label = 'key_pop_uniformed_forces' then eo.obs_value_text end) key_pop_uniformed_forces,
 max(case when column_label = 'last_viral_load' then eo.obs_value_text end) last_viral_load,
 max(case when column_label = 'pop_type' then eo.obs_value_text end) pop_type,
 max(case when column_label = 'sexually_active' then eo.obs_value_text end) sexually_active,
 max(case when column_label = 'test_setting' then eo.obs_value_text end) test_setting

select * from base_dim_concept_metadata;

(SELECT (CASE cm.concept_datatype
            WHEN 'Text' THEN eo.obs_value_text
            WHEN 'Coded' THEN eo.obs_value_text
            WHEN 'Date' THEN eo.obs_value_datetime
            WHEN 'Numeric' THEN eo.obs_value_numeric
        END)
FROM base_z_encounter_obs eo
INNER JOIN base_dim_concept_metadata cm ON cm.concept_uuid= IF(cm.concept_datatype = 'Coded', eo.obs_value_coded_uuid, eo.obs_question_uuid)
WHERE eo.encounter_id=o.encounter_id and cm.column_number = 7
ORDER BY eo.obs_datetime DESC LIMIT 1)










