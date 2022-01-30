USE analysis;


DROP TABLE IF EXISTS derived_hts_fact_hts;

-- $BEGIN

CREATE TABLE derived_hts_fact_hts (
    fact_hts_id int NOT NULL AUTO_INCREMENT,
    encounter_id int, 
    client_id int,
    test_setting NVARCHAR(255), 
    community_service_point NVARCHAR(255), 
    facility_service_point NVARCHAR(255), 
    hts_approach NVARCHAR(255), 
    pop_type NVARCHAR(255), 
    key_pop_type NVARCHAR(255), 
    key_pop_migrant_worker NVARCHAR(255),
    PRIMARY KEY (fact_hts_id)
);

-- $END