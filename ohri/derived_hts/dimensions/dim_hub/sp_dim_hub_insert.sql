USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE derived_recency.dim_hub;

-- $BEGIN

INSERT INTO derived_recency.dim_hub (
    hub_id,
    [name]
)
SELECT 
    hub_id,
    [name]
FROM
    [base].dim_hub;

-- $END