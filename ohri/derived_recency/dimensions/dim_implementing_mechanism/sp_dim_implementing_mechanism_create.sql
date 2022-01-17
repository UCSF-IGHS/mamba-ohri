USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

DROP TABLE IF EXISTS  derived_recency.dim_implementing_mechanism;

CREATE TABLE derived_recency.dim_implementing_mechanism (
  implementing_mechanism_id UNIQUEIDENTIFIER NOT NULL,
  [name] NVARCHAR(255) NULL,
  ip_name NVARCHAR(255) NULL,
  agency NVARCHAR(255) NULL,
  composite_id NVARCHAR(255) NULL
);
ALTER TABLE [derived_recency].dim_implementing_mechanism ADD CONSTRAINT PK_derived_implementing_mechanism_id PRIMARY KEY ([implementing_mechanism_id]);

-- $END