USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.dim_uvri_client;

-- $BEGIN

INSERT INTO base.dim_uvri_client (
    uvri_client_id,
    sex,
    hts_number_uvri,
	lab_number
)
SELECT 
    NEWID() AS client_id,
    Sex AS sex,
    FNO AS hts_number_uvri,
	LabNo
FROM 
    [external].recency_uvri_results u;								


-- $END