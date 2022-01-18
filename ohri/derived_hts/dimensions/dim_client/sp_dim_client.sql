USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_dim_client_create;
EXEC derived_recency.sp_dim_client_insert_hts_clients;
-- EXEC derived_recency.sp_dim_client_update_hts_matches;
-- EXEC derived_recency.sp_dim_client_update_hts_non_matches;
-- EXEC derived_recency.sp_dim_client_insert_uvri_clients;
EXEC derived_recency.sp_dim_client_update_unconsented_fields;

-- $END