USE analysis;


-- $BEGIN

-- SELECT 'Starting execution of Derived Objects';

-- Derived facts
CALL sp_hiv_hts_dim_client;
CALL sp_hiv_hts_fact_encounter;

-- SELECT 'Executing sp_derived_hts_fact_hts';
CALL sp_fact_hts;

-- $END