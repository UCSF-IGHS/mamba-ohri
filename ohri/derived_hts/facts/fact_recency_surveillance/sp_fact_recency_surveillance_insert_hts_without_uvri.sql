USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN
    
INSERT INTO [derived_recency].fact_recency_surveillance (
    recency_surveillance_id,
    _is_censored,
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
    is_eligible_for_recency,
    special_category,
    special_category_other,
    hiv_final_test_result,
    hiv_final_syphillis_duo_result,
    is_first_time_hiv_test,
    last_hiv_test_result,
    last_hiv_test_date,
    last_hiv_test_date_id,
    recency_test_consent,
    emr_field_rtri_result,
    -- lab_number,
    -- sample_collection_date,
    -- sample_collection_date_id,
    -- sample_registration_date,
    -- sample_registration_date_id,
    -- sample_registration_time,
    -- lab_age_at_test,
    -- lab_field_rtri_result,
    -- kit_lot_number,
    -- kit_expiry_date,
    -- kit_expiry_date_id,
    -- uvri_test_date,
    -- uvri_test_date_id,
    -- uvri_sample_id,
    -- control_line,
    -- verification_line,
    -- longterm_line,
    -- lab_rtri_result,
    -- viral_load,
    -- viral_load_count,
    -- viral_load_count_undetectable,
    -- is_virally_suppressed,
    -- viral_load_date,
    -- viral_load_date_id,
    -- lab_rita_result

    client_id,
    facility_id, --,
    -- hub_id,
    location_id
)
SELECT
    NEWID(),
    0 AS _is_censored,
    e.encounter_uuid,
    e.visit_date,
    e.visit_date_id,
    e.accompanied_by,
    e.accompanied_by_other,
    e.hts_delivery_model,
    e.hts_approach,
    e.entry_point,
    e.entry_point_other,
    e.community_testing_entry_point,
    e.community_testing_entry_point_other,
    e.reason_for_testing,
    e.reason_for_testing_other,
    NULL AS is_eligible_for_recency,
    e.special_category,
    e.special_category_other,
    e.hiv_final_test_result,
    e.hiv_final_syphillis_duo_result,
    e.is_first_time_hiv_test,
    e.last_hiv_test_result,
    e.last_hiv_test_date,
    e.last_hiv_test_date_id,
    e.recency_test_consent,
    e.field_rtri_result,
    -- u.lab_number,
    -- u.sample_collection_date,
    -- u.sample_collection_date_id,
    -- u.sample_registration_date,
    -- u.sample_registration_date_id,
    -- u.sample_registration_time,
    -- u.age,
    -- u.lab_field_rtri_result,
    -- u.kit_lot_number,
    -- u.kit_expiry_date,
    -- u.kit_expiry_date_id,
    -- u.uvri_test_date,
    -- u.uvri_test_date_id,
    -- u.uvri_sample_id,
    -- u.control_line,
    -- u.verification_line,
    -- u.longterm_line,
    -- u.lab_rtri_result,
    -- u.viral_load,
    -- Null AS viral_load_count,
    -- Null AS viral_load_count_undetectable,
    -- Null AS is_virally_suppressed,
    -- u.viral_load_date,
    -- u.viral_load_date_id,
    -- Null AS lab_rita_result,
    -- e.hts_client_id AS client_id,
    (
        CASE 
            WHEN e.recency_test_consent = 1 THEN e.hts_client_id
            WHEN e.recency_test_consent = 0 OR e.recency_test_consent IS NULL THEN NULL
        END
    ) AS client_id,
    e.facility_id, --,
    -- u.hub_id,
    e.location_id
FROM 
    base.fact_hts_emr e
WHERE 
    serial_number IS NOT NULL
    AND 
    hiv_final_test_result = 'HIV+'
    AND
    visit_date > '2019-10-28'
    AND 
    facility_id IS NOT NULL;
    -- dbo.vw_base_fact_hts_emr_distinct e
--     LEFT JOIN base.fact_uvri_recency_result u
--         ON e.serial_number = u.fno 
--         AND e.facility_id = u.facility_id
-- WHERE
--     u.fno IS NULL
--     AND u.facility_id IS NULL;

-- $END