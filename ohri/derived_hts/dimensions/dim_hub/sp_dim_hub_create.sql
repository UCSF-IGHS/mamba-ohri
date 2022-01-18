USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

DROP TABLE IF EXISTS derived_recency.dim_hub;

CREATE TABLE derived_recency.dim_hub(
    hub_id UNIQUEIDENTIFIER NOT NULL,
    [name] NVARCHAR(255) NOT NULL
);
ALTER TABLE [derived_recency].dim_hub ADD CONSTRAINT PK_derived_hub_id PRIMARY KEY ([hub_id]);

-- $END