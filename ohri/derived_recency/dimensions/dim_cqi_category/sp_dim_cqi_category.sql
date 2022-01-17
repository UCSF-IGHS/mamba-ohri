USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_cqi_category_create;
EXEC derived_recency.sp_dim_cqi_category_insert;

-- $END