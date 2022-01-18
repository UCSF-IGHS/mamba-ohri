USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS derived_recency.dim_cqi_assessment;

-- $BEGIN

CREATE TABLE derived_recency.dim_cqi_assessment(
    cqi_assessment_id UNIQUEIDENTIFIER NOT NULL,
    _form_version TEXT NULL,
    _uri TEXT NULL,
    visit_date DATE NOT NULL,
    visit_date_id INT NOT NULL,
    review_period_start_date DATE NOT NULL,
    review_period_start_date_id INT NOT NULL,
    review_period_end_date DATE NOT NULL,
    review_period_end_date_id INT NOT NULL,
    visitor_name NVARCHAR(255) NULL,
    cqi_assessment_point TEXT NULL,
    cqi_assessment_type TEXT NULL,
    is_latest_visit INT NOT NULL, 
    visit_number INT NOT NULL, 
    reversed_visit_number INT NOT NULL,
    facility_id UNIQUEIDENTIFIER NULL
)

ALTER TABLE derived_recency.dim_cqi_assessment ADD CONSTRAINT PK_cqi_assessment_id PRIMARY KEY (cqi_assessment_id);

ALTER TABLE derived_recency.dim_cqi_assessment ADD 
CONSTRAINT FK_cqi_assessment_facility
FOREIGN KEY (facility_id) REFERENCES derived_recency.dim_facility (facility_id);

-- $END