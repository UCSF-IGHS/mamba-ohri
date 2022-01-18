USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_implementing_mechanism_create;
EXEC derived_recency.sp_dim_implementing_mechanism_insert;

-- $END