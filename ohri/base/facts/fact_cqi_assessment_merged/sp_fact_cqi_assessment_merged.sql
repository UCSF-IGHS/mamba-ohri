USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

EXEC base.sp_fact_cqi_assessment_merged_create;
EXEC base.sp_fact_cqi_assessment_merged_insert;
EXEC base.sp_fact_cqi_assessment_merged_visit_number_update;

-- $END