USE analysis;

DROP TABLE IF EXISTS mamba_z_encounter_obs;

-- $BEGIN

CREATE TABLE mamba_z_encounter_obs
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
UPDATE mamba_z_encounter_obs z
    INNER JOIN mamba_dim_concept c
    ON z.obs_question_concept_id = c.external_concept_id
SET z.obs_question_uuid = c.uuid;

-- update obs answer UUIDs
UPDATE mamba_z_encounter_obs z
    INNER JOIN mamba_dim_concept c
    ON z.obs_question_concept_id = c.external_concept_id
    INNER JOIN mamba_dim_concept_datatype dt
    ON dt.external_datatype_id = c.external_datatype_id
SET z.obs_answer_uuid = (IF(dt.datatype_name = 'Coded',
                            (SELECT c.uuid
                             FROM mamba_dim_concept c
                             where c.external_concept_id = z.obs_value_coded AND z.obs_value_coded IS NOT NULL),
                            c.uuid));

-- update obs_value_coded (UUIDs & values)
UPDATE mamba_z_encounter_obs z
    INNER JOIN mamba_dim_concept_name cn
    ON z.obs_value_coded = cn.external_concept_id
    INNER JOIN mamba_dim_concept c
    ON z.obs_value_coded = c.external_concept_id
SET z.obs_value_text       = cn.concept_name,
    z.obs_value_coded_uuid = c.uuid
WHERE z.obs_value_coded IS NOT NULL;

-- Update the encounter type UUID
UPDATE mamba_z_encounter_obs z
    INNER JOIN mamba_dim_encounter e
    ON z.encounter_id = e.external_encounter_id
    INNER JOIN mamba_dim_encounter_type et
    ON e.external_encounter_type_id = et.external_encounter_type_id
SET z.encounter_type_uuid = et.encounter_type_uuid;

-- Update Key pop types to Yes/NULL (in Z Table) -- may be move this to the fact_hts update script
UPDATE mamba_z_encounter_obs z
    INNER JOIN mamba_dim_concept_metadata cm
    ON cm.concept_uuid = z.obs_value_coded_uuid
SET z.obs_value_text = IF(z.obs_value_coded IS NOT NULL, 'Yes', NULL)
WHERE cm.column_label in (
                          'key_pop_migrant_worker',
                          'key_pop_uniformed_forces',
                          'key_pop_transgender',
                          'key_pop_AGYW',
                          'key_pop_fisher_folk',
                          'key_pop_prisoners',
                          'key_pop_refugees',
                          'key_pop_msm',
                          'key_pop_fsw',
                          'key_pop_truck_driver',
                          'key_pop_pwd',
                          'key_pop_pwid');
-- $END