USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN


WITH last_sync_dates AS (
    SELECT
        f.NAME AS facility,
        REPLACE(f.DISTRICT,' District','') AS district,
        h.dhis2_orgunit_uuid AS dhis2_uid,
        MAX(h.uploaded_on) last_uploaded_on    
    FROM
        [external].recency_hts_client_card h 
    INNER JOIN
        base.dim_facility f 
        ON 
            h.dhis2_orgunit_uuid = f.dhis2_uid
    WHERE
        h.uploaded_on IS NOT NULL
    GROUP BY 
        f.NAME,
        district,
        h.dhis2_orgunit_uuid
)
UPDATE
    base.dim_facility
SET
    last_uploaded_on = last_sync_dates.last_uploaded_on
FROM
    last_sync_dates 
    INNER JOIN base.dim_facility as f
        ON last_sync_dates.dhis2_uid = f.dhis2_uid
WHERE
    last_sync_dates.last_uploaded_on IS NOT NULL

-- $END
   