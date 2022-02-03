USE dbo;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_xf_system_drop_all_tables_in_schema;

CREATE PROCEDURE sp_xf_system_drop_all_tables_in_schema(
    IN database_name NVARCHAR(255)
)
BEGIN

    SET session group_concat_max_len = 20000;

    SET @tbls = (SELECT GROUP_CONCAT(database_name, '.', TABLE_NAME SEPARATOR ', ')
                 FROM information_schema.tables
                 WHERE TABLE_TYPE = 'BASE TABLE'
                   AND TABLE_SCHEMA = database_name);

    SET @drop_tables = CONCAT('DROP TABLE IF EXISTS ', @tbls);

    SET foreign_key_checks = 0; -- Remove check, so we don't have to drop tables in the correct order, nor whether they actually exist.
    PREPARE drop_tbls FROM @drop_tables;
    EXECUTE drop_tbls;
    DEALLOCATE PREPARE drop_tbls;
    SET foreign_key_checks = 1;

END//

DELIMITER ;