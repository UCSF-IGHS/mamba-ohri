USE analysis;


-- $BEGIN

-- SELECT 'Starting execution of Derived Objects';

-- Derived facts
-- SELECT '';
CALL sp_dim_client_covid;

CALL sp_fact_encounter_covid;
-- $END