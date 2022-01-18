USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [derived_recency].[dim_cqi_indicator];

-- $BEGIN

CREATE TABLE [derived_recency].[dim_cqi_indicator](
    [cqi_indicator_id] [uniqueidentifier] PRIMARY KEY,
	[sequence] [integer] NOT NULL,
    [attribute_name] [nvarchar](255) NOT NULL, 
    [label] [nvarchar](255) NOT NULL,
    [display] [tinyint] NOT NULL,
    [data_type] [nvarchar](255) NOT NULL,
    [cqi_category_id] [uniqueidentifier] NOT NULL,
    FOREIGN KEY (cqi_category_id) REFERENCES derived_recency.dim_cqi_category (cqi_category_id)
);

-- $END