USE analysis;
GO

-- $BEGIN

EXEC base.sp_dim_encounter_type_create;
EXEC base.sp_dim_encounter_type_insert;

-- $END
