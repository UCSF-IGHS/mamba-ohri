USE analysis;

TRUNCATE TABLE base_dim_concept_answer;

-- $BEGIN

INSERT INTO base_dim_concept_answer (
    concept_id,
    answer_concept,
    answer_drug
)
SELECT
    ca.concept_id AS concept_id,
    ca.answer_concept AS answer_concept,
    ca.answer_drug AS answer_drug
FROM
    openmrs_working.concept_answer ca;

-- $END