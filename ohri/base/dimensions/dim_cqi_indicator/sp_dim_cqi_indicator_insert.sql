USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE [base].[dim_cqi_indicator];

-- $BEGIN

INSERT INTO base.dim_cqi_indicator 
(
	cqi_indicator_id,
	indicator_number,
	attribute_name,
	label,
	cqi_category_id,
	display,
	data_type
)
SELECT
	NEWID() as cqi_indicator_id,
	indicator_number,
	attribute_name,
	label,
	(SELECT cqi_category_id FROM base.dim_cqi_category WHERE [name] = category) AS cqi_category_id,
	display,
	data_type
FROM
	[external].form_cqi_checklist_metadata m
WHERE
	display = '1'

-- $END

SELECT TOP 100 * FROM base.dim_cqi_indicator;