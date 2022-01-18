USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE [derived_recency].[dim_cqi_indicator];

-- $BEGIN

INSERT INTO [derived_recency].[dim_cqi_indicator]
(
	cqi_indicator_id,
	[sequence],
	attribute_name,
	label,
	display,
	data_type,
	cqi_category_id
)
SELECT
	i.cqi_indicator_id,
	i.indicator_number,
	i.attribute_name,
	i.label,
	i.display,
	i.data_type,
	i.cqi_category_id
FROM
	[base].[dim_cqi_indicator] i 
WHERE
	display = 1
	 
-- $END

SELECT 
	*
FROM
	[derived_recency].[dim_cqi_indicator]
ORDER BY 
	[sequence];