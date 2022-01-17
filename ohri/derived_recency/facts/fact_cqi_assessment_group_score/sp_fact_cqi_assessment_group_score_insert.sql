USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

INSERT INTO [derived_recency].[fact_cqi_assessment_group_score]
(
    cqi_assessment_group_score_id,
    cqi_category_id,
    score,
    cqi_assessment_id
)
SELECT 
    NEWID() AS cqi_assessment_group_score_id,
    cqi_category_id,
    AVG(value) AS score,
    cqi_assessment_id

FROM
    [derived_recency].[fact_cqi_assessment_indicator_score] cis
INNER JOIN
    [derived_recency].[dim_cqi_indicator] i ON i.cqi_indicator_id = cis.cqi_indicator_id
GROUP BY 
    cis.cqi_assessment_id,
    i.cqi_category_id

-- $END

SELECT TOP 100 * FROM [derived_recency].[fact_cqi_assessment_group_score]