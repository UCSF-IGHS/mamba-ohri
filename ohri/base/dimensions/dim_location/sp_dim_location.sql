USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_location_create;
EXEC base.sp_dim_location_insert_districts;
EXEC base.sp_dim_location_insert_subcounties;

-- $END