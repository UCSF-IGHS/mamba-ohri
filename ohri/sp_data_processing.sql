USE recency_uganda_prod_analysis_test;
GO

-- sp_data_processing.sql
-- This SP is the overall SP that will be used to execute all other stored procedures

-- $BEGIN

-- Drop DB constraints

EXEC staging.sp_staging
EXEC base.sp_data_processing;
EXEC derived_recency.sp_data_processing;

-- $END
