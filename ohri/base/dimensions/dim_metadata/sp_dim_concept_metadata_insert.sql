USE analysis;
GO

TRUNCATE TABLE base.concept_metadata;

-- $BEGIN

INSERT INTO base.concept_metadata (
    column_number,
    column_label,
    concept_uuid
)
VALUES  (1, 'test_setting', '13abe5c9-6de2-4970-b348-36d352ee8eeb'),
        (2, 'community_service_point', '74a3b695-30f7-403b-8f63-3f766461e104'),
        (3, 'facility_service_point', '80bcc9c1-e328-47e8-affe-6d1bffe4adf1'),
        (4, 'hts_approach', '9641ead9-8821-4898-b633-a8e96c0933cf'),
        (5, 'pop_type', '166432AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (6, 'key_pop_type', 'd3d4ae96-8c8a-43db-a9dc-dac951f5dcb3'),
        (7, 'key_pop_migrant_worker', '63ea75cb-205f-4e7b-9ede-5f9b8a4dda9f'),
        (8, 'key_pop_uniformed_forces', 'b282bb08-62a7-42c2-9bea-8751c267d13e'),
        (10, 'key_pop_transgender', '22b202fc-67de-4af9-8c88-46e22559d4b2'),
        (11, 'key_pop_AGYW', '678f3144-302f-493e-ba22-7ec60a84732a'),
        (12, 'key_pop_fisher_folk', 'def00c73-f6d5-42fb-bcec-0b192b5be22d'),
        (13, 'key_pop_prisoners', '8da9bf92-22f6-40be-b468-1ad08de7d457'),
        (14, 'key_pop_refugees', 'dc1058ea-4edd-4780-aeaa-a474f7f3a437'),
        (15, 'key_pop_msm', '160578AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (16, 'key_pop_fsw', '160579AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (17, 'key_pop_truck_driver', '162198AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (18, 'key_pop_pwd', '365371fd-0106-4a53-abc4-575e3d65d372'),
        (19, 'key_pop_pwid', 'c038bff0-8e33-408c-b51f-7fb6448d2f6c'),
        (20, 'sexually_active', '160109AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (21, 'hts_approach', '9641ead9-8821-4898-b633-a8e96c0933cf'),
        (22, 'date_test_conducted', '164400AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        (23, 'initial_kit_name', 'afa64df8-50af-4bc3-8135-6e6603f62068');

-- $END
