USE analysis;

-- $BEGIN

CALL sp_fact_hts_encounter_create();
CALL sp_fact_hts_encounter_insert();
CALL sp_fact_hts_encounter_cleaning();

-- $END