USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS staging.recency_hts_client_card;

-- $BEGIN


SELECT
	*
INTO
	staging.recency_hts_client_card
FROM
	[external].recency_hts_client_card
	
-- $END
