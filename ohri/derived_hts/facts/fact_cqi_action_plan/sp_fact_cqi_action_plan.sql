USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

EXEC derived_recency.sp_fact_cqi_action_plan_create;
EXEC derived_recency.sp_fact_cqi_action_plan_insert;
EXEC derived_recency.sp_fact_cqi_action_plan_trim_date_dimensions;

-- $END