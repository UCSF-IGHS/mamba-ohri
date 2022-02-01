USE analysis;

TRUNCATE TABLE base_dim_concept_metadata;

-- $BEGIN

INSERT INTO base_dim_concept_metadata (
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
        (21, 'hts_approach', '9641ead9-8821-4898-b633-a8e96c0933cf', 'fact_hts'),
        (22, 'date_test_conducted', '164400AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts'),
        (23, 'initial_kit_name', 'afa64df8-50af-4bc3-8135-6e6603f62068', 'fact_hts'),
        (24, 'last_viral_load', '163545AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'fact_hts');

-- $END