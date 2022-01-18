USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_fact_cqi_assessment_indicator_score_create;
EXEC derived_recency.sp_fact_cqi_assessment_indicator_score_insert;

-- $END