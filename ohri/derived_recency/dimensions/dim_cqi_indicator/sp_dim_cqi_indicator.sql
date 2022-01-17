USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_cqi_indicator_create;
EXEC derived_recency.sp_dim_cqi_indicator_insert;

-- $END