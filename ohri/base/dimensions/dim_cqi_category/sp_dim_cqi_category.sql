USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_cqi_category_create;
EXEC base.sp_dim_cqi_category_insert;

-- $END