USE analysis;
GO

-- $BEGIN

EXEC base.sp_fact_hts_create;
EXEC base.sp_fact_hts_insert;
EXEC base.sp_fact_hts_update;
EXEC base.sp_fact_hts_cleaning;

-- $END
