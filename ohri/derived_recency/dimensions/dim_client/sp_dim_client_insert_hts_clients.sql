USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

INSERT INTO derived_recency.dim_client (
    client_id,
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
    hts_client_id,
    sex,
    date_of_birth,
    date_of_birth_id,
    marital_status,
    1 AS is_in_hts_client_card,
    NULL AS is_in_uvri_lab_data,
    hts_number_hts_client_card,
    NULL AS hts_number_uvri,
    consented,
    parish,
    subcounty,
    district
FROM 
    [base].dim_hts_client
WHERE
    hts_number_hts_client_card IS NOT NULL
    AND
    consented = 1;

-- $END   