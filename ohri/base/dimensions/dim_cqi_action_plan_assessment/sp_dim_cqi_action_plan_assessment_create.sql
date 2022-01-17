USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS base.dim_cqi_action_plan_assessment;

-- $BEGIN

CREATE TABLE base.dim_cqi_action_plan_assessment
(
    cqi_action_plan_assessment_id UNIQUEIDENTIFIER NOT NULL,
    facility_id UNIQUEIDENTIFIER NOT NULL,
    entry_point NVARCHAR(255)  NULL,
    review_period_end_date DATE  NULL,
    review_period_end_date_id INT  NULL,
    review_period_start_date DATE  NULL,
    review_period_start_date_id INT  NULL,
    visit_date DATE  NULL,
    visit_date_id INT  NULL,
    visitor_name NVARCHAR(255)  NULL,
    _uri VARCHAR(255)  NULL
)

ALTER TABLE base.dim_cqi_action_plan_assessment 
ADD CONSTRAINT PK_cqi_action_plan_assessment_id PRIMARY KEY (cqi_action_plan_assessment_id);

ALTER TABLE base.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_cqi_ap_review_period_start_date 
FOREIGN KEY (review_period_start_date_id) REFERENCES base.dim_date(date_id);

ALTER TABLE base.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_cqi_ap_review_period_end_date 
FOREIGN KEY (review_period_end_date_id) REFERENCES base.dim_date (date_id);

ALTER TABLE base.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_cqi_ap_facility 
FOREIGN KEY (facility_id) REFERENCES base.dim_facility (facility_id);

-- $END