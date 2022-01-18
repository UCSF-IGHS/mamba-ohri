USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.fact_cqi_action_plan;

-- $BEGIN

CREATE TABLE base.fact_cqi_action_plan
(
    cqi_action_plan_id UNIQUEIDENTIFIER NOT NULL,
    category_score DECIMAL(10,4) NULL,
    gap NVARCHAR(MAX) NULL,
    root_cause NVARCHAR(MAX) NULL,
    root_cause_code NVARCHAR(255) NULL,
    intervention NVARCHAR(MAX) NULL,
    intervention_code NVARCHAR(255) NULL,
    due_date DATE NULL,
    due_date_id INT NULL,
    person_responsible NVARCHAR(255) NULL,
    cqi_category_id UNIQUEIDENTIFIER NULL,
    cqi_action_plan_assessment_id UNIQUEIDENTIFIER NULL
);

ALTER TABLE base.fact_cqi_action_plan 
ADD CONSTRAINT PK_cqi_action_plan_id PRIMARY KEY (cqi_action_plan_id);

ALTER TABLE base.fact_cqi_action_plan 
ADD CONSTRAINT FK_cqi_ap_due_date 
FOREIGN KEY (due_date_id) REFERENCES base.dim_date (date_id);

ALTER TABLE base.fact_cqi_action_plan 
ADD CONSTRAINT FK_cqi_category_id FOREIGN KEY (cqi_category_id)
REFERENCES base.dim_cqi_category (cqi_category_id);

ALTER TABLE base.fact_cqi_action_plan 
ADD CONSTRAINT FK_cqi_action_plan_assessment_id FOREIGN KEY (cqi_action_plan_assessment_id)
REFERENCES base.dim_cqi_action_plan_assessment (cqi_action_plan_assessment_id);

-- $END




