USE recency_uganda_prod_analysis_test;
GO


--Count Dates before trimming

SELECT COUNT(*) count_assessment_visit_dates_before_trim
FROM derived_recency.dim_cqi_assessment_visit_date;

SELECT COUNT(*) count_assessment_review_period_start_dates_before_trim
FROM derived_recency.dim_cqi_assessment_review_period_start_date;

SELECT COUNT(*) count_assessment_review_period_end_dates_before_trim
FROM derived_recency.dim_cqi_assessment_review_period_end_date;


-- $BEGIN

DELETE 
FROM derived_recency.dim_cqi_assessment_visit_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(visit_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_cqi_assessment_visit_date))))
        FROM
        (
            SELECT DISTINCT
                visit_date 
            FROM 
                derived_recency.dim_cqi_assessment 
            WHERE 
                visit_date IS NOT NULL 
            UNION 
            SELECT DISTINCT
                visit_date 
            FROM 
                derived_recency.dim_cqi_action_plan_assessment 
            WHERE 
                visit_date IS NOT NULL 
            )q    
    );

DELETE 
FROM derived_recency.dim_cqi_assessment_review_period_start_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(review_period_start_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_cqi_assessment_review_period_start_date))))
        FROM
        (
            SELECT DISTINCT
                review_period_start_date 
            FROM 
                derived_recency.dim_cqi_assessment 
            WHERE 
                review_period_start_date IS NOT NULL 
            UNION 
            SELECT DISTINCT
                review_period_start_date 
            FROM 
                derived_recency.dim_cqi_action_plan_assessment 
            WHERE 
                review_period_start_date IS NOT NULL 
            )q    
    );



DELETE 
FROM derived_recency.dim_cqi_assessment_review_period_end_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(review_period_end_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_cqi_assessment_review_period_end_date))))
        FROM
        (
            SELECT DISTINCT
                review_period_end_date 
            FROM 
                derived_recency.dim_cqi_assessment 
            WHERE 
                review_period_end_date IS NOT NULL 
            UNION 
            SELECT DISTINCT
                review_period_end_date 
            FROM 
                derived_recency.dim_cqi_action_plan_assessment 
            WHERE 
                review_period_end_date IS NOT NULL 
            )q   
    );



-- $END

--Count Dates after trimming

SELECT COUNT(*) count_assessment_visit_dates_after_trim
FROM derived_recency.dim_cqi_assessment_visit_date;

SELECT COUNT(*) count_assessment_review_period_start_dates_after_trim
FROM derived_recency.dim_cqi_assessment_review_period_start_date;

SELECT COUNT(*) count_assessment_review_period_end_dates_after_trim
FROM derived_recency.dim_cqi_assessment_review_period_end_date;


--Eyeball the data in the date dimensions

SELECT TOP 100 *
FROM derived_recency.dim_cqi_assessment_visit_date;

SELECT TOP 100 * 
FROM derived_recency.dim_cqi_assessment_review_period_start_date;

SELECT TOP 100 *
FROM derived_recency.dim_cqi_assessment_review_period_end_date;

