USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN


-- clean Fort Portal RRH
DECLARE @facility_id UNIQUEIDENTIFIER;

SELECT
    @facility_id = facility_id
FROM 
    base.dim_facility f 
WHERE 
    f.name = 'Fort Portal Regional Referral Hospital'

UPDATE
    base.dim_uvri_client
SET
    registering_facility_id = @facility_id
FROM 
    base.dim_uvri_client
WHERE
    lab_number IN (
    SELECT 
        LabNo
    FROM
        [external].recency_uvri_results
    WHERE
        LOWER(Submitter) IN (
            'fortportal hospital',
            'fortportal rr hosp'
        )
)


-- clean Tooro Kahuna HC III
SELECT @facility_id = NULL;

SELECT
    @facility_id = facility_id
FROM 
    base.dim_facility f 
WHERE 
    f.name = 'Toro Kahuna HC III'

UPDATE
    base.dim_uvri_client
SET
    registering_facility_id = @facility_id
FROM 
    base.dim_uvri_client
WHERE
    lab_number IN (
    SELECT 
        LabNo
    FROM
        [external].recency_uvri_results
    WHERE
        LOWER(Submitter) = 'tooro kahuna hciii'
)


-- clean Kicwamba HCIII
SELECT @facility_id = NULL;

SELECT
    @facility_id = facility_id
FROM 
    base.dim_facility f 
WHERE 
    f.name = 'Kicwamba HC III'

UPDATE
    base.dim_uvri_client
SET
    registering_facility_id = @facility_id
FROM 
    base.dim_uvri_client
WHERE
    lab_number IN (
    SELECT 
        LabNo
    FROM
        [external].recency_uvri_results
    WHERE
        LOWER(Submitter) = 'kichwamba hciii (kabarole)'
)


-- clean Karambi (Kabarole) HCIII
SELECT @facility_id = NULL;

SELECT
    @facility_id = facility_id
FROM 
    base.dim_facility f 
WHERE 
    f.name = 'Karambi (Kabarole) HC III'

UPDATE
    base.dim_uvri_client
SET
    registering_facility_id = @facility_id
FROM 
    base.dim_uvri_client
WHERE
    lab_number IN (
    SELECT 
        LabNo
    FROM
        [external].recency_uvri_results
    WHERE
        LOWER(Submitter) = 'karambi hciii-kabarole'
)


-- clean Kabarole COU Hospital
SELECT @facility_id = NULL;

SELECT
    @facility_id = facility_id
FROM 
    base.dim_facility f 
WHERE 
    f.name = 'Kabarole COU Hospital'

UPDATE
    base.dim_uvri_client
SET
    registering_facility_id = @facility_id
FROM 
    base.dim_uvri_client
WHERE
    lab_number IN (
    SELECT 
        LabNo
    FROM
        [external].recency_uvri_results
    WHERE
        LOWER(Submitter) = 'kabarole hospital c.o.u'
)

-- delete UVRI rows without any data
DELETE FROM 
    base.dim_uvri_client 
WHERE 
    lab_number is null;

-- $END