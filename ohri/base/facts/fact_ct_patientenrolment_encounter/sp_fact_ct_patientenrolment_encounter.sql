USE analysis;


-- $BEGIN

CALL sp_fact_ct_patientenrolment_encounter_create();
CALL sp_fact_ct_patientenrolment_encounter_insert();

-- $END
