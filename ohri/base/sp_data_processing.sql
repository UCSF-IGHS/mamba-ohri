USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN
 
 PRINT 'Starting execution of Base Objects'

 --Drop foreign key constraints
 PRINT 'Dropping foreign keys'
 EXEC dbo.sp_xf_system_drop_all_foreign_keys_in_schema 'base'

 PRINT 'Dropping tables'
 EXEC dbo.sp_xf_system_drop_all_tables_in_schema 'base'

 
-- Base dimensions and facts

PRINT 'Executing sp_dim_date'
EXEC base.sp_dim_date;

PRINT 'Executing sp_dim_implementing_mechanism'
EXEC base.sp_dim_implementing_mechanism;

PRINT 'Executing sp_dim_location'
EXEC base.sp_dim_location;

PRINT 'Executing sp_dim_facility'
EXEC base.sp_dim_facility;

PRINT 'Executing sp_dim_hts_client'
EXEC base.sp_dim_hts_client;

PRINT 'Executing sp_dim_uvri_client'
EXEC base.sp_dim_uvri_client;

PRINT 'Executing sp_dim_hub'
EXEC base.sp_dim_hub;

PRINT 'Executing sp_dim_cqi_category'
EXEC base.sp_dim_cqi_category;

PRINT 'Executing sp_dim_cqi_indicator'
EXEC base.sp_dim_cqi_indicator;

PRINT 'Executing sp_dim_cqi_action_plan_assessment'
EXEC base.sp_dim_cqi_action_plan_assessment;

PRINT 'Executing sp_fact_hts_emr'
EXEC base.sp_fact_hts_emr;

PRINT 'Executing sp_fact_uvri_recency_result'
EXEC base.sp_fact_uvri_recency_result;

PRINT 'Executing sp_fact_cqi_assessment'
EXEC base.sp_fact_cqi_assessment;

PRINT 'Executing sp_fact_cqi_shortened_assessment'
EXEC base.sp_fact_cqi_shortened_assessment;

PRINT 'Executing sp_fact_cqi_assessment_merged'
EXEC base.sp_fact_cqi_assessment_merged;

PRINT 'Executing sp_fact_cqi_action_plan'
EXEC base.sp_fact_cqi_action_plan;

PRINT 'Executing sp_fact_cqi_action_plan_followup'
EXEC base.sp_fact_cqi_action_plan_followup;

-- $END