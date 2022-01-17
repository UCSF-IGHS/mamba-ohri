USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_hts_client_create;
EXEC base.sp_dim_hts_client_insert;
EXEC base.sp_dim_hts_client_update;
--EXEC base.sp_dim_hts_client_cleaning;

-- $END