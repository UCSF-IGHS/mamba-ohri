USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_hub_create;
EXEC base.sp_dim_hub_insert_from_uvri_lab_data;

-- $END