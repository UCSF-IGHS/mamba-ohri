DELIMITER //

DROP FUNCTION IF EXISTS fn_compute_obs_hiv_status;

CREATE FUNCTION fn_compute_obs_hiv_status(hivStatusObsValueCoded VARCHAR(20)) RETURNS VARCHAR(20)
    DETERMINISTIC
BEGIN
    DECLARE obsValueColumn VARCHAR(20);

    IF (conceptDatatype = 'Text' OR conceptDatatype = 'Coded' OR conceptDatatype = 'N/A' OR conceptDatatype = 'Boolean') THEN
        SET obsValueColumn = 'obs_value_text';
    ELSEIF conceptDatatype = 'Date' OR conceptDatatype = 'Datetime' THEN
        SET obsValueColumn = 'obs_value_datetime';
    ELSEIF conceptDatatype = 'Numeric' THEN
        SET obsValueColumn = 'obs_value_numeric';
    END IF;

    RETURN (obsValueColumn);
END//

DELIMITER ;