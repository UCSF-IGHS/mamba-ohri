USE analysis;


-- $BEGIN

CALL sp_base_dim_concept_metadata_create();
CALL sp_base_dim_concept_metadata_insert();
CALL sp_base_dim_concept_metadata_update();

-- $END
