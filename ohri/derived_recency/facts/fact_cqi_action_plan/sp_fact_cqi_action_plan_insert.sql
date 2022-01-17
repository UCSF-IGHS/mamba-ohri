USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE derived_recency.fact_cqi_action_plan;

-- $BEGIN

INSERT INTO
	derived_recency.fact_cqi_action_plan(
	cqi_action_plan_id,
	category_score,
	gap,
	root_cause,
	root_cause_code,
	intervention,
	intervention_code,
	due_date,
	due_date_id,
	person_responsible,
	cqi_category_id,
	cqi_action_plan_assessment_id
    )
SELECT
	b.cqi_action_plan_id,
	b.category_score,
	b.gap,
	b.root_cause,
	b.root_cause_code,
	b.intervention,
	b.intervention_code,
	b.due_date,
	(SELECT d.date_id FROM derived_recency.dim_cqi_action_plan_due_date d WHERE d.date_yyyymmdd = b.due_date) AS due_date_id,
	b.person_responsible,
	b.cqi_category_id,
	b.cqi_action_plan_assessment_id
FROM
	base.fact_cqi_action_plan b
WHERE 
	b.category_score IS NOT NULL 
AND 
	b.gap IS NOT NULL 
AND 
	b.root_cause IS NOT NULL 
AND 
	b.intervention IS NOT NULL 
AND 
	b.due_date IS NOT NULL 
AND 
	b.cqi_category_id IS NOT NULL 
AND 
	b.cqi_action_plan_assessment_id IS NOT NULL;

-- $END

GO

SELECT  * 
FROM 
derived_recency.fact_cqi_action_plan;