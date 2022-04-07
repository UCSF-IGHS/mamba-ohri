
USE analysis;

DROP TABLE IF EXISTS dim_age;

-- $BEGIN

-- Create table dim_age

CREATE TABLE dim_age(
    dim_age_id int auto_increment primary key,
    age int NULL,
    datim_agegroup nvarchar(50) NULL,
    normal_agegroup nvarchar(50) NULL
);

-- $END