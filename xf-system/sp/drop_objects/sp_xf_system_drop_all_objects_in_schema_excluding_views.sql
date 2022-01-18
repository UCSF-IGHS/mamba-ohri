
CREATE OR ALTER PROCEDURE dbo.sp_xf_system_drop_all_objects_in_schema_excluding_views(@schema AS VARCHAR(255)) AS
BEGIN

    EXEC dbo.sp_xf_system_drop_all_functions_in_schema @schema;
    EXEC dbo.sp_xf_system_drop_all_foreign_keys_in_schema @schema;
    EXEC dbo.sp_xf_system_drop_all_primary_keys_in_schema @schema;
    EXEC dbo.sp_xf_system_drop_all_tables_in_schema @schema;
    EXEC dbo.sp_xf_system_drop_all_stored_procedures_in_schema @schema;

END