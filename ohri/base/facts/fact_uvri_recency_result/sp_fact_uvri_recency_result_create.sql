USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.fact_uvri_recency_result;

-- $BEGIN

CREATE TABLE base.fact_uvri_recency_result (
    uvri_recency_result_id uniqueidentifier NOT NULL,
    uvri_client_id uniqueidentifier NULL,
    facility_id uniqueidentifier NULL,
    hub_id uniqueidentifier NULL,
    fno nvarchar(255) NULL,
    lab_number nvarchar(255) NULL,
    sample_collection_date date NULL,
    sample_collection_date_id INT NULL,
    sample_registration_date date NULL,
    sample_registration_date_id INT NULL,
    sample_registration_time nvarchar(255) NULL,
    age int NULL,
    lab_field_rtri_result nvarchar(255) NULL,
    kit_lot_number nvarchar(255) NULL,
    kit_expiry_date date NULL,
    kit_expiry_date_id INT NULL,
    uvri_test_date date NULL,
    uvri_test_date_id INT NULL,
    uvri_sample_id nvarchar(255) NULL,
    control_line SMALLINT NULL,
    verification_line SMALLINT NULL,
    longterm_line SMALLINT NULL,
    lab_rtri_result nvarchar(255),
    viral_load nvarchar(255) NULL,
    viral_load_date date NULL,
    viral_load_date_id INT NULL
);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT PK_uvri_id PRIMARY KEY ([uvri_recency_result_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_samp_coll_date_id 
FOREIGN KEY ([sample_collection_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_samp_reg_date_id 
FOREIGN KEY ([sample_registration_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_kit_exp_date_id 
FOREIGN KEY ([kit_expiry_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_uvri_test_date_id 
FOREIGN KEY ([uvri_test_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_viral_load_date_id 
FOREIGN KEY ([viral_load_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_facility_id 
FOREIGN KEY ([facility_id]) REFERENCES [base].dim_facility ([facility_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_client_id 
FOREIGN KEY ([uvri_client_id]) REFERENCES [base].dim_uvri_client ([uvri_client_id]);

ALTER TABLE [base].fact_uvri_recency_result ADD 
CONSTRAINT FK_uvri_hub_id 
FOREIGN KEY ([hub_id]) REFERENCES [base].dim_hub ([hub_id]);

-- $END

