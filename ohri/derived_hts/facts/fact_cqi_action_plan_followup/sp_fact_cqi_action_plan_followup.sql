USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

EXEC derived_recency.sp_fact_cqi_action_plan_followup_create;
EXEC derived_recency.sp_fact_cqi_action_plan_followup_insert;
EXEC derived_recency.sp_fact_cqi_action_plan_followup_trim_date_dimensions;

-- $END