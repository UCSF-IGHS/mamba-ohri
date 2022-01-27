USE analysis;


-- $BEGIN

UPDATE base_dim_concept_metadata md
    INNER JOIN base_dim_concept dt
        ON md.concept_uuid = dt.uuid
SET md.concept_data_type = dt.datatype;

-- $END
