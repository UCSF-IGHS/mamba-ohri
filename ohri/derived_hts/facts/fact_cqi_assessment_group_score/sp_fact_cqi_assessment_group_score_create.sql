USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [derived_recency].[fact_cqi_assessment_group_score];

-- $BEGIN

CREATE TABLE [derived_recency].[fact_cqi_assessment_group_score]
(
    cqi_assessment_group_score_id uniqueidentifier PRIMARY KEY,
    cqi_category_id uniqueidentifier NULL,
    score real NULL,
    cqi_assessment_id uniqueidentifier NOT NULL
)


ALTER TABLE [derived_recency].fact_cqi_assessment_group_score ADD 
CONSTRAINT FK_group_score_category
FOREIGN KEY ([cqi_category_id]) REFERENCES derived_recency.dim_cqi_category([cqi_category_id]);

ALTER TABLE [derived_recency].fact_cqi_assessment_group_score ADD 
CONSTRAINT FK_cqi_assessment_group_score
FOREIGN KEY ([cqi_assessment_id]) REFERENCES derived_recency.dim_cqi_assessment ([cqi_assessment_id]);

-- $END