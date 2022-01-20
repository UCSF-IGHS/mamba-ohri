USE analysis;
GO

TRUNCATE TABLE base.encounter_type;

-- $BEGIN

INSERT INTO base.encounter_type (
     external_encounter_type_id,
     encounter_type_uuid
)
SELECT
    et.encounter_type_id AS external_encounter_type_id,
    et.uuid AS encounter_type_uuid
FROM
    [external].encounter_type et
WHERE
    et.retired = 0;

-- $END
