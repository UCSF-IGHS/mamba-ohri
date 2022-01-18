USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

UPDATE 
    derived_recency.dim_client
SET 
    sex = NULL,
    date_of_birth = NULL,
    date_of_birth_id = NULL,
    marital_status = NULL
WHERE
    consented = 0
    OR
    consented IS NULL;

-- $END   