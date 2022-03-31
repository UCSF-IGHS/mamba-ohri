USE analysis;

-- $BEGIN

CALL sp_flatten_encounter('fact_hts', 'encounter_hts', '79c1f50f-f77d-42e2-ad2a-d29304dde2fe');
CALL sp_fact_hts_encounter_cleaning();

-- $END