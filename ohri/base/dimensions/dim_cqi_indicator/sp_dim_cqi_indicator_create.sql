USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [base].[dim_cqi_indicator];

-- $BEGIN

CREATE TABLE [base].[dim_cqi_indicator](
    [cqi_indicator_id] [uniqueidentifier] PRIMARY KEY,
	[indicator_number] [bigint] NOT NULL UNIQUE,
    [attribute_name] [nvarchar](255) NOT NULL UNIQUE, 
    [label] [nvarchar](255) NOT NULL,
    [cqi_category_id] [uniqueidentifier] NOT NULL,
    [display] [bigint],
    [data_type] [nvarchar](255) NOT NULL
);

ALTER TABLE [base].[dim_cqi_indicator] ADD 
CONSTRAINT FK_indicator_category
FOREIGN KEY ([cqi_category_id]) REFERENCES  [base].[dim_cqi_category]([cqi_category_id]);

-- $END