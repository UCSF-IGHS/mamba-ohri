USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [derived_recency].[dim_cqi_category];

-- $BEGIN

CREATE TABLE [derived_recency].[dim_cqi_category](
	[cqi_category_id] [uniqueidentifier] PRIMARY KEY,
	[code] [integer] NOT NULL UNIQUE,
	[name] [nvarchar](255) NOT NULL
);

-- $END