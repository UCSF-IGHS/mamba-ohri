USE analysis;
GO

TRUNCATE TABLE base.encounter;

-- $BEGIN

INSERT INTO base.encounter (
     external_encounter_id,
     external_encounter_type_id
)
SELECT
    e.encounter_id AS external_encounter_id,
    e.encounter_type AS external_encounter_type_id
FROM
    [external].encounter e;

-- $END
