
CREATE OR ALTER PROCEDURE dbo.sp_xf_system_drop_all_tables_in_schema(@schema AS NVARCHAR(255)) AS
BEGIN

    DECLARE @name VARCHAR(128)
    DECLARE @SQL NVARCHAR ( MAX );

    SELECT @name = (SELECT TOP 1 [name] FROM sys.objects WHERE [type] = 'U' AND SCHEMA_NAME(schema_id) = @schema ORDER BY [name])

    WHILE @name IS NOT NULL
    BEGIN
        SELECT @SQL = 'DROP TABLE [' + @schema + '].[' + RTRIM(@name) +']'
        CALL (@SQL)
        PRINT 'Dropped table: ' + @name
        SELECT @name = (SELECT TOP 1 [name] FROM sys.objects WHERE [type] = 'U' AND SCHEMA_NAME(schema_id) = @schema AND [name] > @name ORDER BY [name])
    END

END