USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE derived_recency.dim_facility;

-- $BEGIN

INSERT INTO derived_recency.dim_facility (
    facility_id,
    implementing_mechanism_id,
    [name],
    dhis2_uid,
    coordinates,
    longitude,
    latitude,
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
    last_uploaded_on_id, 
    activation_date,
    activation_date_id  
)
SELECT 
    facility_id,
    implementing_mechanism_id,
    [name],
    dhis2_uid,
    coordinates,
    (
    CASE 
        WHEN coordinates <> '' AND coordinates IS NOT NULL THEN 
        CAST(TRIM(SUBSTRING(Coordinates,CHARINDEX('[',Coordinates)+1,(((LEN(Coordinates))-CHARINDEX(',', REVERSE(Coordinates)))-CHARINDEX('[',Coordinates)))) AS decimal(10,6))
        ELSE 
            NULL
    END 
    ) AS longitude,
    (
    CASE 
        WHEN coordinates <> '' AND coordinates IS NOT NULL THEN 
        CAST(TRIM(SUBSTRING(Coordinates,CHARINDEX(',',Coordinates)+1, ((LEN(coordinates)-1) - CHARINDEX(',',coordinates)))) AS decimal(10,6))
        ELSE 
            NULL
    END 
    ) AS latitude,
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
    (
        SELECT
        date_id
    FROM
    derived_recency.dim_last_uploaded_on_date
    WHERE
        date_yyyymmdd = last_uploaded_on
    ),
    activation_date,
    (
        SELECT
        date_id
    FROM
    derived_recency.dim_activation_date
    WHERE
        date_yyyymmdd = activation_date
    )
FROM 
    [base].dim_facility
WHERE
    facility_id IN (
        SELECT  DISTINCT
            h.facility_id
        FROM base.fact_hts_emr h
    ) 
    OR
    facility_id IN (
        SELECT  DISTINCT
            facility_id
        FROM base.fact_cqi_assessment
    ) 
    OR
    facility_id IN (
        SELECT  DISTINCT
            facility_id
        FROM base.fact_cqi_shortened_assessment
    )
    OR facility_id IN (
        SELECT DISTINCT
            facility_id
        FROM
            base.dim_cqi_action_plan_assessment
    )
ORDER BY facility_id

-- $END

SELECT TOP 100 district 
FROM derived_recency.dim_facility;