USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS staging.staging_cqi_action_plan;

-- $BEGIN

WITH cqi_action_plan_cte AS (
    SELECT
        ap.cqi_action_plan_id,
        ap.root_cause,
        ap.root_cause_code,
        ap.intervention,
        ap.intervention_code,
        cat.[code] AS category_code,
        ass.[_uri] AS action_plan_uri  
    FROM
        base.fact_cqi_action_plan as ap 
    INNER JOIN
        base.dim_cqi_category AS cat
        ON 
            ap.cqi_category_id = cat.cqi_category_id
    INNER JOIN
        base.dim_cqi_action_plan_assessment AS ass
        ON 
            ap.cqi_action_plan_assessment_id = ass.cqi_action_plan_assessment_id
)


SELECT
	*
INTO
	staging.staging_cqi_action_plan
FROM
	cqi_action_plan_cte
	
-- $END