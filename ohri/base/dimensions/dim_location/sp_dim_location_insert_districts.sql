USE recency_uganda_prod_analysis_test;
Go

TRUNCATE TABLE base.dim_location;

-- $BEGIN

INSERT INTO base.dim_location (
    location_id,
    [name],
    name_in_maps,
    [type],
    parent_id
)
SELECT
    NEWID(),
    q.district AS [name],
    q.district AS [name_in_maps],
    'District' AS [type],
    NULL AS parent_id
FROM
    (
        SELECT DISTINCT
            h.health_unit_district AS district
        FROM 
	        [z].recency_hts_client_card h 
        WHERE 
            health_unit_district IS NOT NULL 
        AND 
            health_unit_district NOT LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        AND 
            health_unit_district NOT LIKE '%[0-9][0-9][0-9][0-9]%'
        AND 
            health_unit_district <> ','
        AND 
            health_unit_district <> 'F'
        AND 
            health_unit_district <> 'M'
    )q
ORDER BY 
    [type],[name];


INSERT INTO base.dim_location (
    location_id,
    [name],
    name_in_maps,
    [type],
    parent_id
)
VALUES(
    NEWID(),
    'Unknown',
    'Unknown',
    'District',
    NULL
)
    
-- $END