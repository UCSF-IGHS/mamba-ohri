USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS derived_recency.fact_cqi_action_plan;

-- $BEGIN

CREATE TABLE derived_recency.fact_cqi_action_plan
(
    cqi_action_plan_id UNIQUEIDENTIFIER NOT NULL,
    category_score DECIMAL(10,4) NOT NULL,
    gap NVARCHAR(MAX) NOT NULL,
    root_cause NVARCHAR(MAX) NOT NULL,
    root_cause_code NVARCHAR(255) NOT NULL,
    intervention NVARCHAR(MAX) NOT NULL,
    intervention_code NVARCHAR(255) NOT NULL,
    due_date DATE NOT NULL,
    due_date_id INT NOT NULL,
    person_responsible NVARCHAR(255)  NULL,
    cqi_category_id UNIQUEIDENTIFIER NOT NULL,
    cqi_action_plan_assessment_id UNIQUEIDENTIFIER NOT NULL
);

ALTER TABLE derived_recency.fact_cqi_action_plan 
ADD CONSTRAINT PK_cqi_action_plan_id PRIMARY KEY (cqi_action_plan_id);

ALTER TABLE derived_recency.fact_cqi_action_plan 
ADD CONSTRAINT FK_derived_cqi_ap_due_date 
FOREIGN KEY (due_date_id) REFERENCES derived_recency.dim_cqi_action_plan_due_date (date_id);

ALTER TABLE derived_recency.fact_cqi_action_plan 
ADD CONSTRAINT FK_cqi_category_id FOREIGN KEY (cqi_category_id)
REFERENCES derived_recency.dim_cqi_category (cqi_category_id);

ALTER TABLE derived_recency.fact_cqi_action_plan 
ADD CONSTRAINT FK_cqi_action_plan_assessment_id FOREIGN KEY (cqi_action_plan_assessment_id)
REFERENCES derived_recency.dim_cqi_action_plan_assessment (cqi_action_plan_assessment_id);

-- $END