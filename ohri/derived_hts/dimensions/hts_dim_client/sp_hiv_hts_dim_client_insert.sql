# ---------INSERT into table
USE analysis;

-- $BEGIN

INSERT INTO hiv_hts_dim_client (
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
    DATEDIFF("date_test_conducted","date_of_birth")/365 as ageattest,
    sex,
    county,
    sub_county,
    ward
FROM dim_client c
INNER JOIN encounter_hts hts
    ON c.client_id = hts.client_id;


-- $END
