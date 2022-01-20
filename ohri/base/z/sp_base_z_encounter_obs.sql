USE analysis;
GO

DROP TABLE IF EXISTS base.z_encounter_obs;

-- $BEGIN

CREATE TABLE base.z_encounter_obs(
    obs_question_uuid CHAR(38),
    obs_value_coded_uuid CHAR(38),
    encounter_type_uuid CHAR(38)
)
SELECT
    o.encounter_id AS encounter_id,
    o.person_id AS person_id,
    o.obs_datetime AS obs_datetime,
    o.concept_id AS obs_question_concept_id,
    o.value_text AS obs_value_text,
    o.value_numeric AS obs_value_numeric,
    o.value_coded AS obs_value_coded,
    o.value_datetime AS obs_value_datetime,
    NULL AS obs_question_uuid,
    NULL AS obs_value_coded_uuid,
    NULL AS encounter_type_uuid
FROM
    [exernal].obs o;


-- update obs question UUIDs
UPDATE base.z_encounter_obs z
    INNER JOIN base.concept c
        ON z.obs_question_concept_id = c.external_concept_id
SET  z.obs_question_uuid = c.uuid;

-- update obs_value_coded (UUIDs & values)
UPDATE base.z_encounter_obs z
    INNER JOIN base.concept_name cn
        ON z.obs_value_coded = cn.external_concept_id
    INNER JOIN base.concept c
        ON z.obs_value_coded = c.external_concept_id
SET z.obs_value_text = cn.concept_name,
    z.obs_value_coded_uuid = c.uuid
WHERE
    z.obs_value_coded IS NOT NULL;

-- Update the encounter type UUID
UPDATE base.z_encounter_obs z
    INNER JOIN base.encounter e
        ON z.encounter_id = e.external_encounter_id
    INNER JOIN base.encounter_type et
        ON e.external_encounter_type_id = et.external_encounter_type_id
SET  z.encounter_type_uuid = et.encounter_type_uuid;

-- Update Key pop types to Yes/No (in Z Table)
UPDATE base.z_encounter_obs z
    INNER JOIN base.concept_metadata cm
        ON cm.concept_uuid= z.obs_value_coded_uuid
SET z.obs_value_text = IF (z.obs_value_coded IS NOT NULL, 'Yes', 'No')
WHERE
    cm.column_number in (7, 8, 9 , 10);

-- $END
