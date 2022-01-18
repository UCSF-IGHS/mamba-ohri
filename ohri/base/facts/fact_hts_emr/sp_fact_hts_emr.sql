USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_fact_hts_emr_create;
EXEC base.sp_fact_hts_emr_insert;
EXEC base.sp_fact_hts_emr_update_unknown_locations;
EXEC base.sp_fact_hts_emr_cleaning;

-- $END