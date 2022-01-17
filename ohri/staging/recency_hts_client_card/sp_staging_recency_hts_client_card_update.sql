USE recency_uganda_prod_analysis_test;
GO


-- $BEGIN

--UPDATE the DHIS2 ID for Alive Medical Services Special Clinic

UPDATE 
    staging.recency_hts_client_card
SET
    dhis2_orgunit_uuid = 'PHhcBpjIWvL'
WHERE
    dhis2_orgunit_uuid = 'PHhcBpjlWvL'

-- $END