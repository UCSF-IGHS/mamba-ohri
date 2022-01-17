USE recency_uganda_prod_analysis_test;
Go

TRUNCATE TABLE base.dim_hub;

-- $BEGIN

INSERT INTO base.dim_hub (
    hub_id,
    [name]
)
SELECT
    NEWID(),
    h.name
FROM
    (
        SELECT DISTINCT
            [Hub] AS [name]
        FROM 
            [external].recency_uvri_results
        WHERE
            [Hub] IS NOT NULL
    ) AS h

-- $END