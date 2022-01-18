USE recency_uganda_prod_analysis_test;
Go


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
    q.subcounty AS [name],
    q.subcounty AS name_in_maps,
    'Subcounty' AS [type],
    (
    SELECT 
        location_id
    FROM 
        base.dim_location
    WHERE 
        q.district IS NOT NULL 
    AND 
        [name] = q.district 
    AND 
        type = 'District'
    ) AS parent_id
    
FROM
    (
        SELECT DISTINCT
            h.health_unit_sub_county AS subcounty,
            h.health_unit_district AS district
        FROM 
	        [z].recency_hts_client_card h 
        WHERE 
            health_unit_sub_county IS NOT NULL
        AND 
            health_unit_sub_county NOT LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        AND 
            health_unit_sub_county NOT LIKE '%[0-9][0-9][0-9][0-9]%'
        AND 
            health_unit_sub_county <> ','
        AND 
            health_unit_sub_county <> 'F'
        AND 
            health_unit_sub_county <> 'M'
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
    'Subcounty',
    (
    SELECT
        location_id 
    FROM 
        base.dim_location 
    WHERE 
        [name] = 'Unknown'
    AND 
        [type] = 'District'
    )
)
-- $END