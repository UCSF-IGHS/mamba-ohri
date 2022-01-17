USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

--Remove facilities with  NULL UID
DELETE 
FROM 
    base.dim_facility
WHERE 
    dhis2_uid IS NULL;


--Delete facilities with Duplicate UID
DELETE 
FROM 
    base.dim_facility
WHERE 
    dhis2_uid = 'QTU5FkY0Zjl' 
    AND [name] = 'Rubanda District HQ HC II';


--Delete facilities with Duplicate Name and District as guided by status
DELETE 
FROM 
    base.dim_facility
WHERE 
    dhis2_uid = 'sxaDm8nr0r3' 
    AND [name] = 'Maaji C HC II'
    AND district = 'Adjumani District';

DELETE 
FROM
    base.dim_facility
WHERE
    dhis2_uid = 'tPeGjcKu4Ak' 
    AND [name] = 'Mulago National Referral Hospital'
    AND district = 'Kampala District';

UPDATE
    base.dim_facility
SET 
    coordinates = NULL
WHERE
    dhis2_uid = 'X7iYabwpJfR' 
    AND replace([coordinates],' ','') = '[31.53349,-0.62998]';

-- $END
   