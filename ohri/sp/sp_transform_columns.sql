DELIMITER //

DROP PROCEDURE IF EXISTS `sp_transform_columns`;

CREATE PROCEDURE `sp_transform_columns`(
        IN output_table_name VARCHAR(100),
        IN column_array VARCHAR(10000),
        IN new_value_if_true VARCHAR(100),
        IN new_value_if_false VARCHAR(100)
)
BEGIN

    SET @column_array = 'key_pop_migrant_worker,key_pop_uniformed_forces,key_pop_transgender';
    SET @start_pos = 1;
    SET @comma_pos = locate(',', @column_array);
    SET @end_loop = 0;
    SET @output_table_name='fact_hts';

    SET @new_value_if_false = 'No';
    SET @new_value_if_true = 'Yes';
    SET @column_label = '';

    REPEAT
        IF @comma_pos > 0 THEN
            SET @column_label = substring(@column_array, @start_pos, @comma_pos - @start_pos);
            SET @end_loop = 0;
        ELSE
            SET @column_label = substring(@column_array, @start_pos);
            SET @end_loop = 1;
        END IF;

        -- UPDATE fact_hts SET @column_label=IF(@column_label IS NULL OR '', new_value_if_false, new_value_if_true);

         SET @update_sql = CONCAT(
                'UPDATE `', @output_table_name ,'` SET `', @column_label ,'` = IF(`', @column_label ,'` IS NULL, `', @new_value_if_false ,'`, `', @new_value_if_true ,'`);');

        PREPARE stmt FROM @update_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        IF @end_loop = 0 THEN
            SET @column_array = substring(@column_array, @comma_pos + 1);
            SET @comma_pos = locate(',', @column_array);
        END IF;
        UNTIL @end_loop = 1

    END REPEAT;

END//

DELIMITER ;