USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_implementing_mechanism_create;
EXEC base.sp_dim_implementing_mechanism_insert;

-- $END