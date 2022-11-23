USE analysis;

-- $BEGIN

CALL sp_fact_ugemr_hts_encounter_create();
CALL sp_fact_ugemr_hts_encounter_insert();

-- $END