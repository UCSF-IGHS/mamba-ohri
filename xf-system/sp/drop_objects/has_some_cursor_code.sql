USE dbo;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_xf_system_drop_all_views_in_schema;

CREATE PROCEDURE sp_xf_system_drop_all_views_in_schema(
    IN database_name NVARCHAR(255)
)
BEGIN

    DECLARE view_name NVARCHAR(255);
    DECLARE done INT DEFAULT FALSE;

    DECLARE cursor_etl_views CURSOR FOR SELECT table_name FROM etl_views;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @view_names := NULL;
    SET @drop_view = '';

    DROP TEMPORARY TABLE IF EXISTS etl_views;
    CREATE TEMPORARY TABLE IF NOT EXISTS etl_views
    SELECT table_name FROM information_schema.tables WHERE table_type = 'VIEW' AND table_schema = 'analysis';

    #     SET @fill_etl_views := CONCAT('SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema='analysis'';);
#     PREPARE fill_etl_views FROM @fill_etl_views;
#     EXECUTE fill_etl_views;
#     DEALLOCATE PREPARE fill_etl_views;

    OPEN cursor_etl_views;
    REPEAT
        FETCH cursor_etl_views INTO view_name;

        SET @drop_view = CONCAT(@drop_view, ' DROP VIEW IF EXISTS `', database_name, '`.`', view_name, '`;');

    UNTIL done END REPEAT;
    CLOSE cursor_etl_views;

    PREPARE drop_view FROM @drop_view;
    EXECUTE drop_view;
    DEALLOCATE PREPARE drop_view;

END//

DELIMITER ;

CALL sp_xf_system_drop_all_views_in_schema('analysis');





 SELECT 'DROP PROCEDURE ' + ROUTINE_SCHEMA + '.' + SPECIFIC_NAME AS stmt
    FROM information_schema.routines
    WHERE ROUTINE_TYPE = 'PROCEDURE'
      AND ROUTINE_SCHEMA = 'analysis';

    SELECT *
    FROM information_schema.routines
    WHERE ROUTINE_TYPE = 'PROCEDURE'
      AND ROUTINE_SCHEMA = 'analysis';

    select * from mysql.proc WHERE db='analysis' AND type='PROCEDURE' AND name='sp_mamba_dim_concept_metadata';
    -- delete from mysql.proc WHERE db='analysis' AND type='PROCEDURE' AND name='sp_mamba_dim_concept_metadata';


    SELECT CONCAT('DROP ', ROUTINE_TYPE, ' `', ROUTINE_SCHEMA, '`.`', ROUTINE_NAME, '`;') as stmt
    FROM information_schema.ROUTINES
    WHERE ROUTINE_TYPE = 'PROCEDURE'
      AND ROUTINE_SCHEMA = 'analysis';