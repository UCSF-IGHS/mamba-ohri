USE recency_uganda_prod_analysis_test
GO

DROP TABLE IF EXISTS [base].fact_cqi_shortened_assessment;

-- $BEGIN

CREATE TABLE [base].[fact_cqi_shortened_assessment] (
    cqi_shortened_assessment_id UNIQUEIDENTIFIER NOT NULL,
    [form_version] VARCHAR(2) NOT NULL,
    [uri] NVARCHAR(255) PRIMARY KEY,
    [form_start_date_time] DATE NULL,
    [form_end_date_time] DATE NULL,
    [form_date] DATE NULL,
    [visit_date] DATE NULL,
    [region] NVARCHAR(255) NULL,
    [district] NVARCHAR(255) NULL,
    visit_number INT NULL,
    reversed_visit_number INT NULL,
    is_latest_visit TINYINT NULL,
    cx_study_staff_score DECIMAL(10,4) NULL,
    ss_prop_of_trained_hts_providers DECIMAL(10,4) NULL,
    ss_prop_of_trained_hts_providers_available_during_visit DECIMAL(10,4) NULL,
    ss_prop_of_hts_providers_trained_on_hiv_rapid_testing DECIMAL(10,4) NULL,
    cx_procedures_score DECIMAL(10,4) NULL,
    cx_source_data_score DECIMAL(10,4) NULL,
    sd_prop_of_complete_records_in_logbook DECIMAL(10,4) NULL,
    sd_prop_of_complete_records_with_kit_details DECIMAL(10,4) NULL,
    sd_prop_of_shipment_forms_completely_filled DECIMAL(10,4) NULL,
    cx_physical_facility_score DECIMAL(10,4) NULL,
    cx_participant_recruitment_score DECIMAL(10,4) NULL,
    prf_prop_of_enrolled_clients_in_rtri DECIMAL(10,4) NULL,
    prf_prop_of_enrolled_clients_in_rtri_with_consent_doc DECIMAL(10,4) NULL,
    cx_site_supplies_score DECIMAL(10,4) NULL,
    [assessment_point] NVARCHAR(255) NULL,
    [assessment_point_other] NVARCHAR(255) NULL,
    [review_period_start] DATE NULL,
    [review_period_end] DATE NULL,
    [visitor_name] NVARCHAR(255) NULL,
    [visitor_name_other] NVARCHAR(255) NULL,
    [ss_total_hts_providers] INT NULL,
    [ss_number_of_hts_providers_trained]INT NULL,
    [ss_number_of_hts_providers_trained_by_cme]INT NULL,
    [ss_any_recency_trained_staff_changes_since_training]INT NULL,
    [ss_any_recency_trained_staff_changes_since_training_comment]NVARCHAR(255) NULL,
    [procedures_qc_for_positive_and_negative_routinely_used]INT NULL,
    [procedures_date_of_qc]DATE NULL,
    [procedures_kit_lot_number]NVARCHAR(255) NULL,
    [prf_total_clients_eligible]INT NULL,
    [prf_total_clients_enrolled_for_rtri]INT NULL,
    [prf_total_clients_ineligible]INT NULL,
    [prf_total_15_and_above_tested_recent]INT NULL,
    [prf_total_15_and_above_tested_long_term]INT NULL,
    prf_prop_clients_tested_recent DECIMAL(10,4) NULL,
    prf_prop_clients_tested_long_term DECIMAL(10,4) NULL,
    [site_supplies_samples_shipped]INT NULL,
    [site_supplies_all_rtri_supplies_available]INT NULL,
    [site_supplies_all_rtri_supplies_available_comment] NVARCHAR(255) NULL,
    [facility_id] UNIQUEIDENTIFIER NULL,
    FOREIGN KEY (facility_id) REFERENCES base.dim_facility (facility_id)
);

-- $END