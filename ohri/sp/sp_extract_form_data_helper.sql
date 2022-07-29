DELIMITER //

DROP PROCEDURE IF EXISTS sp_extract_metadata_from_form_helper;

CREATE PROCEDURE sp_extract_metadata_from_form_helper(
    IN question_json_array MEDIUMTEXT,
    IN encounter_type_uuid VARCHAR(38),
    IN form_name TEXT
)
BEGIN

    DECLARE question_type VARCHAR(255);
    SET session group_concat_max_len = 20000;

    SELECT JSON_LENGTH(@question_array) INTO @question_count;

    SET @question_number = 0;
    WHILE @question_number < @question_count
        DO
            SELECT JSON_EXTRACT(question_json_array, CONCAT('$[', @question_number, ']')) INTO @question;

            SELECT JSON_EXTRACT(@question, '$.type') INTO @type;
            -- SET question_type = JSON_UNQUOTE(@type);
            -- IF question_type = 'obsGroup' THEN
            SELECT JSON_EXTRACT(@question, '$.questionOptions') INTO @question_options;
            SELECT JSON_EXTRACT(@question, '$.id') INTO @id;
            SELECT JSON_EXTRACT(@question, '$.label') INTO @label;
            SELECT JSON_EXTRACT(@question_options, '$.concept') INTO @concept_uuid;
            SELECT JSON_EXTRACT(@question_options, '$.rendering') INTO @rendering;

            SET @tbl_name = fn_extract_table_name(JSON_UNQUOTE(@form_name));
            SET @et_uuid = JSON_UNQUOTE(@encounter_type_uuid);

            INSERT INTO mamba_dim_form_data(encounter_type_id,
                                            encounter_type_uuid,
                                            form_name,
                                            form_concept_id,
                                            concept_rendering,
                                            concept_uuid,
                                            concept_label,
                                            column_label)
            SELECT e.encounter_type_id,
                   @et_uuid,
                   JSON_UNQUOTE(@form_name),
                   JSON_UNQUOTE(@id),
                   JSON_UNQUOTE(@rendering),
                   JSON_UNQUOTE(@concept_uuid),
                   JSON_UNQUOTE(@label),
                   JSON_UNQUOTE(@id)
            FROM mamba_dim_encounter_type e
            where e.uuid = @et_uuid;

            SET @question_number = @question_number + 1;
        END WHILE;

END;
//

DELIMITER ;