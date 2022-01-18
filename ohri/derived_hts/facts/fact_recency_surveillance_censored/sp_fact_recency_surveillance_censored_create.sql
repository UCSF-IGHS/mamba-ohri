USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS derived_recency.fact_recency_surveillance_censored;

-- $BEGIN

CREATE TABLE derived_recency.fact_recency_surveillance_censored (
    recency_surveillance_censored_id UNIQUEIDENTIFIER  NOT NULL,
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
    special_category NVARCHAR(255) NULL,
    special_category_other NVARCHAR(255) NULL,
    is_first_time_hiv_test INT NULL,
    last_hiv_test_result NVARCHAR(255) NULL,
    last_hiv_test_date DATE NULL,
    last_hiv_test_date_id INT NULL,
    recency_test_consent INT NULL,
    emr_field_rtri_result NVARCHAR(255) NULL,
    lab_number NVARCHAR(255) NULL,
    sample_collection_date DATE NULL,
    sample_collection_date_id INT NULL,
    sample_registration_date DATE NULL,
    sample_registration_date_id INT NULL,
    sample_registration_time NVARCHAR(255) NULL,
    age_at_test INT NULL,
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
    viral_load NVARCHAR(255) NULL,
    viral_load_count BIGINT NULL,
    viral_load_count_undetectable INT NULL,
    is_virally_suppressed INT NULL,
    viral_load_date DATE NULL,
    viral_load_date_id INT NULL,
    lab_rita_result NVARCHAR(255) NULL,
    final_recency_result_is_recent INT NULL,
    final_recency_result_is_longterm INT NULL,
    is_rtri_recent INT NULL,
    is_rtri_long_term INT NULL,
    is_rtri_negative INT NULL,
    client_id UNIQUEIDENTIFIER NULL,
    facility_id UNIQUEIDENTIFIER  NULL,
    hub_id UNIQUEIDENTIFIER  NULL
);

ALTER TABLE [derived_recency].fact_recency_surveillance_censored ADD 
CONSTRAINT PK_recency_surveillance_censored_id 
PRIMARY KEY ([recency_surveillance_censored_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance_censored ADD 
CONSTRAINT FK_surveillance_censored_visit_date_id 
FOREIGN KEY ([visit_date_id]) REFERENCES derived_recency.dim_visit_date ([date_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance_censored ADD 
CONSTRAINT FK_surveillance_censored_last_hiv_date_id 
FOREIGN KEY ([last_hiv_test_date_id]) REFERENCES derived_recency.dim_last_hiv_test_date([date_id]);

ALTER TABLE [derived_recency].fact_recency_surveillance_censored ADD 
CONSTRAINT FK_surveillance_censored_age_group_id 
FOREIGN KEY (age_group_id) REFERENCES derived_recency.dim_age_group (age_group_id);

-- $END

