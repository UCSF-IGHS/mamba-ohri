USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_location_create;
EXEC derived_recency.sp_dim_location_insert;

-- $END