USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_fact_cqi_action_plan_followup_create;
EXEC base.sp_fact_cqi_action_plan_followup_insert;

-- $END