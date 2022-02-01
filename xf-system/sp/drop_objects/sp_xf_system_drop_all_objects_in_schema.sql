
CREATE OR ALTER PROCEDURE dbo.sp_xf_system_drop_all_objects_in_schema(@schema AS VARCHAR(255)) AS
BEGIN

    CALL dbo.sp_xf_system_drop_all_views_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_functions_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_foreign_keys_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_primary_keys_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_tables_in_schema @schema;
    CALL dbo.sp_xf_system_drop_all_stored_procedures_in_schema @schema;

END