USE analysis;

-- $BEGIN

CALL sp_covid_dim_client_create();
CALL sp_covid_dim_client_insert();
CALL sp_covid_dim_client_update();