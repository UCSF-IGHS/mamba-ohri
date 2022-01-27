USE analysis;

TRUNCATE TABLE base_dim_concept_datatype;

-- $BEGIN

INSERT INTO base_dim_concept_datatype (
    external_datatype_id,
    datatype
)
SELECT
    dt.concept_datatype_id AS external_datatype_id,
    dt.name AS datatype
FROM
    openmrs_working.concept_datatype dt
WHERE
    dt.retired = 0;

-- $END
