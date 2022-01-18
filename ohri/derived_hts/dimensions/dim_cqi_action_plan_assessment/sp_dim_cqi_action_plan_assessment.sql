USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

EXEC derived_recency.sp_dim_cqi_action_plan_assessment_create;
EXEC derived_recency.sp_dim_cqi_action_plan_assessment_insert;

-- $END