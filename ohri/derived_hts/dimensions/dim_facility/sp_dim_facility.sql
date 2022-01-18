USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_facility_create;
EXEC derived_recency.sp_dim_facility_insert;

-- $END