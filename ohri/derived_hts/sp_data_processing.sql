USE recency_uganda_prod_analysis_test;
GO


-- $BEGIN

--Drop foreign key constraints
EXEC dbo.sp_xf_system_drop_all_foreign_keys_in_schema 'derived_recency'
EXEC dbo.sp_xf_system_drop_all_tables_in_schema 'derived_recency'

-- Derived dimensions and fact
EXEC derived_recency.sp_dim_date;
EXEC derived_recency.sp_dim_age_group;
EXEC derived_recency.sp_dim_client;
EXEC derived_recency.sp_dim_implementing_mechanism;
EXEC derived_recency.sp_dim_location;
EXEC derived_recency.sp_dim_facility;

-- EXEC sp_dim_hub;

EXEC derived_recency.sp_dim_hub;

-- EXEC sp_derived_recency_dim_hub;
EXEC derived_recency.sp_fact_recency_surveillance;
EXEC derived_recency.sp_fact_recency_surveillance_censored;
EXEC derived_recency.sp_fact_recency_surveillance_unconsented;

-- CQI
EXEC derived_recency.sp_dim_cqi_action_plan_assessment;
EXEC derived_recency.sp_dim_cqi_assessment;
EXEC derived_recency.sp_dim_cqi_category;
EXEC derived_recency.sp_dim_cqi_indicator;


EXEC derived_recency.sp_fact_cqi_assessment_indicator_score;
EXEC derived_recency.sp_fact_cqi_assessment_group_score;
EXEC derived_recency.sp_fact_cqi_action_plan;
EXEC derived_recency.sp_fact_cqi_action_plan_followup;

-- $END