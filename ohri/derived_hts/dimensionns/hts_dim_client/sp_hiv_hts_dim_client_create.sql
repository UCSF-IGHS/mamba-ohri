USE analysis;

DROP TABLE IF EXISTS hiv_hts_dim_client;

-- $BEGIN

create table if not exists hiv_hts_dim_client(
    id   int auto_increment,
    client_id     int null,
    date_of_birth date null,
    ageattest     int null,
    sex           varchar(255) charset utf8 null,
    county        varchar(255) charset utf8 null,
    sub_county    varchar(255) charset utf8 null,
    ward          varchar(255) charset utf8 null,
    PRIMARY KEY (id)
);

-- $END

