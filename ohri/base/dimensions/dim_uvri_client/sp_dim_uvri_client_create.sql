USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS  base.dim_uvri_client;

-- $BEGIN

CREATE TABLE base.dim_uvri_client (
  uvri_client_id UNIQUEIDENTIFIER NOT NULL,
  sex NVARCHAR(255) NULL,
  hts_number_uvri NVARCHAR(255) NULL,
  lab_number nvarchar(255) NULL
);
ALTER TABLE [base].dim_uvri_client ADD CONSTRAINT PK_uvri_client_id PRIMARY KEY ([uvri_client_id]);

-- $END