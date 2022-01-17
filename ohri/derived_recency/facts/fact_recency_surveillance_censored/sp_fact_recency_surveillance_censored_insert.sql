USE recency_uganda_prod_analysis_test;
GO


TRUNCATE TABLE  [derived_recency].fact_recency_surveillance_censored;

--Count the total number of records in fact_recency_surveillance
SELECT 
    COUNT(*) total_surveillance_records
FROM 
    derived_recency.fact_recency_surveillance;

--Count the number of censored records in fact_recency_surveillance
SELECT 
    COUNT(*) count_censored_records
FROM 
    derived_recency.fact_recency_surveillance
WHERE 
    _is_censored = 1;

-- $BEGIN
    
INSERT INTO [derived_recency].fact_recency_surveillance_censored (
    recency_surveillance_censored_id,
    censored_reason,
    encounter_uuid,
    visit_date,
    visit_date_id,
    accompanied_by,
    accompanied_by_other,
    hts_delivery_model,
    hts_approach,
    entry_point,
    entry_point_other,
    community_testing_entry_point,
    community_testing_entry_point_other,
    reason_for_testing,
    reason_for_testing_other,
    special_category,
    special_category_other,
    is_first_time_hiv_test,
    last_hiv_test_result,
    last_hiv_test_date,
    last_hiv_test_date_id,
    recency_test_consent,
    emr_field_rtri_result,
    lab_number,
    sample_collection_date,
    sample_collection_date_id,
    sample_registration_date,
    sample_registration_date_id,
    sample_registration_time,
    age_at_test,
    age_group_id,
    lab_field_rtri_result,
    kit_lot_number,
    kit_expiry_date,
    kit_expiry_date_id,
    uvri_test_date,
    uvri_test_date_id,
    uvri_sample_id,
    control_line,
    verification_line,
    longterm_line,
    lab_rtri_result,
    viral_load,
    viral_load_count,
    viral_load_count_undetectable,
    is_virally_suppressed,
    viral_load_date,
    viral_load_date_id,
    lab_rita_result,
    final_recency_result_is_recent,
    final_recency_result_is_longterm,
    is_rtri_recent,
    is_rtri_long_term,
    is_rtri_negative,
    client_id,
    facility_id,
    hub_id
)
SELECT
    recency_surveillance_id,
    censored_reason,
    encounter_uuid,
    visit_date,
    visit_date_id,
    accompanied_by,
    accompanied_by_other,
    hts_delivery_model,
    hts_approach,
    entry_point,
    entry_point_other,
    community_testing_entry_point,
    community_testing_entry_point_other,
    reason_for_testing,
    reason_for_testing_other,
    special_category,
    special_category_other,
    is_first_time_hiv_test,
    last_hiv_test_result,
    last_hiv_test_date,
    last_hiv_test_date_id,
    recency_test_consent,
    emr_field_rtri_result,
    lab_number,
    sample_collection_date,
    sample_collection_date_id,
    sample_registration_date,
    sample_registration_date_id,
    sample_registration_time,
    age_at_test,
    age_group_id,
    lab_field_rtri_result,
    kit_lot_number,
    kit_expiry_date,
    kit_expiry_date_id,
    uvri_test_date,
    uvri_test_date_id,
    uvri_sample_id,
    control_line,
    verification_line,
    longterm_line,
    lab_rtri_result,
    viral_load,
    viral_load_count,
    viral_load_count_undetectable,
    is_virally_suppressed,
    viral_load_date,
    viral_load_date_id,
    lab_rita_result,
    final_recency_result_is_recent,
    final_recency_result_is_longterm,
    is_rtri_recent,
    is_rtri_long_term,
    is_rtri_negative,
    client_id,
    facility_id,
    hub_id
FROM 
    derived_recency.fact_recency_surveillance
WHERE 
    _is_censored = 1;

DELETE  
FROM
    derived_recency.fact_recency_surveillance
WHERE 
    _is_censored = 1;

-- $END

--Assert that number of inserted records equals the number of censored records which were in fact_recency_surveillance
SELECT 
    COUNT(*) count_inserted_censored_records
FROM 
    derived_recency.fact_recency_surveillance_censored;

--Assert that
-- Non censored records remaining = Total records before transfer - Number of censored records transfered
SELECT 
    COUNT(*) count_records_remaining_after_transfer
FROM 
    derived_recency.fact_recency_surveillance;

--Eye ball the data in fact_recency_surveillance and fact_recency_surveillance_censored
SELECT TOP 100 * 
FROM 
derived_recency.fact_recency_surveillance;

SELECT TOP 100 * 
FROM 
derived_recency.fact_recency_surveillance_censored;