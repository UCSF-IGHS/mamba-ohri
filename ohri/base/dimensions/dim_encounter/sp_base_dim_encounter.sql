USE analysis;


-- $BEGIN

CALL sp_base_dim_encounter_create();
CALL sp_base_dim_encounter_insert();

-- $END
