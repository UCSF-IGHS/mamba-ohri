USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_fact_uvri_recency_result_create;
EXEC base.sp_fact_uvri_recency_result_insert;
-- EXEC base.sp_cleaning_fact_uvri_recency_result;
EXEC base.sp_fact_uvri_recency_result_cleaning;

-- $END