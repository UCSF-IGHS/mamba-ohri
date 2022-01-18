USE recency_uganda_prod_analysis_test;
GO

--Count Dates before trimming

SELECT COUNT(*) count_visit_dates_before_trim
FROM derived_recency.dim_visit_date;

SELECT COUNT(*) count_last_hiv_test_dates_before_trim
FROM derived_recency.dim_last_hiv_test_date;

SELECT COUNT(*) count_sample_collection_dates_before_trim
FROM derived_recency.dim_sample_collection_date;

SELECT COUNT(*) count_sample_registration_dates_before_trim
FROM derived_recency.dim_sample_registration_date;

SELECT COUNT(*) count_kit_expiry_dates_before_trim
FROM derived_recency.dim_kit_expiry_date;

SELECT COUNT(*) count_viral_load_dates_before_trim
FROM derived_recency.dim_viral_load_date;

SELECT COUNT(*) count_last_uploaded_on_dates_before_trim
FROM derived_recency.dim_last_uploaded_on_date;

SELECT COUNT(*) count_activation_dates_before_trim
FROM derived_recency.dim_activation_date;


-- $BEGIN

DELETE 
FROM derived_recency.dim_visit_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(visit_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_visit_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE visit_date IS NOT NULL
    );

DELETE 
FROM derived_recency.dim_last_hiv_test_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(last_hiv_test_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_last_hiv_test_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE last_hiv_test_date IS NOT NULL
    );



DELETE 
FROM derived_recency.dim_sample_collection_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(sample_collection_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_sample_collection_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE sample_collection_date IS NOT NULL
    );


DELETE 
FROM derived_recency.dim_sample_registration_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(sample_registration_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_sample_registration_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE sample_registration_date IS NOT NULL
    );


DELETE 
FROM derived_recency.dim_kit_expiry_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(kit_expiry_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd)  FROM derived_recency.dim_kit_expiry_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE kit_expiry_date IS NOT NULL
    );


DELETE 
FROM derived_recency.dim_viral_load_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(viral_load_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_viral_load_date))))
        FROM
        derived_recency.fact_recency_surveillance
        WHERE viral_load_date IS NOT NULL
    );


DELETE 
FROM derived_recency.dim_last_uploaded_on_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(last_uploaded_on),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_last_uploaded_on_date))))
        FROM
        derived_recency.dim_facility
        WHERE last_uploaded_on IS NOT NULL
    );

DELETE 
FROM derived_recency.dim_activation_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(activation_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_activation_date))))
        FROM
        derived_recency.dim_facility
        WHERE activation_date IS NOT NULL
    );

-- $END

--Count Dates after trimming

SELECT COUNT(*) count_visit_dates_after_trim
FROM derived_recency.dim_visit_date;

SELECT COUNT(*) count_last_hiv_test_dates_after_trim
FROM derived_recency.dim_last_hiv_test_date;

SELECT COUNT(*) count_sample_collection_dates_after_trim
FROM derived_recency.dim_sample_collection_date;

SELECT COUNT(*) count_sample_registration_dates_after_trim
FROM derived_recency.dim_sample_registration_date;

SELECT COUNT(*) count_kit_expiry_dates_after_trim
FROM derived_recency.dim_kit_expiry_date;

SELECT COUNT(*) count_viral_load_dates_after_trim
FROM derived_recency.dim_viral_load_date;

SELECT COUNT(*) count_last_uploaded_on_dates_after_trim
FROM derived_recency.dim_last_uploaded_on_date;

SELECT COUNT(*) count_activation_dates_after_trim
FROM derived_recency.dim_activation_date;


--Eyeball the data in the date dimensions

SELECT TOP 100 *
FROM derived_recency.dim_visit_date;

SELECT TOP 100 * 
FROM derived_recency.dim_last_hiv_test_date;

SELECT TOP 100 *
FROM derived_recency.dim_sample_collection_date;

SELECT TOP 100 * 
FROM derived_recency.dim_sample_registration_date;

SELECT TOP 100 * 
FROM derived_recency.dim_kit_expiry_date;

SELECT TOP 100 * 
FROM derived_recency.dim_viral_load_date;

SELECT TOP 100 *
FROM derived_recency.dim_last_uploaded_on_date;

SELECT TOP 100 *
FROM derived_recency.dim_activation_date;
