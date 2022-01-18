USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE  derived_recency.dim_cqi_action_plan_assessment;

-- $BEGIN

INSERT INTO derived_recency.dim_cqi_action_plan_assessment
SELECT
    b.cqi_action_plan_assessment_id,
    b.facility_id,
    b.entry_point,
    b.review_period_end_date,
    (SELECT e.date_id FROM derived_recency.dim_cqi_assessment_review_period_end_date e WHERE e.date_yyyymmdd = b.review_period_end_date) AS review_period_end_date_id,
    b.review_period_start_date,
    (SELECT s.date_id FROM derived_recency.dim_cqi_assessment_review_period_start_date s WHERE s.date_yyyymmdd = b.review_period_start_date) AS review_period_start_date_id,
    b.visit_date,
    (SELECT v.date_id FROM derived_recency.dim_cqi_assessment_visit_date v WHERE v.date_yyyymmdd = b.visit_date) AS visit_date_id,
    b.visitor_name,
    b._uri
    
FROM
    base.dim_cqi_action_plan_assessment b
WHERE 
    facility_id IS NOT NULL
AND 
    entry_point IS NOT NULL
AND 
    review_period_end_date IS NOT NULL 
AND 
    review_period_start_date IS NOT NULL
AND 
    visit_date IS NOT NULL

-- $END
GO
SELECT 
    *
FROM
    derived_recency.dim_cqi_action_plan_assessment