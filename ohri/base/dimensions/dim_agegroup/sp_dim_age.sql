USE analysis;

-- $BEGIN

CALL sp_dim_age_create();
CALL sp_dim_age_insert();
-- CALL sp_dim_age_update();