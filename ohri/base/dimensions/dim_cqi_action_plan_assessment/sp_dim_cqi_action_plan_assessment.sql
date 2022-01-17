USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

EXEC base.sp_dim_cqi_action_plan_assessment_create;
EXEC base.sp_dim_cqi_action_plan_assessment_insert;

-- $END