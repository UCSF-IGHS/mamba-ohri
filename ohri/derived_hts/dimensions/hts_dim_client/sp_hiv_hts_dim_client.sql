USE analysis;

-- $BEGIN

CALL sp_hiv_hts_dim_client_create();
CALL sp_hiv_hts_dim_client_insert();
CALL sp_hiv_hts_dim_client_update();