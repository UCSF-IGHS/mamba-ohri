USE analysis;
GO

TRUNCATE TABLE base.concept_datatype;

-- $BEGIN

INSERT INTO base.concept_datatype (
    external_datatype_id,
    datatype
)
SELECT
    dt.concept_datatype_id AS external_datatype_id,
    dt.name AS datatype
FROM
    [external].concept_datatype dt
WHERE
    dt.retired = 0;

-- $END
