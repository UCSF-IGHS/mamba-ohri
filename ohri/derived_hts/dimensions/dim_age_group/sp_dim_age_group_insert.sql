USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE derived_recency.dim_age_group

-- $BEGIN

DECLARE @age INT, @max_age INT,@row_id INT;
SET @age = 0;
SET @max_age = 150;
SET @row_id = 1;

WHILE @age <= @max_age
    BEGIN
        INSERT INTO derived_recency.dim_age_group (
            age_group_id,
            pepfar_mer_age_interval,
            age,
            pepfar_mer_age_interval_val
        )
        VALUES(
            @row_id,
            NULL,
            @age,
            NULL
            );
        SET @row_id = @row_id + 1;
        SET @age = @age + 1;
    END   

UPDATE derived_recency.dim_age_group
SET pepfar_mer_age_interval = (
    CASE
        WHEN age < 15 THEN '0-14'
        WHEN age >= 15 AND age <=19 THEN '15-19'
        WHEN age >=20 AND age <=24 THEN '20-24'
        WHEN age >=25 AND age <=29 THEN '25-29'
        WHEN age >=30 AND age <=34 THEN '30-34'
        WHEN age >=35 AND age <=39 THEN '35-39'
        WHEN age >=40 AND age <=44 THEN '40-44'
        WHEN age >=45 AND age <=49 THEN '45-49'
        WHEN age >=50 THEN '50+'
    END
);



UPDATE derived_recency.dim_age_group
SET pepfar_mer_age_interval_val = (
    CASE
        WHEN pepfar_mer_age_interval = '0-14' THEN 1
        WHEN pepfar_mer_age_interval = '15-19' THEN 2
        WHEN pepfar_mer_age_interval = '20-24' THEN 3
        WHEN pepfar_mer_age_interval = '25-29' THEN 4
        WHEN pepfar_mer_age_interval = '30-34' THEN 5
        WHEN pepfar_mer_age_interval = '35-39' THEN 6
        WHEN pepfar_mer_age_interval = '40-44' THEN 7
        WHEN pepfar_mer_age_interval = '45-49' THEN 8
        WHEN pepfar_mer_age_interval = '50+' THEN  9
    END
);


-- $END

SELECT TOP 100 * from derived_recency.dim_age_group;
