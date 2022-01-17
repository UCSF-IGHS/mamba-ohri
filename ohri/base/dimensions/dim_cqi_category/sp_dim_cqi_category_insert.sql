USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE [base].dim_cqi_category;

-- $BEGIN

INSERT INTO [base].dim_cqi_category
(
    cqi_category_id,
    code,
    name
)
SELECT 
    NEWID() AS  cqi_category_id,
    indicator_number AS code,
    category AS name
FROM
    [external].form_cqi_checklist_metadata
WHERE 
    indicator_number IN (100,200,300,400,500,600)

-- $END

SELECT 
    *
FROM 
    [base].dim_cqi_category;