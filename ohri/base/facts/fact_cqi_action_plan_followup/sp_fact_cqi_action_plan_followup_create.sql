USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.fact_cqi_action_plan_followup;

-- $BEGIN

CREATE TABLE base.fact_cqi_action_plan_followup
(
    cqi_action_plan_followup_id UNIQUEIDENTIFIER NOT NULL,
    due_date_changed NVARCHAR(255) NULL,
    is_due_date_changed TINYINT NULL,
    new_due_date DATE NULL,
    new_due_date_id INT NULL,
    progress_to_date NVARCHAR(MAX) NULL,
    challenges NVARCHAR(MAX) NULL,
    action_taken NVARCHAR(MAX) NULL,
    outcome NVARCHAR(MAX) NULL,
    abandon_reason NVARCHAR(MAX) NULL,
    cqi_category_id UNIQUEIDENTIFIER NULL,
    cqi_action_plan_assessment_id UNIQUEIDENTIFIER NULL
);

ALTER TABLE base.fact_cqi_action_plan_followup 
ADD CONSTRAINT PK_cqi_action_plan_followup_id PRIMARY KEY (cqi_action_plan_followup_id);

ALTER TABLE base.fact_cqi_action_plan_followup 
ADD CONSTRAINT FK_cqi_apf_new_due_date 
FOREIGN KEY (new_due_date_id) REFERENCES base.dim_date (date_id);

ALTER TABLE base.fact_cqi_action_plan_followup 
ADD CONSTRAINT FK_cqi_action_plan_followup_category_id FOREIGN KEY (cqi_category_id)
REFERENCES base.dim_cqi_category (cqi_category_id);

ALTER TABLE base.fact_cqi_action_plan_followup 
ADD CONSTRAINT FK_cqi_action_plan_followup_assessment_id FOREIGN KEY (cqi_action_plan_assessment_id)
REFERENCES base.dim_cqi_action_plan_assessment (cqi_action_plan_assessment_id);

-- $END