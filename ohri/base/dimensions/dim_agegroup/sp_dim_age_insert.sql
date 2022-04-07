
USE analysis;
-- $BEGIN

-- Enter unknown dimension value (in case a person's date of birth is unknown)
INSERT INTO dim_age
           (age
           ,datim_agegroup
           ,normal_agegroup)
     VALUES
           (-1
           ,'Unknown'
           ,'Unknown');
-- $END