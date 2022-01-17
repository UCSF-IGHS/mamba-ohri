USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.fact_hts_emr;

-- $BEGIN

CREATE TABLE base.fact_hts_emr (
    hts_emr_id uniqueidentifier NOT NULL,
    hts_client_id uniqueidentifier NULL,
    facility_id uniqueidentifier NULL,
    location_id uniqueidentifier NULL,
    hts_record_id INT NOT NULL,
    serial_number nvarchar(255) NULL,
    encounter_uuid nvarchar(255) NULL,
    visit_date date NULL,
    visit_date_id INT NULL,
    accompanied_by nvarchar(255) NULL,
    accompanied_by_other nvarchar(255) NULL,
    hts_delivery_model nvarchar(255) NULL,
    hts_approach nvarchar(255) NULL,
    entry_point nvarchar(255) NULL,
    entry_point_other nvarchar(255) NULL,
    community_testing_entry_point nvarchar(255) NULL,
    community_testing_entry_point_other nvarchar(255) NULL,
    reason_for_testing nvarchar(255) NULL,
    reason_for_testing_other nvarchar(255) NULL,
    special_category nvarchar(255) NULL,
    special_category_other nvarchar(255) NULL,
    hiv_final_test_result nvarchar(255) NULL,
    hiv_final_syphillis_duo_result nvarchar(255) NULL,
    is_first_time_hiv_test SMALLINT NULL,
    last_hiv_test_date date NULL,
    last_hiv_test_date_id int NULL,
    last_hiv_test_result nvarchar(255) NULL,
    recency_test_consent int NULL,
    field_rtri_result nvarchar(255) NULL
);

ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT PK_hts_emr_id PRIMARY KEY ([hts_emr_id]);
ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT FK_hts_emr_visit_date_id FOREIGN KEY ([visit_date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT FK_hts_emr_last_hiv_test_date_id FOREIGN KEY ([last_hiv_test_date_id]) REFERENCES [base].dim_date ([date_id]);

ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT FK_hts_emr_facility_id FOREIGN KEY ([facility_id]) REFERENCES [base].dim_facility ([facility_id]);
ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT FK_hts_emr_hts_client_id FOREIGN KEY ([hts_client_id]) REFERENCES [base].dim_hts_client ([hts_client_id]);

ALTER TABLE [base].fact_hts_emr ADD CONSTRAINT FK_hts_emr_hts_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);

-- $END

