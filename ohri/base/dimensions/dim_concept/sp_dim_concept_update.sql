USE analysis;
GO

-- $BEGIN

UPDATE base.concept c
    INNER JOIN base.concept_datatype dt
        ON c.external_datatype_id = dt.external_datatype_id
SET c.datatype = dt.datatype;

-- $END
