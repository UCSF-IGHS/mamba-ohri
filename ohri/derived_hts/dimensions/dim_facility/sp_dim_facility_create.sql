USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

DROP TABLE IF EXISTS derived_recency.dim_facility;

CREATE TABLE derived_recency.dim_facility (
    facility_id uniqueidentifier  NOT NULL,
    implementing_mechanism_id uniqueidentifier NULL,
    [name] nvarchar(255) NULL,
    dhis2_uid nvarchar(255) NULL,
    coordinates nvarchar(255) NULL,
    longitude decimal(10,6) NULL,
    latitude decimal(10,6) NULL,
    [level] nvarchar(255) NULL,
    sub_county nvarchar(255) NULL,
    district nvarchar(255) NULL,
    region nvarchar(255) NULL,
    authority_name nvarchar(255) NULL,
    [ownership] nvarchar(255) NULL,
    sub_region nvarchar(255) NULL,
    parish nvarchar(255) NULL,
    country nvarchar(255) NULL,
    last_uploaded_on date NULL,
    last_uploaded_on_id INT NULL,
    activation_date date NULL,
    activation_date_id INT NULL,

);

ALTER TABLE derived_recency.dim_facility ADD CONSTRAINT PK_derived_facility_id PRIMARY KEY (facility_id);
ALTER TABLE derived_recency.dim_facility ADD CONSTRAINT FK_last_uploaded_on_id
FOREIGN KEY (last_uploaded_on_id) references derived_recency.dim_last_uploaded_on_date (date_id);
ALTER TABLE derived_recency.dim_facility ADD CONSTRAINT FK_activation_date_id
FOREIGN KEY (activation_date_id) references derived_recency.dim_activation_date (date_id);

ALTER TABLE derived_recency.dim_facility ADD CONSTRAINT FK_derived_implementing_mechanism_id
FOREIGN KEY (implementing_mechanism_id) references derived_recency.dim_implementing_mechanism(implementing_mechanism_id);



-- $END