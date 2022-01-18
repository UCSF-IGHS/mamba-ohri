USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.dim_hts_client;

-- $BEGIN

INSERT INTO base.dim_hts_client (
	hts_client_id,
	sex,
	date_of_birth,
	date_of_birth_id,
	marital_status,
	hts_number_hts_client_card,
	hts_record_id,
	consented,
	hts_client_composite_id,
    parish,
    subcounty,
    district
)
SELECT	
	NEWID(),		
	h.sex,
	(
        CASE 
            WHEN CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00 00:00:00.0000000' 
                OR 
                CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00 00:00:00' 
                OR 
                CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00' 
                OR
                CAST(h.date_of_birth AS varchar(255)) = '00:00:00.000'
                THEN NULL
            ELSE CAST(h.date_of_birth AS DATE)
        END
    ) AS date_of_birth,
	NULL as date_of_birth_id,
	h.marital_status,
	h.serial_number,
	id,
	(
		CASE
			WHEN LOWER(h.recency_test_concent) = 'yes'
			THEN 1
			WHEN LOWER(h.recency_test_concent) = 'no'
			THEN 0
			ELSE NULL
		END
	) AS consented,
	CONCAT(
        dhis2_orgunit_uuid
        ,serial_number
		,(
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
    )
        ,sex
		,(
        CASE 
            WHEN CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00 00:00:00.0000000' 
                OR 
                CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00 00:00:00' 
                OR 
                CAST(h.date_of_birth AS VARCHAR(255)) = '0000-00-00' 
                OR
                CAST(h.date_of_birth AS varchar(255)) = '00:00:00.000'
                THEN NULL
            ELSE CAST(h.date_of_birth AS DATE)
        END
    )
        ) AS hts_client_composite_id,
    h.health_unit_name AS parish,
    h.health_unit_sub_county AS subcounty,
    h.health_unit_district AS district
FROM 
	[staging].recency_hts_client_card h 
	LEFT JOIN base.dim_facility f
		ON f.dhis2_uid = h.dhis2_orgunit_uuid
WHERE
	h.dhis2_orgunit_uuid <> 'recencytrain'


-- $END
