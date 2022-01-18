USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

DROP TABLE IF EXISTS derived_recency.dim_client;

CREATE TABLE derived_recency.dim_client (
    client_id UNIQUEIDENTIFIER NOT NULL,
    sex NVARCHAR(255) NULL,
    date_of_birth DATE  NULL,
    date_of_birth_id INT NULL,
    marital_status NVARCHAR(255) NULL,
    is_in_hts_client_card SMALLINT NULL,
    is_in_uvri_lab_data SMALLINT NULL,
    hts_number_hts_client_card NVARCHAR(255) NULL,
    hts_number_uvri NVARCHAR(255) NULL,
    consented BIT NULL,
    parish NVARCHAR(255) NULL,
    subcounty NVARCHAR(255) NULL,
    district NVARCHAR(255) NULL
);

ALTER TABLE derived_recency.dim_client ADD CONSTRAINT PK_derived_client_id PRIMARY KEY (client_id);
ALTER TABLE derived_recency.dim_client ADD CONSTRAINT FK_derived_date_of_birth_id
FOREIGN KEY (date_of_birth_id) references derived_recency.dim_date (date_id);

-- $END