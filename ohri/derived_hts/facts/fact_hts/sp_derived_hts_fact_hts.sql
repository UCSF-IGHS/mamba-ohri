USE analysis;

-- $BEGIN

CALL sp_generate_fact('fact_hts', 'fact_hts');-- add encounter id param





-- CALL sp_transform_columns('fact_hts', 'key_pop_migrant_worker, key_pop_uniformed_forces, key_pop_transgender', 'Yes', 'No');

-- $END