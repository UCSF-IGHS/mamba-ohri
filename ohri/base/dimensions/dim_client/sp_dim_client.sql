USE analysis;

-- $BEGIN

CALL sp_dim_client_create();
CALL sp_dim_client_insert();
CALL sp_dim_client_update();

-- $END


CALL sp_data_processing();