USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_fact_cqi_shortened_assessment_create;
EXEC base.sp_fact_cqi_shortened_assessment_insert;
EXEC base.sp_fact_cqi_shortened_assessment_computed_columns_update;

-- $END