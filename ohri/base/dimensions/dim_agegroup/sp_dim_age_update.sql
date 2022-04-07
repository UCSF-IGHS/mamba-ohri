USE analysis;


-- $BEGIN
DELIMITER //

DROP PROCEDURE IF EXISTS sp_insert_age_data;

CREATE PROCEDURE sp_insert_age_data(age INT)
BEGIN
   INSERT INTO dim_age (age
          ,datim_agegroup
          ,normal_agegroup)
    VALUES (age,
            CASE
                WHEN age < 1 THEN '<1'
                WHEN age between 1 and 4 THEN '1-4'
                WHEN age between 5 and 9 THEN '5-9'
                WHEN age between 10 and 14 THEN '10-14'
                WHEN age between 15 and 19 THEN '15-19'
                WHEN age between 20 and 24 THEN '20-24'
                WHEN age between 25 and 29 THEN '25-29'
                WHEN age between 30 and 34 THEN '30-34'
                WHEN age between 35 and 39 THEN '35-39'
                WHEN age between 40 and 44 THEN '40-44'
                WHEN age between 45 and 49 THEN '45-49'
                WHEN age between 50 and 54 THEN '50-54'
                WHEN age between 55 and 59 THEN '55-59'
                WHEN age between 60 and 64 THEN '60-64'
                ELSE '65+'
            END,
            CASE
                WHEN age < 15 THEN '<15'
                ELSE '15+' END
            );
END //

DELIMITER ;

-- Loop through ages 0 to 120(or whatever value you choose) using this stored procedure
# --Stored Procedure 2
DELIMITER //

DROP PROCEDURE IF EXISTS sp_LoadCal;

CREATE PROCEDURE sp_LoadCal(
   age INT,
   num INT)
BEGIN
    DECLARE counter INT DEFAULT 1;
   DECLARE dt INT DEFAULT age;
   WHILE counter <= num DO
       CALL sp_insert_age_data(dt);
       SET counter = counter + 1;
       SET dt = dt + 1;
   END WHILE;
END //
DELIMITER ;


-- $END