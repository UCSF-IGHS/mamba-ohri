USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS  base.dim_hts_client;

-- $BEGIN

CREATE TABLE base.dim_hts_client (
  hts_client_id UNIQUEIDENTIFIER NOT NULL,
  sex NVARCHAR(255) NULL,
  date_of_birth DATE  NULL,
  date_of_birth_id INT NULL,
  marital_status NVARCHAR(255) NULL,
  hts_number_hts_client_card NVARCHAR(255) NULL,
  hts_record_id INT NOT NULL,
  consented BIT NULL,
  hts_client_composite_id NVARCHAR(MAX),
  parish NVARCHAR(255) NULL,
  subcounty NVARCHAR(255) NULL,
  district NVARCHAR(255) NULL
);
ALTER TABLE [base].dim_hts_client ADD CONSTRAINT PK_hts_client_id PRIMARY KEY ([hts_client_id]);
ALTER TABLE [base].dim_hts_client ADD CONSTRAINT FK_hts_client_date_of_birth_id FOREIGN KEY ([date_of_birth_id])
REFERENCES [base].dim_date ([date_id]);

-- $END