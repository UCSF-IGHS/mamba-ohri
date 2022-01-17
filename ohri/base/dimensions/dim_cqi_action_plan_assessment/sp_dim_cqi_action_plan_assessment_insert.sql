USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE  base.dim_cqi_action_plan_assessment;

-- $BEGIN

INSERT INTO base.dim_cqi_action_plan_assessment ( 
    cqi_action_plan_assessment_id,
    facility_id,
    entry_point,
    review_period_end_date,
    review_period_end_date_id,
    review_period_start_date,
    review_period_start_date_id,
    visit_date,
    visit_date_id,
    visitor_name,
    _uri
)
SELECT
    NEWID(),
    f.facility_id,
    a.entry_point,
    a.review_period_end_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = a.review_period_end_date) AS review_period_end_date_id,
    a.review_period_start_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = a.review_period_start_date) AS review_period_start_date_id,
    a.visit_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = a.visit_date) AS visit_date_id,
    a.visitor_name,
    a.uri
FROM
    base.vw_odk_form_cqi_action_plans a
    LEFT JOIN
	base.dim_facility f
	ON
		f.dhis2_uid = a.site

-- $END
GO
SELECT 
    *
FROM
    base.dim_cqi_action_plan_assessment