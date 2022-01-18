USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

INSERT INTO base.fact_uvri_recency_result (
    uvri_recency_result_id,
    uvri_client_id,
    facility_id,
    hub_id,
    fno,
    lab_number,
    sample_collection_date,
    sample_collection_date_id,
    sample_registration_date,
    sample_registration_date_id,
    sample_registration_time,
    age,
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
    viral_load_date,
    viral_load_date_id
) 
SELECT 
    NEWID() as uvri_recency_result_id, 
    (
        SELECT 
            uvri_client_id 
        FROM 
            base.dim_uvri_client 
        WHERE 
            lab_number = u.LabNo
    ) AS uvri_client_id,
    (
		SELECT
            facility_id
        FROM 
            base.dim_facility f 
        WHERE 
            LOWER(REPLACE(f.name,'HC ','HC'))   =   LOWER(u.Submitter) 
        AND
            LOWER(f.district)   =  
			CASE
				WHEN LOWER(District) = 'kawenge'
				THEN 'Kamwenge'
				ELSE LOWER(District)
			END
	) AS facility_id,
    h.hub_id,
    u.FNO,
    u.LabNo as lab_number,
    u.ColltDate as sample_collection_date,
    NULL AS sample_collection_date_id,
    u.Regdate as sample_registration_date,
    NULL AS sample_registration_date_id,
    u.Regtime as sample_registration_time,
    u.Age as age,
    u.[RTRI Field Result] as lab_field_rtri_result,
    u.[Kit Lot #] as kit_lot_number,
    u.[Kit Expiry Date] as kit_expiry_date,
    NULL AS kit_expiry_date_id,
    u.[Test Date] as uvri_test_date,
    NULL AS uvri_test_date_id,
    u.[Sample ID] as uvri_sample_id,
    (
        CASE  
        WHEN  LOWER(u.[Control Line]) = '1' THEN 1
        WHEN  LOWER(u.[Control Line]) = '0' THEN 0 
        ELSE NULL
        END 
    ) as control_line,
    (
        CASE  
        WHEN  LOWER(u.[Verification Line]) = '1' THEN 1
        WHEN  LOWER(u.[Verification Line]) = '0' THEN 0 
        ELSE NULL
        END 
    ) as verification_line,
    (
        CASE  
        WHEN  LOWER(u.[Long Term(LT)Line]) = '1' THEN 1
        WHEN  LOWER(u.[Long Term(LT)Line]) = '0' THEN 0 
        ELSE NULL
        END 
    ) as longterm_line,
    u.[Recency Results] as lab_rtri_result,
    u.[Vl] as viral_load,
    u.[Datetested] as viral_load_date,
    NULL AS viral_load_date_id
FROM  
    [external].recency_uvri_results u
    LEFT JOIN  base.dim_hub h
        ON  LOWER(u.Hub) = LOWER(h.name)

-- $END
