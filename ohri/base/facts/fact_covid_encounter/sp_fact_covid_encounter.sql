USE analysis;


-- $BEGIN

CALL sp_fact_covid_encounter_create();
CALL sp_fact_covid_encounter_insert();
CALL sp_fact_covid_encounter_cleaning();

-- $END
