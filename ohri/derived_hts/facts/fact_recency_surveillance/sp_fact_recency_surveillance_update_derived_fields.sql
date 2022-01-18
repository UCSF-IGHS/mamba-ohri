USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN


UPDATE 
  derived_recency.fact_recency_surveillance
SET
  is_eligible_for_recency = 
  CASE
    WHEN
      (   (
              is_first_time_hiv_test IS NULL 
            AND
              last_hiv_test_result = 'HIV-'
            AND 
              hiv_final_test_result = 'HIV+'
          )
          OR
          (
                is_first_time_hiv_test = 1
              AND
                hiv_final_test_result = 'HIV+'
          )
          OR 
          (
                is_first_time_hiv_test = 0
              AND 
                  last_hiv_test_result = 'HIV-'
              AND
                  hiv_final_test_result = 'HIV+'
          )
          OR
          (
            (reason_for_testing = 'HIV Self Testing Positive' OR reason_for_testing = 'Inconclusive HIV Results')
            AND 
            hiv_final_test_result = 'HIV+'
          )
          
      ) THEN 1
  ELSE is_eligible_for_recency
  END;


  UPDATE 
  derived_recency.fact_recency_surveillance
  SET
    is_eligible_for_recency = 
    CASE
      WHEN
        (
            (
                  is_first_time_hiv_test IS NULL
                AND
                  hiv_final_test_result = 'HIV+'
                AND 
                  is_eligible_for_recency IS NULL
            )
            OR 
            (
                  is_first_time_hiv_test = 0
                AND 
                    (last_hiv_test_result IS NULL OR last_hiv_test_result = '')
                AND
                    hiv_final_test_result = 'HIV+'
                AND 
                  is_eligible_for_recency IS NULL
            )
        ) THEN NULL
    ELSE is_eligible_for_recency
    END;


  UPDATE 
    derived_recency.fact_recency_surveillance
  SET
    is_eligible_for_recency = 0
  WHERE 
    is_eligible_for_recency IS NULL
  AND
    is_first_time_hiv_test IS NOT NULL 
  AND
    (last_hiv_test_result IS NOT NULL AND last_hiv_test_result <> '')
  AND 
    hiv_final_test_result = 'HIV+'

UPDATE 
  derived_recency.fact_recency_surveillance
SET
  field_rtri_result = lab_field_rtri_result
WHERE 
  lab_field_rtri_result IS NOT NULL;

UPDATE 
  derived_recency.fact_recency_surveillance
SET
  field_rtri_result = emr_field_rtri_result
WHERE 
  emr_field_rtri_result IS NOT NULL
  AND
  lab_field_rtri_result IS NULL;

UPDATE 
  derived_recency.fact_recency_surveillance
SET
  field_rtri_result = NULL
WHERE 
  emr_field_rtri_result IS NULL
  AND
  lab_field_rtri_result IS NULL;

-------------------------------------------------------------------------------

-- update viral load statuses
UPDATE derived_recency.fact_recency_surveillance
SET
    viral_load_count = CAST(viral_load as BIGINT)
WHERE
    ISNUMERIC(viral_load) = 1;

UPDATE derived_recency.fact_recency_surveillance
SET
    viral_load_count =  NULL
WHERE
    viral_load IS NULL
    OR
    ISNUMERIC(viral_load) <> 1;

----------------------------------------------------------------------------------
   
UPDATE derived_recency.fact_recency_surveillance
SET
    viral_load_count_undetectable = 1
WHERE
    viral_load IS NOT NULL 
    AND
    ISNUMERIC(viral_load) = 0;


UPDATE derived_recency.fact_recency_surveillance
SET
    viral_load_count_undetectable = 0
WHERE 
    viral_load IS NOT NULL
    AND
    ISNUMERIC(viral_load) = 1;

--------------------------------------------------------------------------------

UPDATE derived_recency.fact_recency_surveillance
SET
    is_virally_suppressed = 1
WHERE 
    viral_load_count_undetectable = 1 
    OR
    viral_load_count < 1000;


UPDATE derived_recency.fact_recency_surveillance
SET
    is_virally_suppressed = 0
WHERE 
    viral_load_count_undetectable = 0 
    AND
    viral_load_count > 1000;   

-----------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_recent = 1
WHERE
  field_rtri_result = 'Recent';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_recent = 0
WHERE
field_rtri_result IN (
  'Long-term',
  'Negative',
  'Invalid'
  )

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_recent = NULL
WHERE
  field_rtri_result IS NULL;

---------------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_long_term = 1
WHERE
  field_rtri_result = 'Long-term';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_long_term = 0
WHERE
  field_rtri_result IN (
    'Negative',
    'Recent',
    'Invalid'
    )

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_long_term = NULL
WHERE
  field_rtri_result IS NULL;

--------------------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_negative = 1
WHERE
  field_rtri_result = 'Negative';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_negative = 0
WHERE
  field_rtri_result IN (
  'Long-term',
  'Recent',
  'Invalid'
  )

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_negative = NULL
WHERE
  field_rtri_result IS NULL;

---------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_invalid = 1
WHERE
  field_rtri_result = 'Invalid';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_invalid = 0
WHERE
  field_rtri_result IN (
  'Long-term',
  'Recent',
  'Negative'
  )

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_invalid = NULL
WHERE
  field_rtri_result IS NULL;

-------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_missing = 1
WHERE
  field_rtri_result IS NULL;

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  is_rtri_missing = 0
WHERE
  field_rtri_result IS NOT NULL
--------------------------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result = lab_rita_result
WHERE
  lab_rita_result IS NOT NULL;

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result = lab_rtri_result
WHERE
  lab_rtri_result IS NOT NULL
  AND
  lab_rita_result IS NULL

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result = field_rtri_result
WHERE
  field_rtri_result IS NOT NULL
  AND
  lab_rtri_result IS NULL
  AND
  lab_rita_result IS NULL
-----------------------------------------------------------------------------------------------------

UPDATE
  a
SET 
  a.age_at_test = DATEDIFF(year,b.date_of_birth,a.visit_date)
FROM derived_recency.fact_recency_surveillance a
  INNER JOIN
  derived_recency.dim_client b
    ON a.client_id = b.client_id
WHERE
  a.visit_date IS NOT NULL
  AND
  b.date_of_birth IS NOT NULL
-----------------------------------------------------------------------------------------------------
UPDATE
  a
SET 
  a.age_group_id = b.age_group_id
FROM derived_recency.fact_recency_surveillance a
  INNER JOIN
  derived_recency.dim_age_group b
    ON a.age_at_test = b.age
WHERE
  a.age_at_test IS NOT NULL

-----------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_recent = 1
WHERE
  final_recency_result = 'Recent';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_recent = 0
WHERE
  final_recency_result IS NOT NULL
  AND
  final_recency_result <> 'Recent';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_recent = NULL
WHERE
  final_recency_result IS NULL;

---------------------------------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_longterm = 1
WHERE
  final_recency_result = 'Long-term';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_longterm = 0
WHERE
  final_recency_result IS NOT NULL
  AND
  final_recency_result <> 'Long-term';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_longterm = NULL
WHERE
  final_recency_result IS NULL;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_negative = 1
WHERE
  final_recency_result = 'Negative';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_negative = 0
WHERE
  final_recency_result IS NOT NULL
  AND
  final_recency_result <> 'Negative';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_negative = NULL
WHERE
  final_recency_result IS NULL;

------------------------------------------------------------------------------------------------------------

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_invalid = 1
WHERE
  final_recency_result = 'Invalid';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_invalid = 0
WHERE
  final_recency_result IS NOT NULL
  AND
  final_recency_result <> 'Invalid';

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_invalid = NULL
WHERE
  final_recency_result IS NULL;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_missing = 1
WHERE
  final_recency_result  IS NULL;

UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_recency_result_is_missing = 0
WHERE
  final_recency_result IS NOT NULL;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result = 
  CASE 
    WHEN lab_rtri_result IS NOT NULL THEN lab_rtri_result
    WHEN (field_rtri_result IS NOT NULL AND field_rtri_result <> 'Recent') THEN field_rtri_result
    ELSE NULL
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result_is_recent = 
  CASE 
    WHEN final_rtri_result IS NULL THEN NULL
    WHEN final_rtri_result = 'Recent' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result_is_longterm = 
  CASE 
    WHEN final_rtri_result IS NULL THEN NULL
    WHEN final_rtri_result = 'Long-term' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result_is_negative = 
  CASE 
    WHEN final_rtri_result IS NULL THEN NULL
    WHEN final_rtri_result = 'Negative' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result_is_invalid = 
  CASE 
    WHEN final_rtri_result IS NULL THEN NULL
    WHEN final_rtri_result = 'Invalid' THEN 1
    ELSE 0
  END;


------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  final_rtri_result_is_missing = 
  CASE 
    WHEN final_rtri_result IS NULL THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rtri_result_is_recent = 
  CASE 
    WHEN lab_rtri_result IS NULL THEN NULL
    WHEN lab_rtri_result = 'Recent' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rtri_result_is_longterm = 
  CASE 
    WHEN lab_rtri_result IS NULL THEN NULL
    WHEN lab_rtri_result = 'Long-term' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rtri_result_is_negative = 
  CASE 
    WHEN lab_rtri_result IS NULL THEN NULL
    WHEN lab_rtri_result = 'Negative' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rtri_result_is_invalid = 
  CASE 
    WHEN lab_rtri_result IS NULL THEN NULL
    WHEN lab_rtri_result = 'Invalid' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rtri_result_is_missing = 
  CASE 
    WHEN lab_rtri_result IS NULL THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rita_result_is_recent = 
  CASE 
    WHEN lab_rita_result IS NULL THEN NULL
    WHEN lab_rita_result = 'Recent' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rita_result_is_longterm = 
  CASE 
    WHEN lab_rita_result IS NULL THEN NULL
    WHEN lab_rita_result = 'Long-term' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rita_result_is_negative = 
  CASE 
    WHEN lab_rita_result IS NULL THEN NULL
    WHEN lab_rita_result = 'Negative' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rita_result_is_invalid = 
  CASE 
    WHEN lab_rita_result IS NULL THEN NULL
    WHEN lab_rita_result = 'Invalid' THEN 1
    ELSE 0
  END;

------------------------------------------------------------------------------------------------------------
UPDATE
  derived_recency.fact_recency_surveillance
SET 
  lab_rita_result_is_missing = 
  CASE 
    WHEN lab_rita_result IS NULL THEN 1
    ELSE 0
  END;
  
-- $END


SELECT TOP 10 field_rtri_result,is_rtri_missing FROM derived_recency.fact_recency_surveillance WHERE field_rtri_result IS NULL;

SELECT TOP 10 field_rtri_result,is_rtri_missing FROM derived_recency.fact_recency_surveillance WHERE field_rtri_result IS NOT NULL;

SELECT TOP 10 field_rtri_result,is_rtri_invalid FROM derived_recency.fact_recency_surveillance WHERE field_rtri_result = 'Invalid';

SELECT TOP 100 field_rtri_result,lab_rtri_result,lab_rita_result,final_recency_result FROM derived_recency.fact_recency_surveillance;

--Eyeball the data to make sure age is computed correctly and the age_group_ids are correct
SELECT b.date_of_birth,a.visit_date,a.age_at_test,a.age_group_id 
FROM 
	derived_recency.fact_recency_surveillance a
	INNER JOIN
	derived_recency.dim_client b
		ON a.client_id = b.client_id 
WHERE 
	a.visit_date IS NOT NULL  AND b.date_of_birth IS NOT NULL
ORDER BY a.age_at_test,a.age_group_id;


