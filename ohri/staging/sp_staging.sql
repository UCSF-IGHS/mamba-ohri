USE recency_db_prod_analysis_test;
GO

-- $BEGIN

 PRINT 'Dropping staging tables'
 EXEC dbo.sp_xf_system_drop_all_tables_in_schema 'staging'

PRINT 'Executing sp_staging_recency_hts_client_card'
EXEC staging.sp_staging_recency_hts_client_card;	

-- $END