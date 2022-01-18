USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.fact_hts_emr;

-- $BEGIN

INSERT INTO base.fact_hts_emr (
    hts_emr_id,
    hts_client_id,
    facility_id,
    location_id,
    hts_record_id,
    serial_number,
    encounter_uuid,
    visit_date,
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
    hiv_final_test_result,
    hiv_final_syphillis_duo_result,
    is_first_time_hiv_test,
    last_hiv_test_date,
    last_hiv_test_result,
    recency_test_consent,
    field_rtri_result
) 
SELECT 
    NEWID(),
    (
        SELECT 
            hts_client_id 
        FROM 
            base.dim_hts_client 
        WHERE 
            hts_record_id = id
    ) AS hts_client_id,
    f.facility_id,
    (
        CASE
            WHEN (c.health_unit_district IS NOT NULL AND c.health_unit_sub_county IS NOT NULL)
                THEN (SELECT a.location_id 
                    FROM
                    base.dim_location a 
                    INNER JOIN
                    base.dim_location b 
                    ON a.parent_id = b.location_id
                    WHERE 
                    a.type = 'Subcounty'
                    AND 
                    a.name = c.health_unit_sub_county
                    AND 
                    b.name = c.health_unit_district
                )
            WHEN  (c.health_unit_district IS NOT NULL AND c.health_unit_sub_county IS NULL)
                THEN (SELECT a.location_id 
                    FROM
                    base.dim_location a 
                    WHERE 
                    a.type = 'District'
                    AND 
                    a.name = c.health_unit_district
                )                  
            ELSE
                NULL
            END
    ) AS location_id,
    id AS record_id,
    serial_number,
    encounter_uuid,
    (
        CASE 
            WHEN CAST(visit_date AS VARCHAR(255)) = '0000-00-00 00:00:00.0000000' 
                OR 
                CAST(visit_date AS varchar(255)) = '0000-00-00 00:00:00' 
                OR 
                CAST(visit_date AS varchar(255)) = '0000-00-00'
                OR 
                CAST(visit_date AS varchar(255)) = '00:00:00.000'
                THEN NULL
            ELSE CAST(visit_date AS DATE)
        END
    ) AS visit_date,
    accompanied_by,
    accompanied_by_other,
    hts_delivery_model,
    hts_approach,
    health_unit_testing_entry_point,
    health_unit_testing_entry_point_other,
    community_testing_entry_point,
    community_testing_entry_point_other,
    reason_for_testing,
    reason_for_testing_other,
    special_category,
    special_category_other,
    hiv_final_test_result,
    hiv_final_syphillis_duo_result,
    (
        CASE
            WHEN LOWER(first_time_hiv_test) = 'yes'
            THEN 1
            WHEN LOWER(first_time_hiv_test) = 'no'
            THEN 0
            ELSE NULL
        END
    ) AS first_time_hiv_test,
    (
        CASE 
            WHEN CAST(last_hiv_test_date AS VARCHAR(255)) = '0000-00-00 00:00:00.0000000' 
                OR 
                CAST(last_hiv_test_date AS VARCHAR(255)) = '0000-00-00 00:00:00' 
                OR 
                CAST(last_hiv_test_date AS VARCHAR(255)) = '0000-00-00' 
                OR
                CAST(visit_date AS varchar(255)) = '00:00:00.000'
                THEN NULL
            ELSE CAST(last_hiv_test_date AS DATE)
        END
    ) AS last_hiv_test_date,
    last_hiv_test_result,
    (
        CASE
            WHEN LOWER(recency_test_concent) = 'yes'
            THEN 1
            WHEN LOWER(recency_test_concent) = 'no'
            THEN 0
            ELSE NULL
        END
    ) AS recency_test_consent,
    recent_hiv_test_result AS field_rtri_result
FROM 
    [staging].recency_hts_client_card c
    LEFT JOIN base.dim_facility f
        ON f.dhis2_uid = c.dhis2_orgunit_uuid
WHERE
    c.dhis2_orgunit_uuid <> 'recencytrain'
    
-- $END