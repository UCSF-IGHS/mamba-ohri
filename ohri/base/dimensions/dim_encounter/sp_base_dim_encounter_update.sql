USE analysis;

-- $BEGIN

UPDATE base_dim_encounter e
    INNER JOIN base_dim_encounter_type et
        ON e.external_encounter_type_id = et.external_encounter_type_id
SET e.encounter_type_uuid = et.encounter_type_uuid;

-- $END
