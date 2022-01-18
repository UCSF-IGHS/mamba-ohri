USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

-- VISIT NUMBER 
WITH
visit_number_calc_cte
(
    __uri
    ,__facility_dhis2_uuid
    ,__assessment_point
    ,__visit_date
    ,__visit_number
)
AS
(
    SELECT
        uri,
        facility_id,
        assessment_point,
        visit_date,
        ROW_NUMBER() OVER(PARTITION BY fca.facility_id, fca.assessment_point ORDER BY fca.visit_date) as visit_number
    FROM
        base.fact_cqi_assessment fca
)
UPDATE
    base.fact_cqi_assessment
SET
    visit_number = cte.__visit_number
FROM
    visit_number_calc_cte cte
    INNER JOIN base.fact_cqi_assessment cqi ON (cqi.uri = cte.__uri);

-- REVERSED VISIT_NUMBER
WITH
visit_number_calc_cte
(
    __uri
    ,__facility_dhis2_uuid
    ,__assessment_point
    ,__visit_date
    ,__visit_number
)
AS
(
    SELECT
        uri,
        facility_id,
        assessment_point,
        visit_date,
        ROW_NUMBER() OVER(PARTITION BY fca.facility_id, fca.assessment_point ORDER BY fca.visit_date DESC) as visit_number
    FROM
        base.fact_cqi_assessment fca
)
UPDATE
    base.fact_cqi_assessment
SET
    reversed_visit_number = (cte.__visit_number - 1) * -1
FROM
    visit_number_calc_cte cte
    INNER JOIN base.fact_cqi_assessment cqi ON (cqi.uri = cte.__uri);

-- CURRENT VISIT
UPDATE 
    base.fact_cqi_assessment
SET
    is_latest_visit = CASE WHEN reversed_visit_number = 0 THEN 1 ELSE 0 END;

--Part 1:  Study Staff (Training and Adherence to SOPs)


-- PORPORTION OF TRAINED AVAILABLE PROVIDERS (D+E)/B
UPDATE 
    base.fact_cqi_assessment
SET
    ss_prop_of_trained_hts_providers_available_during_visit = 
    CASE
        WHEN ss_number_provider_available_at_point = 0
            THEN NULL 
        WHEN (ss_number_of_hts_providers_trained_available + ss_number_of_hts_providers_trained_by_cme) > ss_number_provider_available_at_point
            THEN NULL
        ELSE CAST((ss_number_of_hts_providers_trained_available + ss_number_of_hts_providers_trained_by_cme) AS DECIMAL) / CAST(ss_number_provider_available_at_point AS DECIMAL)
    END;


-- PORPORTION OF PROVIDERS TRAINED ON ROUTINE HIV RAPID TESTING (F/A)

UPDATE 
    base.fact_cqi_assessment
SET
    ss_prop_of_hts_providers_trained_on_hiv_rapid_testing = 
    CASE
        WHEN ss_total_hts_providers = 0
            THEN NULL
        WHEN ss_number_provider_trained_on_routine_hts > ss_total_hts_providers
            THEN NULL
        ELSE CAST(ss_number_provider_trained_on_routine_hts AS DECIMAL) / CAST(ss_total_hts_providers AS DECIMAL)
    END;


-- Part 3:  Source Data  

-- PROPORTION OF CLIENT RECORDS IN RECENCY LOGBOOK WITH COMPLETED RTRI TEST RESULTS (B/A)
UPDATE 
    base.fact_cqi_assessment
SET
    sd_prop_of_complete_records_in_logbook = 
    CASE 
        WHEN sd_number_records_in_logbook = 0
            THEN NULL 
        WHEN sd_number_records_in_logbook_rtri_complete > sd_number_records_in_logbook
            THEN NULL
        ELSE CAST(sd_number_records_in_logbook_rtri_complete AS DECIMAL) / CAST(sd_number_records_in_logbook AS DECIMAL)
    END;


-- C. PORPORTION OF CLIENT RECORDS WITH COMPLETED CLIENT HTS ID (C/A)

UPDATE 
    base.fact_cqi_assessment
SET
    sd_prop_of_records_complete_with_hts_id = 
    CASE
        WHEN sd_number_records_in_logbook = 0
            THEN NULL 
        WHEN sd_number_records_with_complete_hts_id > sd_number_records_in_logbook
            THEN NULL
        ELSE CAST(sd_number_records_with_complete_hts_id AS DECIMAL) / CAST(sd_number_records_in_logbook AS DECIMAL)
    END;

-- PROPORTION OF PAGES IN RECENCY LOGBOOK COMPLETE WITH KIT DETAILS (E/D)
UPDATE 
    base.fact_cqi_assessment
SET
    sd_prop_of_complete_records_with_kit_details =
    
    CASE
        WHEN sd_total_pages_with_client_records = 0
            THEN NULL 
        WHEN sd_number_records_in_logbook_with_complete_kit_details > sd_total_pages_with_client_records
            THEN NULL
        ELSE CAST(sd_number_records_in_logbook_with_complete_kit_details AS DECIMAL) / CAST(sd_total_pages_with_client_records AS DECIMAL)
    END;


-- PROPORTION OF SAMPLES SHIPPED TO THE HUB (H/G)
UPDATE 
    base.fact_cqi_assessment
SET
    sd_prop_of_samples_shipped_to_hub = 
    CASE
        WHEN sd_total_lab_specimen_eligible_for_shipment = 0
            THEN NULL 
        WHEN sd_total_specimens_in_shipment_forms > sd_total_lab_specimen_eligible_for_shipment
            THEN NULL
        ELSE CAST(sd_total_specimens_in_shipment_forms AS DECIMAL) / CAST(sd_total_lab_specimen_eligible_for_shipment AS DECIMAL)
    END;

-- K. PROPORTION OF RECORDS ON SPECIMEN SHIPMENT FORMS FILLED COMPLETELY (K/J)
UPDATE 
    base.fact_cqi_assessment
SET
    sd_prop_of_shipment_forms_completely_filled = 
    CASE
        WHEN sd_total_specimen_records = 0
            THEN NULL 
        WHEN sd_total_specimens_in_shipment_forms_completely_filled > sd_total_specimen_records
            THEN NULL
        ELSE CAST(sd_total_specimens_in_shipment_forms_completely_filled AS DECIMAL) / CAST(sd_total_specimen_records AS DECIMAL)
    END;




--Part 5:  Participant Recruitment and Follow up Data    

-- C. PORPORTION OF ENROLLED ELIGIBLE CLIENTS IN RTRI (C/B)
UPDATE 
    base.fact_cqi_assessment
SET
    prf_prop_of_enrolled_clients_in_rtri = 
    CASE
        WHEN prf_total_clients_eligible = 0
            THEN NULL 
        WHEN prf_total_clients_enrolled_for_rtri > prf_total_clients_eligible
            THEN NULL
        ELSE CAST(prf_total_clients_enrolled_for_rtri AS DECIMAL) / CAST(prf_total_clients_eligible AS DECIMAL)
    END;

-- E. PORPORTION OF ENROLLED WITH CONSENT DOCUMENTATION (E/C)
UPDATE 
    base.fact_cqi_assessment
SET
    prf_prop_of_enrolled_clients_in_rtri_with_consent_doc = 
    CASE
        WHEN prf_total_clients_enrolled_for_rtri = 0
            THEN NULL 
        WHEN prf_total_clients_enrolled_for_rtri_with_correct_consent_doc > prf_total_clients_enrolled_for_rtri
            THEN NULL
        ELSE CAST(prf_total_clients_enrolled_for_rtri_with_correct_consent_doc AS DECIMAL) / CAST(prf_total_clients_enrolled_for_rtri AS DECIMAL)
    END;

-- $END