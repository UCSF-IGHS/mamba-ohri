USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [derived_recency].[fact_cqi_assessment_indicator_score];

-- $BEGIN

CREATE TABLE [derived_recency].[fact_cqi_assessment_indicator_score](
	[cqi_assessment_indicator_score_id] [uniqueidentifier] PRIMARY KEY,
	[cqi_indicator_id] [uniqueidentifier] NULL,
	[value] [real] NOT NULL,
	[comment] [nvarchar](255) NULL,
	[cqi_assessment_id] [uniqueidentifier] NOT NULL,
	_attribute_name [nvarchar](255)
);


ALTER TABLE [derived_recency].fact_cqi_assessment_indicator_score ADD 
CONSTRAINT FK_indicator_score_assessment
FOREIGN KEY ([cqi_assessment_id]) REFERENCES derived_recency.dim_cqi_assessment ([cqi_assessment_id]);

ALTER TABLE [derived_recency].fact_cqi_assessment_indicator_score ADD 
CONSTRAINT FK_indicator_score_indicator
FOREIGN KEY ([cqi_indicator_id]) REFERENCES derived_recency.dim_cqi_indicator ([cqi_indicator_id]);

-- $END