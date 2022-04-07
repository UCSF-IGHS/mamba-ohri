USE analysis;


-- $BEGIN

-- SELECT 'Starting execution of Derived Objects';

-- Derived facts
-- SELECT '';
CALL sp_covid_dim_client;

CALL sp_covid_fact_encounter;
-- $END