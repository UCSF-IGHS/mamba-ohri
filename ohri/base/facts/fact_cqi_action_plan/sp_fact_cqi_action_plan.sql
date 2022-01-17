USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_fact_cqi_action_plan_create;
EXEC base.sp_fact_cqi_action_plan_insert;
EXEC base.sp_fact_cqi_action_plan_cte;
EXEC base.sp_fact_cqi_action_plan_cleaning;

-- $END