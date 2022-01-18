USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.dim_facility;

-- $BEGIN

CREATE TABLE base.dim_facility (
  facility_id uniqueidentifier  NOT NULL,
  implementing_mechanism_id uniqueidentifier NULL,
  [name] nvarchar(255) NULL,
  dhis2_uid nvarchar(255) NULL,
  coordinates nvarchar(255) NULL,
  [level] nvarchar(255) NULL,
  sub_county nvarchar(255) NULL,
  district nvarchar(255) NULL,
  region nvarchar(255) NULL,
  authority_name nvarchar(255) NULL,
  [ownership] nvarchar(255) NULL,
  sub_region nvarchar(255) NULL,
  parish nvarchar(255) NULL,
  country nvarchar(255) NULL,
  last_uploaded_on date NULL,
  activation_date date NULL
);

ALTER TABLE [base].dim_facility ADD CONSTRAINT PK_facility_id PRIMARY KEY ([facility_id]);
ALTER TABLE [base].dim_facility ADD CONSTRAINT FK_implementing_mechanism_id
FOREIGN KEY (implementing_mechanism_id) references base.dim_implementing_mechanism (implementing_mechanism_id);

-- $END