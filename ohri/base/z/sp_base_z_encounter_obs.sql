USE analysis;

DROP TABLE IF EXISTS base_z_encounter_obs;

-- $BEGIN

CREATE TABLE base_z_encounter_obs
(
    obs_question_uuid    CHAR(38),
    obs_answer_uuid      CHAR(38),
    obs_value_coded_uuid CHAR(38),
    encounter_type_uuid  CHAR(38)
)
SELECT o.encounter_id   AS encounter_id,
       o.person_id      AS person_id,
       o.obs_datetime   AS obs_datetime,
       o.concept_id     AS obs_question_concept_id,
       o.value_text     AS obs_value_text,
       o.value_numeric  AS obs_value_numeric,
       o.value_coded    AS obs_value_coded,
       o.value_datetime AS obs_value_datetime,
       o.value_complex  AS obs_value_complex,
       o.value_drug     AS obs_value_drug,
       NULL             AS obs_question_uuid,
       NULL             AS obs_answer_uuid,
       NULL             AS obs_value_coded_uuid,
       NULL             AS encounter_type_uuid
FROM openmrs_working.obs o;


-- update obs question UUIDs
UPDATE base_z_encounter_obs z
    INNER JOIN base_dim_concept c
    ON z.obs_question_concept_id = c.external_concept_id
SET z.obs_question_uuid = c.uuid;

-- update obs answer UUIDs
UPDATE base_z_encounter_obs z
    INNER JOIN base_dim_concept c
    ON z.obs_question_concept_id = c.external_concept_id
    INNER JOIN base_dim_concept_datatype dt
    ON dt.external_datatype_id = c.external_datatype_id
SET z.obs_answer_uuid = (IF(dt.datatype_name = 'Coded',
                            (SELECT c.uuid
                             FROM base_dim_concept c
                             where c.external_concept_id = z.obs_value_coded AND z.obs_value_coded IS NOT NULL),
                            c.uuid));

-- update obs_value_coded (UUIDs & values)
UPDATE base_z_encounter_obs z
    INNER JOIN base_dim_concept_name cn
    ON z.obs_value_coded = cn.external_concept_id
    INNER JOIN base_dim_concept c
    ON z.obs_value_coded = c.external_concept_id
SET z.obs_value_text       = cn.concept_name,
    z.obs_value_coded_uuid = c.uuid
WHERE z.obs_value_coded IS NOT NULL;

-- Update the encounter type UUID
UPDATE base_z_encounter_obs z
    INNER JOIN base_dim_encounter e
    ON z.encounter_id = e.external_encounter_id
    INNER JOIN base_dim_encounter_type et
    ON e.external_encounter_type_id = et.external_encounter_type_id
SET z.encounter_type_uuid = et.encounter_type_uuid;

-- Update Key pop types to Yes/No (in Z Table)
UPDATE base_z_encounter_obs z
    INNER JOIN base_dim_concept_metadata cm
    ON cm.concept_uuid = z.obs_value_coded_uuid
SET z.obs_value_text = IF(z.obs_value_coded IS NOT NULL, 'Yes', 'No')
WHERE cm.column_number in (7, 8, 9, 10, 11, 12, 13, 14,15,16,17,18);


SELECT * FROM base_z_encounter_obs z
    INNER JOIN base_dim_concept_metadata cm
    ON cm.concept_uuid = z.obs_question_uuid
-- SET z.obs_value_text = IF(z.obs_value_coded IS NOT NULL, 'Yes', 'No')
WHERE cm.column_number in (7, 8, 9, 10, 11, 12, 13, 14);

-- $END
