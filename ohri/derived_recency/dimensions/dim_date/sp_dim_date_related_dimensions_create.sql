USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

DROP TABLE IF EXISTS derived_recency.dim_date;
DROP TABLE IF EXISTS derived_recency.dim_visit_date;
DROP TABLE IF EXISTS derived_recency.dim_last_hiv_test_date;
DROP TABLE IF EXISTS derived_recency.dim_sample_collection_date;
DROP TABLE IF EXISTS derived_recency.dim_sample_registration_date;
DROP TABLE IF EXISTS derived_recency.dim_kit_expiry_date;
DROP TABLE IF EXISTS derived_recency.dim_uvri_test_date;
DROP TABLE IF EXISTS derived_recency.dim_viral_load_date;
DROP TABLE IF EXISTS derived_recency.dim_last_uploaded_on_date;
DROP TABLE IF EXISTS derived_recency.dim_activation_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_assessment_visit_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_assessment_review_period_start_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_assessment_review_period_end_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_action_plan_assessment_visit_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_action_plan_due_date;
DROP TABLE IF EXISTS derived_recency.dim_cqi_action_plan_followup_new_due_date;


SELECT * INTO derived_recency.dim_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_visit_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_last_hiv_test_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_sample_collection_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_sample_registration_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_kit_expiry_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_uvri_test_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_viral_load_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_last_uploaded_on_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_activation_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_cqi_assessment_visit_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_cqi_assessment_review_period_start_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_cqi_assessment_review_period_end_date FROM base.dim_date;
SELECT * INTO derived_recency.dim_cqi_action_plan_assessment_visit_date FROM base.dim_date
SELECT * INTO derived_recency.dim_cqi_action_plan_due_date FROM base.dim_date
SELECT * INTO derived_recency.dim_cqi_action_plan_followup_new_due_date FROM base.dim_date

ALTER TABLE derived_recency.dim_date ADD CONSTRAINT PK_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_visit_date ADD CONSTRAINT PK_visit_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_last_hiv_test_date ADD CONSTRAINT PK_last_hiv_test_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_sample_collection_date ADD CONSTRAINT PK_sample_collection_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_sample_registration_date ADD CONSTRAINT PK_sample_registration_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_kit_expiry_date ADD CONSTRAINT PK_kit_expiry_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_uvri_test_date ADD CONSTRAINT PK_uvri_test_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_viral_load_date ADD CONSTRAINT PK_viral_load_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_last_uploaded_on_date ADD CONSTRAINT PK_last_uploaded_on_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_activation_date ADD CONSTRAINT PK_activation_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_assessment_visit_date ADD CONSTRAINT PK_cqi_assessment_visit_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_assessment_review_period_start_date ADD CONSTRAINT PK_cqi_assessment_review_period_start_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_assessment_review_period_end_date ADD CONSTRAINT PK_cqi_assessment_review_period_end_date PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_action_plan_assessment_visit_date ADD CONSTRAINT PK_cqi_action_plan_assessment_visit_date_id PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_action_plan_due_date ADD CONSTRAINT PK_cqi_action_plan_due_date_id PRIMARY KEY (date_id);
ALTER TABLE derived_recency.dim_cqi_action_plan_followup_new_due_date ADD CONSTRAINT PK_cqi_action_plan_followup_new_due_date_id PRIMARY KEY (date_id);

-- $END