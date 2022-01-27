USE analysis;

TRUNCATE TABLE base_dim_concept;

-- $BEGIN

INSERT INTO base_dim_concept (
     uuid,
     external_concept_id,
     external_datatype_id
)
SELECT
    c.uuid AS uuid,
    c.concept_id AS external_concept_id,
    c.datatype_id AS external_datatype_id
FROM
    openmrs_working.concept c
WHERE
    c.retired = 0;

-- $END
