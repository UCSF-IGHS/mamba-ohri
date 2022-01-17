USE recency_db_prod_analysis_test;
GO

-- $BEGIN

EXEC staging.sp_staging_recency_hts_client_card_insert;
EXEC staging.sp_staging_recency_hts_client_card_update;	

-- $END
