USE recency_uganda_prod_analysis_test;
Go

TRUNCATE TABLE derived_recency.dim_location;

-- $BEGIN

INSERT INTO derived_recency.dim_location (
    location_id,
    [name],
    [name_in_maps],
    [type],
    parent_id
)
SELECT
    location_id,
    [name],
    name_in_maps,
    [type],
    parent_id
FROM
    base.dim_location
WHERE 
    [name] IS NOT NULL
AND
(
    ([type] = 'Subcounty' AND parent_id IS NOT NULL) 

    OR ([type] = 'District' AND parent_id IS NULL)
)

-- $END