DELIMITER //

DROP PROCEDURE IF EXISTS sp_extract_form_data;

CREATE PROCEDURE sp_extract_form_data(
    IN report_data MEDIUMTEXT,
    IN metadata_table NVARCHAR(255)
)
BEGIN

    SET session group_concat_max_len = 20000;

    -- TRUNCATE TABLE metadata_table;

    SELECT JSON_EXTRACT(report_data, '$.name') INTO @form_name;
    SELECT JSON_EXTRACT(report_data, '$.encounterType') INTO @encounter_type_uuid;
    SELECT JSON_EXTRACT(report_data, '$.pages') INTO @page_array;
    SELECT JSON_LENGTH(@page_array) INTO @page_count;

    SET @page_number = 0;
    WHILE @page_number < @page_count
        DO

            SELECT JSON_EXTRACT(@page_array, CONCAT('$[', @page_number, ']')) INTO @page;

            SELECT JSON_EXTRACT(@page, '$.sections') INTO @section_array;
            SELECT JSON_LENGTH(@section_array) INTO @section_count;

            SET @section_number = 0;
            WHILE @section_number < @section_count
                DO
                    SELECT JSON_EXTRACT(@section_array, CONCAT('$[', @section_number, ']')) INTO @section;
                    SELECT JSON_EXTRACT(@section, '$.questions') INTO @question_array;

                    CALL sp_extract_metadata_from_form_helper(@question_array, @encounter_type_uuid, @form_name);

                    SET @section_number = @section_number + 1;
                END WHILE;

            SET @page_number = @page_number + 1;
        END WHILE;

END;
//

DELIMITER ;