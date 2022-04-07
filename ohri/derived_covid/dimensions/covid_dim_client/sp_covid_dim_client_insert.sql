# -----INSERT into table
USE analysis;

-- $BEGIN

INSERT INTO covid_dim_client (
        client_id,
        date_of_birth,
        ageattest,
        sex,
        county,
        sub_county,
        ward
)
SELECT
    c.client_id,
    date_of_birth,
    DATEDIFF("order_date","date_of_birth")/365 as ageattest,
    sex,
    county,
    sub_county,
    ward
FROM dim_client c
INNER JOIN encounter_covid cd
    ON c.client_id = cd.client_id;


-- $END
