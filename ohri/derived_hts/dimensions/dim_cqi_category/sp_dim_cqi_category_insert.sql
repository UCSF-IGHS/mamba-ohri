USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE [derived_recency].[dim_cqi_category];

-- $BEGIN

INSERT INTO [derived_recency].[dim_cqi_category]
(
	cqi_category_id,
	code,
	[name]
)
SELECT
	*
FROM
	[base].[dim_cqi_category]

-- $END

SELECT 
	* 
FROM 
	[derived_recency].[dim_cqi_category]
ORDER BY 
	[code]