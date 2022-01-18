USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.dim_facility;
    
-- $BEGIN

INSERT INTO base.dim_facility (
    facility_id,
    implementing_mechanism_id,
    [name],
    dhis2_uid,
    coordinates,
    [level],
    sub_county,
    district,
    region,
    authority_name,
    [ownership],
    sub_region,
    parish,
    country,
    last_uploaded_on,
    activation_date
)
SELECT 
    NEWID() AS facility_id,
    NULL,
    [name],
    [uid] AS dhis2_uid,
    (
    CASE
        WHEN coordinates IS NULL THEN NULL
        WHEN coordinates = '' THEN ''
        WHEN ISJSON(coordinates) = 1 THEN JSON_QUERY(coordinates,'$.coordinates')
        Else NULL
    END
    )
     ,
    FACILITY_LEVEL AS [level],
    SUBCOUNTY AS sub_county,
    TRIM(REPLACE(DISTRICT,'District','')) AS district,
    NULL AS region,
    AUTHORITY_NAME AS authority_name,
    OWNERSHIP_NAME AS [ownership],
    [sub_region] AS sub_region,
    NULL AS parish,
    'Uganda' AS country,
    NULL as last_uploaded_on,
    NULL as activation_date
FROM 
    [external].ug_mfl;



--Add a record for unknown facilities
INSERT INTO base.dim_facility
        VALUES(CAST('00000000-0000-0000-0000-000000000000' AS UNIQUEIDENTIFIER), 
        NULL,'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 
        'Unknown','Unknown','Unknown','Unknown','Uganda',NULL,NULL);
   
-- $END

SELECT TOP 100 district 
FROM base.dim_facility;