USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE derived_recency.dim_cqi_assessment

-- $BEGIN

INSERT INTO derived_recency.dim_cqi_assessment(
    cqi_assessment_id,
    _form_version,
    _uri,
    visit_date,
    visit_date_id,
    review_period_start_date,
    review_period_start_date_id,
    review_period_end_date,
    review_period_end_date_id,
    visitor_name,
    cqi_assessment_point,
    cqi_assessment_type,
    is_latest_visit, 
    visit_number, 
    reversed_visit_number,
    facility_id

)
SELECT
	cqi_assessment_merged_id,
    form_version AS _form_version,
	uri AS _uri,
	visit_date,
    (SELECT date_id FROM derived_recency.dim_cqi_assessment_visit_date WHERE date_yyyymmdd = visit_date) AS visit_date_id,
    review_period_start_date AS review_period_start_date,
    (SELECT date_id FROM derived_recency.dim_cqi_assessment_review_period_start_date WHERE date_yyyymmdd = review_period_start_date) AS review_period_start_date_id,
    review_period_end_date AS review_period_end_date,
    (SELECT date_id FROM derived_recency.dim_cqi_assessment_review_period_start_date WHERE date_yyyymmdd = review_period_end_date) AS review_period_end_date_id,
    visitor_name,
	assessment_point,
	cqi_checklist_type,
    is_latest_visit, 
    visit_number, 
    reversed_visit_number,
	facility_id
	
FROM
    base.fact_cqi_assessment_merged;

-- $END

SELECT 
	*
FROM 
	derived_recency.dim_cqi_assessment;