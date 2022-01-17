USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

-- VISIT NUMBER 
WITH
visit_number_calc_cte
(
    __uri
    ,__facility_dhis2_uuid
    ,__assessment_point
    ,__visit_date
    ,__visit_number
)
AS
(
    SELECT
        uri,
        facility_id,
        assessment_point,
        visit_date,
        ROW_NUMBER() OVER(PARTITION BY fca.facility_id, fca.assessment_point ORDER BY fca.visit_date) as visit_number
    FROM
        base.fact_cqi_assessment_merged fca
)
UPDATE
    base.fact_cqi_assessment_merged
SET
    visit_number = cte.__visit_number
FROM
    visit_number_calc_cte cte
    INNER JOIN base.fact_cqi_assessment_merged cqi ON (cqi.uri = cte.__uri);

-- REVERSED VISIT_NUMBER
WITH
visit_number_calc_cte
(
    __uri
    ,__facility_dhis2_uuid
    ,__assessment_point
    ,__visit_date
    ,__visit_number
)
AS
(
    SELECT
        uri,
        facility_id,
        assessment_point,
        visit_date,
        ROW_NUMBER() OVER(PARTITION BY fca.facility_id, fca.assessment_point ORDER BY fca.visit_date DESC) as visit_number
    FROM
        base.fact_cqi_assessment_merged fca
)
UPDATE
    base.fact_cqi_assessment_merged
SET
    reversed_visit_number = (cte.__visit_number - 1) * -1
FROM
    visit_number_calc_cte cte
    INNER JOIN base.fact_cqi_assessment_merged cqi ON (cqi.uri = cte.__uri);

-- CURRENT VISIT
UPDATE 
    base.fact_cqi_assessment_merged
SET
    is_latest_visit = CASE WHEN reversed_visit_number = 0 THEN 1 ELSE 0 END;

-- $END