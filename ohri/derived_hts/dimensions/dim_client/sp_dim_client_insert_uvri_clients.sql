USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

INSERT INTO derived_recency.dim_client (
    client_id,
    registering_facility_id,
    sex,
    date_of_birth,
    date_of_birth_id,
    marital_status,
    is_in_hts_client_card,
    is_in_uvri_lab_data,
    hts_number_hts_client_card,
    hts_number_uvri,
    consented,
    parish,
    subcounty,
    district 
)
SELECT
    uvri_client_id AS client_id,
    u.registering_facility_id,
    u.sex,
    NULL AS date_of_birth_id,
    NULL AS date_of_birth_id,
    NULL AS marital_status,
    0 AS is_in_hts_client_card,
    1 AS is_in_uvri_lab_data,
    NULL AS hts_number_hts_client_card,
    u.hts_number_uvri,
    NULL AS consented,
    NULL AS parish,
    NULL AS subcounty,
    NULL AS district
FROM 
    base.dim_uvri_client u
    LEFT JOIN
    [derived_recency].dim_client c
        ON u.registering_facility_id = c.registering_facility_id
        AND u.hts_number_uvri = c.hts_number_hts_client_card
WHERE
    c.registering_facility_id IS NULL
    AND
    c.hts_number_hts_client_card IS NULL;

-- $END   