USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [base].[dim_cqi_category];

-- $BEGIN

CREATE TABLE [base].[dim_cqi_category](
	[cqi_category_id] [uniqueidentifier] PRIMARY KEY,
	[code] [bigint] NOT NULL UNIQUE,
	[name] [nvarchar](255) NOT NULL
);

-- $END