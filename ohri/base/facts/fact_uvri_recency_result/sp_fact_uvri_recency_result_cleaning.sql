USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

--update the facility ids of the records with NULL facility ids
UPDATE 
  base.fact_uvri_recency_result
SET
  facility_id = (
    SELECT facility_id 
    FROM base.dim_facility
    WHERE 
      name = 'Unknown'
  )
WHERE facility_id IS NULL;

-- delete empty row values
DELETE FROM 
  base.fact_uvri_recency_result
WHERE 
  lab_number IS NULL


UPDATE
  base.fact_uvri_recency_result
SET 
  viral_load_date = NULL
WHERE
  viral_load_date = '1900-01-01';

UPDATE 
  base.fact_uvri_recency_result
SET
  sample_collection_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = sample_collection_date
); 

UPDATE 
  base.fact_uvri_recency_result
SET
  sample_registration_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = sample_registration_date
); 

UPDATE 
  base.fact_uvri_recency_result
SET
  kit_expiry_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = kit_expiry_date
); 

UPDATE 
  base.fact_uvri_recency_result
SET
  uvri_test_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = uvri_test_date
); 

UPDATE 
  base.fact_uvri_recency_result
SET
  viral_load_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = viral_load_date
  );


--Transform rtri_field_result values into allowable domain values e.g LT->Longterm, R->Recent, NEG->Negative,No RTRI->NULL

UPDATE 
  base.fact_uvri_recency_result
SET
  lab_field_rtri_result = 'Long-term' 
WHERE 
  UPPER(lab_field_rtri_result) = 'LT';


UPDATE 
  base.fact_uvri_recency_result
SET
  lab_field_rtri_result = 'Recent'
WHERE 
  UPPER(lab_field_rtri_result) = 'R';

UPDATE 
  base.fact_uvri_recency_result
SET
  lab_field_rtri_result = NULL 
WHERE 
  UPPER(lab_field_rtri_result) = 'NO RTRI'
  OR lab_field_rtri_result = '';

UPDATE 
  base.fact_uvri_recency_result
SET
  lab_field_rtri_result = 'Negative'
WHERE 
  UPPER(lab_field_rtri_result) = 'NEG';
  

--Transform rtri_uvri_result values into allowable domain values e.g LT->Longterm, R->Recent, NEG->Negative,''->NULL

UPDATE 
  base.fact_uvri_recency_result
SET
  lab_rtri_result = 'Long-term'
WHERE 
  UPPER(lab_rtri_result) = 'LT';

UPDATE 
  base.fact_uvri_recency_result
SET 
  lab_rtri_result = 'Recent' 
WHERE 
  UPPER(lab_rtri_result) = 'R';


UPDATE 
  base.fact_uvri_recency_result
SET
    lab_rtri_result = NULL 
WHERE 
  UPPER(lab_rtri_result) = 'NO RTRI'
  OR lab_rtri_result = '';

UPDATE 
  base.fact_uvri_recency_result
SET
    lab_rtri_result = 'Negative'
WHERE 
  UPPER(lab_rtri_result) = 'NEG';

-- $END
   