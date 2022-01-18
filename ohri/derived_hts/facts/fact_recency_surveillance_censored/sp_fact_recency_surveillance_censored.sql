USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC derived_recency.sp_fact_recency_surveillance_censored_create;
EXEC derived_recency.sp_fact_recency_surveillance_censored_insert;

-- $END