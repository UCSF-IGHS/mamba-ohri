USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_cqi_assessment_create;
EXEC derived_recency.sp_dim_cqi_assessment_insert;
EXEC derived_recency.sp_dim_cqi_assessment_trim_date_dimensions;

-- $END