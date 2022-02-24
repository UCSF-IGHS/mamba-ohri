USE analysis;

TRUNCATE TABLE mamba_dim_concept_metadata;

-- $BEGIN

INSERT INTO mamba_dim_concept_metadata (
    column_number,
    column_label,
    concept_uuid,
    report_name
)
VALUES  (1, 'test_setting', '13abe5c9-6de2-4970-b348-36d352ee8eeb', 'fact_hts'),
        (2, 'community_service_point', '74a3b695-30f7-403b-8f63-3f766461e104', 'fact_hts'),
        (3, 'facility_service_point', '80bcc9c1-e328-47e8-affe-6d1bffe4adf1', 'fact_hts'),
        (4, 'hts_approach', '9641ead9-8821-4898-b633-a8e96c0933cf', 'fact_hts'),
        (5, 'pop_type', '166432AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (6, 'key_pop_type', 'd3d4ae96-8c8a-43db-a9dc-dac951f5dcb3', 'fact_hts'),
        (7, 'key_pop_migrant_worker', '63ea75cb-205f-4e7b-9ede-5f9b8a4dda9f', 'fact_hts'),
        (8, 'key_pop_uniformed_forces', 'b282bb08-62a7-42c2-9bea-8751c267d13e', 'fact_hts'),
        (10, 'key_pop_transgender', '22b202fc-67de-4af9-8c88-46e22559d4b2', 'fact_hts'),
        (11, 'key_pop_AGYW', '678f3144-302f-493e-ba22-7ec60a84732a', 'fact_hts'),
        (12, 'key_pop_fisher_folk', 'def00c73-f6d5-42fb-bcec-0b192b5be22d', 'fact_hts'),
        (13, 'key_pop_prisoners', '8da9bf92-22f6-40be-b468-1ad08de7d457', 'fact_hts'),
        (14, 'key_pop_refugees', 'dc1058ea-4edd-4780-aeaa-a474f7f3a437', 'fact_hts'),
        (15, 'key_pop_msm', '160578AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (16, 'key_pop_fsw', '160579AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (17, 'key_pop_truck_driver', '162198AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (18, 'key_pop_pwd', '365371fd-0106-4a53-abc4-575e3d65d372', 'fact_hts'),
        (19, 'key_pop_pwid', 'c038bff0-8e33-408c-b51f-7fb6448d2f6c', 'fact_hts'),
        (20, 'sexually_active', '160109AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (21, 'unprotected_sex_last_12mo', '159218AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (22, 'sti_last_6mo', '156660AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (23, 'ever_tested_hiv', '1492AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (24, 'duration_since_last_test', 'e7947a45-acff-49e1-ba1c-33e43a710e0d', 'fact_hts'),
        (25, 'last_test_result', '159427AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (26, 'reason_for_test', 'ce3816e7-082d-496b-890b-a2b169922c22', 'fact_hts'),
        (27, 'pretest_counselling', 'de32152d-93b0-412a-908a-20af0c46f215', 'fact_hts'),
        (28, 'type_pretest_counselling', '0473ec07-2f34-4447-9c58-e35a1c491b6f', 'fact_hts'),
        (29, 'consent_provided', '1710AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (30, 'test_conducted', '164401AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (31, 'date_test_conducted', '164400AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (32, 'initial_kit_name', 'afa64df8-50af-4bc3-8135-6e6603f62068', 'fact_hts'),
        (33, 'initial_test_result', 'e767ba5d-7560-43ba-a746-2b0ff0a2a513', 'fact_hts'),
        (34, 'confirmatory_kit_name', 'b78d89e7-08aa-484f-befb-1e3e70cd6985', 'fact_hts'),
        (35, 'tiebreaker_kit_name', '73434a78-e4fc-42f7-a812-f30f3b3cabe3', 'fact_hts'),
        (36, 'tiebreaker_test_result', 'bfc5fbb9-2b23-422e-a741-329bb2597032', 'fact_hts'),
        (37, 'final_test_result', 'e16b0068-b6a2-46b7-aba9-e3be00a7b4ab', 'fact_hts'),
        (38, 'syphilis_test_result', '165303AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (39, 'given_result', '164848AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (40, 'date_given_result', '160082AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (41, 'result_received_couple', '445846e9-b929-4519-bc83-d51c051918f5', 'fact_hts'),
        (42, 'couple_result', '5f38bc97-d6ca-43f8-a019-b9a9647d0c6a', 'fact_hts'),
        (43, 'recency_consent', '976ca997-fb2b-4bef-a299-f7c9e16b50a8', 'fact_hts'),
        (44, 'recency_test_done', '4fe5857e-c804-41cf-b3c9-0acc1f516ab7', 'fact_hts'),
        (45, 'recency_test_type', '05112308-79ba-4e00-802e-a7576733b98e', 'fact_hts'),
        (46, 'recency_rtri_result', '165092AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (47, 'recency_vl_result', '856AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts');

-- $END