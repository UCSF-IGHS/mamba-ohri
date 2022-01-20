USE analysis;
GO

-- $BEGIN

EXEC base.sp_dim_encounter_create;
EXEC base.sp_dim_encounter_insert;

-- $END
