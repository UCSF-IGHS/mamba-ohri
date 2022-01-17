USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.dim_hub;

-- $BEGIN

CREATE TABLE base.dim_hub(
    hub_id UNIQUEIDENTIFIER NOT NULL,
    name NVARCHAR(255) NOT NULL
);
ALTER TABLE [base].dim_hub ADD CONSTRAINT PK_hub_id PRIMARY KEY ([hub_id]);

-- $END