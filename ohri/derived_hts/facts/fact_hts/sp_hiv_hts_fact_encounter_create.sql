# ------Create table

USE analysis;

DROP TABLE IF EXISTS hiv_hts_fact_encounter;

-- $BEGIN

create table hiv_hts_fact_encounter(
    id   int auto_increment,
    encounter_id              int  null,
    client_id                 int null,
    date_tested               date null,
    consent                   varchar(3) charset utf8mb4  null,
    community_service_point   longtext  null,
    pop_type                  text null,
    keypop_category           varchar(8) charset utf8mb4  null,
    priority_pop              varchar(16) charset utf8mb4 null,
    test_setting              text null,
    facility_service_point    longtext null,
    hts_approach              longtext null,
    pretest_counselling       text null,
    type_pretest_counselling  text null,
    reason_for_test           text null,
    ever_tested_hiv           varchar(3) charset utf8mb4  null,
    duration_since_last_test  text null,
    couple_result             text null,
    result_received_couple    text null,
    test_conducted            text null,
    initial_kit_name          text null,
    initial_test_result       text null,
    confirmatory_kit_name     text null,
    last_test_result          text null,
    final_test_result         text null,
    given_result              varchar(7) charset utf8mb4  null,
    date_given_result         date null,
    tiebreaker_kit_name       text null,
    tiebreaker_test_result    text null,
    sti_last_6mo              text null,
    sexually_active           text null,
    syphilis_test_result      text null,
    unprotected_sex_last_12mo text null,
    recency_consent           text null,
    recency_test_done         text null,
    recency_test_type         text null,
    recency_vl_result         text null,
    recency_rtri_result       text null,
    PRIMARY KEY (id)
);

-- $END

