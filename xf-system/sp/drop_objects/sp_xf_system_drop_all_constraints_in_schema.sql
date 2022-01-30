
CREATE OR ALTER PROCEDURE dbo.sp_xf_system_drop_all_constraints_in_schema(@schema AS VARCHAR(255)) AS
BEGIN

    CALL dbo.sp_xf_system_drop_all_foreign_keys_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_primary_keys_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_unique_check_default_constraints_in_schema @schema;

END