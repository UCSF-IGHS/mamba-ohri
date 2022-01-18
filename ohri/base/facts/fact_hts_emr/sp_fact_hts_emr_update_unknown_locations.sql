USE recency_uganda_prod_analysis_test;
GO


-- $BEGIN

UPDATE 
    base.fact_hts_emr
SET 
    location_id = (
        SELECT
            location_id 
        FROM 
            base.dim_location 
        WHERE  
            [name] = 'Unknown'
        AND 
            [type] = 'Subcounty'
    )
WHERE 
    location_id IS NULL;

-- $END