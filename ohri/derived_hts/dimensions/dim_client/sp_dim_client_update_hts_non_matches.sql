USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

UPDATE derived_recency.dim_client
SET
    is_in_uvri_lab_data = 0
WHERE 
    is_in_hts_client_card = 1
    AND
    is_in_uvri_lab_data IS NULL;

-- $END   