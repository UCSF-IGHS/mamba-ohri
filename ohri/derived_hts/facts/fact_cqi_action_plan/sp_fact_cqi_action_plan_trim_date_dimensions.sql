USE recency_uganda_prod_analysis_test;
GO

--Count Dates before trimming

SELECT COUNT(*) count_due_dates_before_trim
FROM derived_recency.dim_cqi_action_plan_due_date;




-- $BEGIN

DELETE 
FROM derived_recency.dim_cqi_action_plan_due_date
WHERE 
    date_yyyymmdd  < ( 
        SELECT CONVERT(DATE,COALESCE(MIN(due_date),DATEADD(day,1,(SELECT MAX(date_yyyymmdd) FROM derived_recency.dim_cqi_action_plan_due_date))))
        FROM
        derived_recency.fact_cqi_action_plan
        WHERE due_date IS NOT NULL
    );


-- $END

--Count Dates after trimming

SELECT COUNT(*) count_due_dates_after_trim
FROM derived_recency.dim_cqi_action_plan_due_date;