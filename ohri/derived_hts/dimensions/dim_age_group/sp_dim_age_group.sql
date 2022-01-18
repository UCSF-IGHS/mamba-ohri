USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_age_group_create;
EXEC derived_recency.sp_dim_age_group_insert;

-- $END