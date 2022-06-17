USE analysis;


-- $BEGIN

CALL sp_fact_ct_arttherapy_encounter_create();
CALL sp_fact_ct_arttherapy_encounter_insert();

-- $END