USE analysis;

TRUNCATE TABLE base_dim_encounter;

-- $BEGIN

INSERT INTO base_dim_encounter (
     external_encounter_id,
     external_encounter_type_id
)
SELECT
    e.encounter_id AS external_encounter_id,
    e.encounter_type AS external_encounter_type_id
FROM
    openmrs_working.encounter e;

-- $END
