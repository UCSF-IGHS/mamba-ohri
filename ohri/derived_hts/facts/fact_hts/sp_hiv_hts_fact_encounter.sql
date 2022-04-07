USE analysis;

-- $BEGIN

CALL sp_hiv_hts_fact_encounter_create();
CALL sp_hiv_hts_fact_encounter_insert();
CALL sp_hiv_hts_fact_encounter_update();