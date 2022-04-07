# ------Create table

USE analysis;

DROP TABLE IF EXISTS covid_dim_client;

-- $BEGIN

create table  covid_dim_client(
    id   int auto_increment,
    client_id     int null,
    date_of_birth date null,
    ageattest     int null,
    sex           nvarchar(50) null,
    county        nvarchar(255) null,
    sub_county    nvarchar(255) null,
    ward          nvarchar(255) null,
    PRIMARY KEY (id)
);

-- $END

