USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

UPDATE base.dim_hts_client
SET
    sex = 'Female'
WHERE sex = 'F';

UPDATE base.dim_hts_client
SET
    sex = 'Male'
WHERE sex = 'M';

-- $END

 SELECT TOP 100 * FROM base.dim_hts_client;  