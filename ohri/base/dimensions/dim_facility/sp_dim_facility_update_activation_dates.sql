USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN


UPDATE f
SET
    f.activation_date = e.date_activated
FROM
    base.dim_facility f
    INNER JOIN  [external].emr_facility_activation e 
        ON
            f.dhis2_uid = e.dhis2_uid
WHERE 
    f.dhis2_uid IS NOT NULL;

-- $END
   