USE analysis;

-- $BEGIN

CALL sp_flatten_encounter('fact_covid_case_assessment', 'encounter_covid', '253a43d3-c99e-415c-8b78-ee7d4d3c1d54');
CALL sp_base_fact_covid_encounter_cleaning();
-- $END