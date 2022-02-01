USE analysis;

-- $BEGIN

UPDATE base_dim_concept c
    INNER JOIN base_dim_concept_datatype dt
        ON c.external_datatype_id = dt.external_datatype_id
SET c.datatype = dt.datatype_name;

-- $END
