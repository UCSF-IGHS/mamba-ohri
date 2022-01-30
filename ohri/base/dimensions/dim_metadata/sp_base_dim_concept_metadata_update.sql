USE analysis;

-- $BEGIN

-- Update the Concept datatypes
UPDATE base_dim_concept_metadata md
    INNER JOIN base_dim_concept c
        ON md.concept_uuid = c.uuid
SET md.concept_datatype = c.datatype;

-- Update to True if this field is an obs answer to an obs Question
UPDATE base_dim_concept_metadata md
    INNER JOIN base_dim_concept c
        ON md.concept_uuid = c.uuid
    INNER JOIN base_dim_concept_answer ca
        ON ca.answer_concept = c.external_concept_id
SET md.concept_answer_obs = 1;

-- $END
