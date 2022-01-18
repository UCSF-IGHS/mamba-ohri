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
        [base].fact_cqi_shortened_assessment fca
)
UPDATE
    [base].fact_cqi_shortened_assessment
SET
    visit_number = cte.__visit_number
FROM
    visit_number_calc_cte cte
    INNER JOIN [base].fact_cqi_shortened_assessment cqi ON (cqi.uri = cte.__uri);

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
        [base].fact_cqi_shortened_assessment fca
)
UPDATE
    [base].fact_cqi_shortened_assessment
SET
    reversed_visit_number = (cte.__visit_number - 1) * -1
FROM
    visit_number_calc_cte cte
    INNER JOIN [base].fact_cqi_shortened_assessment cqi ON (cqi.uri = cte.__uri);

-- CURRENT VISIT
UPDATE 
    [base].fact_cqi_shortened_assessment
SET
    is_latest_visit = CASE WHEN reversed_visit_number = 0 THEN 1 ELSE 0 END;

-- PORPORTION OF PROVIDERS TRAINED 

UPDATE 
    [base].fact_cqi_shortened_assessment
SET
    ss_prop_of_trained_hts_providers = 
    CASE
        WHEN ss_total_hts_providers = 0
            THEN NULL
        WHEN ss_number_of_hts_providers_trained IS NULL AND ss_number_of_hts_providers_trained_by_cme IS NULL
            THEN NULL
        WHEN (COALESCE(ss_number_of_hts_providers_trained,0) + COALESCE(ss_number_of_hts_providers_trained_by_cme,0))>ss_total_hts_providers
            THEN NULL
        ELSE CAST((COALESCE(ss_number_of_hts_providers_trained,0) + COALESCE(ss_number_of_hts_providers_trained_by_cme,0)) AS DECIMAL)/CAST(ss_total_hts_providers AS DECIMAL)
    END;


-- PORPORTION OF ENROLLED ELIGIBLE CLIENTS IN RTRI

UPDATE 
    [base].fact_cqi_shortened_assessment
SET
    prf_prop_of_enrolled_clients_in_rtri = 
    CASE
        WHEN prf_total_clients_eligible = 0
            THEN NULL
        WHEN prf_total_clients_eligible IS NULL
            THEN NULL 
        WHEN prf_total_clients_enrolled_for_rtri IS NULL
            THEN NULL
        WHEN prf_total_clients_enrolled_for_rtri > (prf_total_clients_eligible-COALESCE(prf_total_clients_ineligible,0))
            THEN NULL
        ELSE CAST(prf_total_clients_enrolled_for_rtri AS DECIMAL) / CAST((prf_total_clients_eligible-COALESCE(prf_total_clients_ineligible,0)) AS DECIMAL)
    END;
    

-- PORPORTION OF CLIENTS TESTED RECENT
UPDATE 
    [base].fact_cqi_shortened_assessment
SET
    prf_prop_clients_tested_recent = 
    CASE
        WHEN prf_total_clients_enrolled_for_rtri = 0
            THEN NULL
        WHEN  prf_total_15_and_above_tested_recent IS NULL
            THEN NULL
        WHEN prf_total_15_and_above_tested_recent > prf_total_clients_enrolled_for_rtri
            THEN NULL
        ELSE CAST(prf_total_15_and_above_tested_recent AS DECIMAL) / CAST(prf_total_clients_enrolled_for_rtri AS DECIMAL)
    END;

-- PORPORTION OF CLIENTS TESTED LONG-TERM
UPDATE 
    [base].fact_cqi_shortened_assessment
SET
    prf_prop_clients_tested_long_term  = 
    CASE
        WHEN prf_total_clients_enrolled_for_rtri = 0
            THEN NULL 
        WHEN  prf_total_15_and_above_tested_long_term IS NULL
            THEN NULL
        WHEN prf_total_15_and_above_tested_long_term > prf_total_clients_enrolled_for_rtri
            THEN NULL
        ELSE CAST(prf_total_15_and_above_tested_long_term AS DECIMAL) / CAST(prf_total_clients_enrolled_for_rtri AS DECIMAL)
    END;

-- $END


