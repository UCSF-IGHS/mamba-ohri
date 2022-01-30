
CREATE OR ALTER PROCEDURE dbo.sp_xf_system_drop_all_functions_in_schema(@schema AS NVARCHAR(255)) AS
BEGIN

    DECLARE @SQL NVARCHAR ( MAX );

    SET @SQL = N'';
    SELECT
        @SQL = @SQL + N'
    DROP FUNCTION [' + @schema + '].[' + RTRIM(c.name) +']; '
    FROM
        sys.objects AS c
    WHERE
        c.[type] IN ('FN', 'IF', 'FN', 'AF', 'FS', 'FT')
        AND SCHEMA_NAME(c.schema_id) = @schema
    ORDER BY
        c.[type];

    CALL(@SQL)
    PRINT 'Dropped functions in schema: ' + @schema

END