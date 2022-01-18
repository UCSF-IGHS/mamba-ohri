USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS derived_recency.dim_cqi_action_plan_assessment;

-- $BEGIN

CREATE TABLE derived_recency.dim_cqi_action_plan_assessment
(
    cqi_action_plan_assessment_id UNIQUEIDENTIFIER NOT NULL,
    facility_id UNIQUEIDENTIFIER NOT NULL,
    entry_point NVARCHAR(255) NOT NULL,
    review_period_end_date DATE NOT NULL,
    review_period_end_date_id INT NOT NULL,
    review_period_start_date DATE NOT NULL,
    review_period_start_date_id INT NOT NULL,
    visit_date DATE NOT NULL,
    visit_date_id INT NOT NULL,
    visitor_name NVARCHAR(255) NULL,
    _uri VARCHAR(255) NOT NULL
);

ALTER TABLE derived_recency.dim_cqi_action_plan_assessment ADD CONSTRAINT PK_derived_cqi_action_plan_assessment_id PRIMARY KEY (cqi_action_plan_assessment_id);

ALTER TABLE derived_recency.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_derived_cqi_ap_review_period_start_date 
FOREIGN KEY (review_period_start_date_id) REFERENCES derived_recency.dim_cqi_assessment_review_period_start_date (date_id);

ALTER TABLE derived_recency.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_derived_cqi_review_period_end_date 
FOREIGN KEY (review_period_end_date_id) REFERENCES derived_recency.dim_cqi_assessment_review_period_end_date (date_id);

ALTER TABLE derived_recency.dim_cqi_action_plan_assessment 
ADD CONSTRAINT FK_derived_cqi_ap_facility 
FOREIGN KEY (facility_id) REFERENCES derived_recency.dim_facility (facility_id);

-- $END
