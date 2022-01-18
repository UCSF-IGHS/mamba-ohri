USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

UPDATE f
SET
    f.implementing_mechanism_id = (
        SELECT 
            implementing_mechanism_id
        FROM
            base.dim_implementing_mechanism
        WHERE
            composite_id = 
            (
                SELECT
                    CONCAT(supporting_ip,implementing_mechanism,agency)
                FROM 
                    [external].emr_facility_activation 
                WHERE 
                    dhis2_uid IS NOT NULL
                AND
                    dhis2_uid = f.dhis2_uid
            )

    )
FROM base.dim_facility f
WHERE 
    f.dhis2_uid IS NOT NULL;


-- $END
 