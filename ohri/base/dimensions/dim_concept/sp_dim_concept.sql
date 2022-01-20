USE analysis;
GO

-- $BEGIN

EXEC base.sp_dim_concept_create;
EXEC base.sp_dim_concept_insert;
EXEC base.sp_dim_concept_update;

-- $END
