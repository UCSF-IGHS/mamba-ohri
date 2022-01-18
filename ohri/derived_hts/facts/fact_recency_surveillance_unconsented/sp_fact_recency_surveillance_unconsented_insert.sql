USE recency_uganda_prod_analysis_test;
GO


TRUNCATE TABLE  [derived_recency].fact_recency_surveillance_unconsented;

--Count the total number of records in fact_recency_surveillance
SELECT 
    COUNT(*) total_surveillance_records
FROM 
    derived_recency.fact_recency_surveillance;

--Count the number of uconsented records in fact_recency_surveillance
SELECT 
    COUNT(*) count_unconsented_records
FROM 
    derived_recency.fact_recency_surveillance
WHERE 
    recency_test_consent IS NULL
    OR 
    recency_test_consent <> 1;

-- $BEGIN
    
INSERT INTO [derived_recency].fact_recency_surveillance_unconsented (
    recency_surveillance_unconsented_id,
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
    encounter_uuid,
    visit_date,
    visit_date_id,
    NULL accompanied_by,
    NULL accompanied_by_other,
    NULL hts_delivery_model,
    NULL hts_approach,
    NULL entry_point,
    NULL entry_point_other,
    NULL community_testing_entry_point,
    NULL community_testing_entry_point_other,
    NULL reason_for_testing,
    NULL reason_for_testing_other,
    NULL special_category,
    NULL special_category_other,
    NULL is_first_time_hiv_test,
    NULL last_hiv_test_result,
    NULL last_hiv_test_date,
    NULL last_hiv_test_date_id,
    NULL recency_test_consent,
    NULL emr_field_rtri_result,
    NULL lab_number,
    NULL sample_collection_date,
    NULL sample_collection_date_id,
    NULL sample_registration_date,
    NULL sample_registration_date_id,
    NULL sample_registration_time,
    NULL age_at_test,
    NULL lab_field_rtri_result,
    NULL kit_lot_number,
    NULL kit_expiry_date,
    NULL kit_expiry_date_id,
    NULL uvri_test_date,
    NULL uvri_test_date_id,
    NULL uvri_sample_id,
    NULL control_line,
    NULL verification_line,
    NULL longterm_line,
    NULL lab_rtri_result,
    NULL viral_load,
    NULL viral_load_count,
    NULL viral_load_count_undetectable,
    NULL is_virally_suppressed,
    NULL viral_load_date,
    NULL viral_load_date_id,
    NULL lab_rita_result,
    NULL final_recency_result_is_recent,
    NULL final_recency_result_is_longterm,
    NULL is_rtri_recent,
    NULL is_rtri_long_term,
    NULL is_rtri_negative,
    client_id,
    facility_id,
    hub_id
FROM 
    derived_recency.fact_recency_surveillance
WHERE 
    recency_test_consent IS NULL
    OR 
    recency_test_consent <> 1;

DELETE  
FROM
    derived_recency.fact_recency_surveillance
WHERE 
    recency_test_consent IS NULL
    OR 
    recency_test_consent <> 1;

-- $END

--Assert that number of inserted records equals the number of unconsented records which were in fact_recency_surveillance
SELECT 
    COUNT(*) count_inserted_unconsented_records
FROM 
    derived_recency.fact_recency_surveillance_unconsented;

--Assert that
-- consented records remaining = Total records before transfer - Number of unconsented records transfered
SELECT 
    COUNT(*) count_records_remaining_after_transfer
FROM 
    derived_recency.fact_recency_surveillance;

--Eye ball the data in fact_recency_surveillance and fact_recency_surveillance_unconsented
SELECT TOP 100 * 
FROM 
derived_recency.fact_recency_surveillance;

SELECT TOP 100 * 
FROM 
derived_recency.fact_recency_surveillance_unconsented;