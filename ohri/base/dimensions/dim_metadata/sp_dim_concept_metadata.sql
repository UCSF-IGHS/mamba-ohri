USE analysis;
GO

-- $BEGIN

EXEC base.sp_dim_concept_metadata_create;
EXEC base.sp_dim_concept_metadata_insert;
EXEC base.sp_dim_concept_metadata_update;

-- $END
