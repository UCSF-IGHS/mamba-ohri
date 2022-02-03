USE dbo;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_xf_system_drop_all_stored_procedures_in_schema;

CREATE PROCEDURE sp_xf_system_drop_all_stored_procedures_in_schema(
    IN database_name NVARCHAR(255)
)
BEGIN

    DECLARE view_name NVARCHAR(255);
    DECLARE done INT DEFAULT FALSE;

    DECLARE cursor_etl_views CURSOR FOR SELECT procedure_name FROM etl_views;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DROP TEMPORARY TABLE IF EXISTS etl_views;
    CREATE TEMPORARY TABLE IF NOT EXISTS etl_views
    SELECT SPECIFIC_NAME AS procedure_name
    FROM information_schema.routines
    WHERE ROUTINE_TYPE = 'PROCEDURE'
      AND ROUTINE_SCHEMA = database_name;

    OPEN cursor_etl_views;
    REPEAT
        FETCH cursor_etl_views INTO view_name;

        SET @drop_sp = CONCAT('DROP PROCEDURE IF EXISTS `', database_name, '`.`', view_name, '`;');

        PREPARE drop_sp FROM @drop_sp;
        EXECUTE drop_sp;
        DEALLOCATE PREPARE drop_sp;

    UNTIL done END REPEAT;
    CLOSE cursor_etl_views;

    CREATE TEMPORARY TABLE IF NOT EXISTS tmps
    SELECT @drop_sp;

END//

DELIMITER ;

CALL sp_xf_system_drop_all_stored_procedures_in_schema('analysis');

delete from mysql.proc WHERE db='analysis';