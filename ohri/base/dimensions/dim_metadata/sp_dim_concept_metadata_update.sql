USE analysis;
GO

-- $BEGIN

UPDATE base_concept_metadata md
    INNER JOIN base_concept dt
        ON md.concept_uuid = dt.uuid
SET md.concept_data_type = dt.datatype;

-- $END
