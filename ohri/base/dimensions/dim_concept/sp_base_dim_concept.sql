USE analysis;


-- $BEGIN

CALL sp_base_dim_concept_create();
CALL sp_base_dim_concept_insert();
CALL sp_base_dim_concept_update();

-- $END
