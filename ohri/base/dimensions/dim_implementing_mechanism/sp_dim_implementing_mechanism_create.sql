USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS  base.dim_implementing_mechanism;

-- $BEGIN

CREATE TABLE base.dim_implementing_mechanism (
  implementing_mechanism_id UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [name] NVARCHAR(255) NULL,
  ip_name NVARCHAR(255) NULL,
  agency NVARCHAR(255) NULL,
  composite_id NVARCHAR(255) NULL
);
ALTER TABLE [base].dim_implementing_mechanism ADD CONSTRAINT PK_implementing_mechanism_id PRIMARY KEY ([implementing_mechanism_id]);

-- $END