USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS derived_recency.fact_recency_surveillance;

-- $BEGIN

CREATE TABLE derived_recency.fact_recency_surveillance (
    recency_surveillance_id UNIQUEIDENTIFIER  NOT NULL,
    _is_censored INT NULL,
    censored_reason NVARCHAR(255) NULL,
    encounter_uuid NVARCHAR(255) NULL,
    visit_date DATE NULL,
    visit_date_id INT NULL,
    accompanied_by NVARCHAR(255) NULL,
    accompanied_by_other NVARCHAR(255) NULL,
    hts_delivery_model NVARCHAR(255) NULL,
    hts_approach NVARCHAR(255) NULL,
    entry_point NVARCHAR(255) NULL,
    entry_point_other NVARCHAR(255) NULL,
    community_testing_entry_point NVARCHAR(255) NULL,
    community_testing_entry_point_other NVARCHAR(255) NULL,
    reason_for_testing NVARCHAR(255) NULL,
    reason_for_testing_other NVARCHAR(255) NULL,
    is_eligible_for_recency INT NULL,
    special_category NVARCHAR(255) NULL,
    special_category_other NVARCHAR(255) NULL,
    hiv_final_test_result nvarchar(255) NULL,
    hiv_final_syphillis_duo_result nvarchar(255) NULL,
    is_first_time_hiv_test INT NULL,
    last_hiv_test_result NVARCHAR(255) NULL,
    last_hiv_test_date DATE NULL,
    last_hiv_test_date_id INT NULL,
    age_at_test INT NULL,
    recency_test_consent INT NULL,
    emr_field_rtri_result NVARCHAR(255) NULL,
    lab_number NVARCHAR(255) NULL,
    sample_collection_date DATE NULL,
    sample_collection_date_id INT NULL,
    sample_registration_date DATE NULL,
    sample_registration_date_id INT NULL,
    sample_registration_time NVARCHAR(255) NULL,
    lab_age_at_test INT NULL,
    age_group_id INT NULL,
    lab_field_rtri_result NVARCHAR(255) NULL,
    field_rtri_result NVARCHAR(255) NULL,
    kit_lot_number NVARCHAR(255) NULL,
    kit_expiry_date DATE NULL,
    kit_expiry_date_id INT NULL,
    uvri_test_date DATE NULL,
    uvri_test_date_id INT NULL,
    uvri_sample_id NVARCHAR(255) NULL,
    control_line INT NULL,
    verification_line INT NULL,
    longterm_line INT NULL,
    lab_rtri_result NVARCHAR(255),
    lab_rtri_result_is_recent TINYINT NULL,
    lab_rtri_result_is_longterm TINYINT NULL,
    lab_rtri_result_is_negative TINYINT NULL,
    lab_rtri_result_is_invalid TINYINT NULL,
    lab_rtri_result_is_missing TINYINT NULL,
    final_rtri_result NVARCHAR(255),
    final_rtri_result_is_recent TINYINT NULL,
    final_rtri_result_is_longterm TINYINT NULL,
    final_rtri_result_is_negative TINYINT NULL,
    final_rtri_result_is_invalid TINYINT NULL,
    final_rtri_result_is_missing TINYINT NULL,
    viral_load NVARCHAR(255) NULL,
    viral_load_count BIGINT NULL,
    viral_load_count_undetectable INT NULL,
    is_virally_suppressed INT NULL,
    viral_load_date DATE NULL,
    viral_load_date_id INT NULL,
    lab_rita_result NVARCHAR(255) NULL,
    lab_rita_result_is_recent TINYINT NULL,
    lab_rita_result_is_longterm TINYINT NULL,
    lab_rita_result_is_invalid TINYINT NULL,
    lab_rita_result_is_negative TINYINT NULL,
    lab_rita_result_is_missing TINYINT NULL,
    final_recency_result NVARCHAR(255) NULL,
    final_recency_result_is_recent TINYINT NULL,
    final_recency_result_is_longterm TINYINT NULL,
    final_recency_result_is_negative TINYINT NULL,
    final_recency_result_is_missing TINYINT NULL,
    final_recency_result_is_invalid TINYINT NULL,
    is_rtri_recent TINYINT NULL,
    is_rtri_long_term TINYINT NULL,
    is_rtri_negative TINYINT NULL,
    is_rtri_missing TINYINT NULL,
    is_rtri_invalid TINYINT NULL,
    client_id UNIQUEIDENTIFIER NULL,
    facility_id UNIQUEIDENTIFIER  NULL,
    hub_id UNIQUEIDENTIFIER  NULL,
    location_id UNIQUEIDENTIFIER NULL
);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT PK_recency_surveillance_id 
PRIMARY KEY ([recency_surveillance_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT FK_surv_visit_date_id 
FOREIGN KEY ([visit_date_id]) REFERENCES derived_recency.dim_visit_date ([date_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT FK_surv_last_hiv_date_id 
FOREIGN KEY ([last_hiv_test_date_id]) REFERENCES derived_recency.dim_last_hiv_test_date ([date_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT FK_surv_age_group_id 
FOREIGN KEY (age_group_id) REFERENCES derived_recency.dim_age_group (age_group_id);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_samp_coll_date_id 
-- FOREIGN KEY ([sample_collection_date_id]) REFERENCES derived_recency.dim_sample_collection_date ([date_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_samp_reg_date_id 
-- FOREIGN KEY ([sample_registration_date_id]) REFERENCES derived_recency.dim_sample_registration_date ([date_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_kit_exp_date_id 
-- FOREIGN KEY ([kit_expiry_date_id]) REFERENCES derived_recency.dim_kit_expiry_date ([date_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_uvri_test_date_id 
-- FOREIGN KEY ([uvri_test_date_id]) REFERENCES derived_recency.dim_uvri_test_date ([date_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_viral_load_date_id 
-- FOREIGN KEY ([viral_load_date_id]) REFERENCES derived_recency.dim_viral_load_date ([date_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_facility_id 
-- FOREIGN KEY ([facility_id]) REFERENCES [derived_recency].dim_facility ([facility_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT FK_surv_client_id 
FOREIGN KEY ([client_id]) REFERENCES [derived_recency].dim_client ([client_id]);

-- ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
-- CONSTRAINT FK_surv_hub_id 
-- FOREIGN KEY ([hub_id]) REFERENCES [derived_recency].dim_hub ([hub_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance ADD 
CONSTRAINT FK_location_id 
FOREIGN KEY ([location_id]) REFERENCES [derived_recency].dim_location ([location_id]);

-- $END

