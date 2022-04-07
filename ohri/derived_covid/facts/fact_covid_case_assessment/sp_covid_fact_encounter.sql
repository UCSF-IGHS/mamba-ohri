USE analysis;

-- $BEGIN

CALL sp_covid_fact_encounter_create();
CALL sp_covid_fact_encounter_insert();
CALL sp_covid_fact_encounter_update();