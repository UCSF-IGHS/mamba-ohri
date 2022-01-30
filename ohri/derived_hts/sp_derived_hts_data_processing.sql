USE recency_uganda_prod_analysis_test;

-- $BEGIN

--Drop foreign key constraints
CALL dbo.sp_xf_system_drop_all_foreign_keys_in_schema 'derived_recency'
CALL dbo.sp_xf_system_drop_all_tables_in_schema 'derived_recency'

-- Derived dimensions and fact
CALL derived_recency.sp_dim_date;
CALL derived_recency.sp_dim_age_group;
CALL derived_recency.sp_dim_client;
CALL derived_recency.sp_dim_implementing_mechanism;
CALL derived_recency.sp_dim_location;
CALL derived_recency.sp_dim_facility;

-- CALL sp_dim_hub;

CALL derived_recency.sp_dim_hub;

-- CALL sp_derived_recency_dim_hub;
CALL derived_recency.sp_fact_recency_surveillance;
CALL derived_recency.sp_fact_recency_surveillance_censored;
CALL derived_recency.sp_fact_recency_surveillance_unconsented;

-- CQI
CALL derived_recency.sp_dim_cqi_action_plan_assessment;
CALL derived_recency.sp_dim_cqi_assessment;
CALL derived_recency.sp_dim_cqi_category;
CALL derived_recency.sp_dim_cqi_indicator;


CALL derived_recency.sp_fact_cqi_assessment_indicator_score;
CALL derived_recency.sp_fact_cqi_assessment_group_score;
CALL derived_recency.sp_fact_cqi_action_plan;
CALL derived_recency.sp_fact_cqi_action_plan_followup;

-- $END