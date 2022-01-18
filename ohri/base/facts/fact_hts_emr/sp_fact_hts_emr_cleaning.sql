USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

--Remove invalid dates (00/01/1900) from the  last_hiv_test_date field
UPDATE 
  base.fact_hts_emr
SET
    last_hiv_test_date = NULL
WHERE 
    last_hiv_test_date = '00:00:00.000';

-- Add date Ids
UPDATE 
  base.fact_hts_emr
SET
  visit_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = visit_date
  );

UPDATE 
  base.fact_hts_emr
SET
  last_hiv_test_date_id = (
    SELECT 
      date_id 
    FROM 
      base.dim_date 
    WHERE 
      date_yyyymmdd = last_hiv_test_date
); 


UPDATE 
  base.fact_hts_emr
SET
  field_rtri_result = 'Long-term' 
WHERE 
  UPPER(field_rtri_result) = 'LONG-TERM';

UPDATE 
  base.fact_hts_emr
SET
  field_rtri_result = 'Recent' 
WHERE 
  UPPER(field_rtri_result) = 'RECENT';

UPDATE 
  base.fact_hts_emr
SET
  field_rtri_result = 'Invalid' 
WHERE 
  UPPER(field_rtri_result) = 'INVALID'

UPDATE 
  base.fact_hts_emr
SET
  field_rtri_result = 'Negative'
WHERE 
  UPPER(field_rtri_result) = 'NEGATIVE';

-- $END
   