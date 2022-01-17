USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS derived_recency.dim_age_group

-- $BEGIN

CREATE TABLE derived_recency.dim_age_group(
    age_group_id INT NOT NULL,
    pepfar_mer_age_interval NVARCHAR(255) NULL,
    age INT NULL,
    pepfar_mer_age_interval_val INT  NULL,
    );

ALTER TABLE derived_recency.dim_age_group ADD CONSTRAINT PK_age_group_id PRIMARY KEY (age_group_id)

-- $END


