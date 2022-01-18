USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE derived_recency.fact_cqi_action_plan_followup;

-- $BEGIN

INSERT INTO
	derived_recency.fact_cqi_action_plan_followup(
	cqi_action_plan_followup_id,
	due_date_changed,
	is_due_date_changed,
	new_due_date,
	new_due_date_id,
	progress_to_date,
	challenges,
	action_taken,
	outcome,
	abandon_reason,
	cqi_category_id,
	cqi_action_plan_assessment_id
    )
SELECT
	b.cqi_action_plan_followup_id,
	b.due_date_changed,
	b.is_due_date_changed,
	b.new_due_date,
	(SELECT d.date_id FROM derived_recency.dim_cqi_action_plan_followup_new_due_date d WHERE d.date_yyyymmdd = b.new_due_date) AS new_due_date_id,
	b.progress_to_date,
	b.challenges,
	b.action_taken,
	b.outcome,
	b.abandon_reason,
	b.cqi_category_id,
	b.cqi_action_plan_assessment_id
FROM
	base.fact_cqi_action_plan_followup b
	WHERE 
	b.cqi_category_id IS NOT NULL 
	AND 
	b.cqi_action_plan_assessment_id IS NOT NULL;
	
-- $END


GO

SELECT  * 
FROM 
derived_recency.fact_cqi_action_plan_followup;