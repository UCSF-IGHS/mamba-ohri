USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

UPDATE c 
SET 
    c.is_in_uvri_lab_data = 1,
    c.hts_number_uvri = u.hts_number_uvri
FROM 
    derived_recency.dim_client c
    INNER JOIN
    base.dim_uvri_client u
        ON 
            c.registering_facility_id = u.registering_facility_id
        AND
            c.hts_number_hts_client_card = u.hts_number_uvri;

-- $END   