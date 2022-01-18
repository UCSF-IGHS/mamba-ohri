USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN


UPDATE derived_recency.fact_recency_surveillance
SET
    _is_censored = 1,
    censored_reason = 'Recency result value is empty or not acceptable'
WHERE 
    recency_test_consent = 1
    AND
    (
    emr_field_rtri_result IS NULL
        OR
    emr_field_rtri_result  NOT IN (
        'Recent',
        'Long-term',
        'Invalid',
        'Negative'
        )
    
    )
-- $END

