USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.fact_cqi_action_plan;

-- $BEGIN

DECLARE @threshold_score INT;
SET @threshold_score = 80;

-- STUDY STAFF

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.study_staff_score AS category_score,
    b.study_staff_gap AS gap,
    b.study_staff_root_cause AS root_cause,
    b.study_staff_root_cause_coded AS root_cause_code,
    b.study_staff_intervention AS intervention,
    b.study_staff_intervention_coded AS intervention_code,
    b.study_staff_due_date as due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = study_staff_due_date) AS due_date_id,
    b.study_staff_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Study Staff') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.study_staff_filter = 'Yes'
    OR
    b.study_staff_score < @threshold_score;

-- PROCEDURES

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.procedures_score AS category_score,
    b.procedures_gap AS gap,
    b.procedures_root_cause AS root_cause,
    b.procedures_root_cause_coded AS root_cause_code,
    b.procedures_intervention AS intervention,
    b.procedures_intervention_coded AS intervention_code,
    b.procedures_due_date AS due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = procedures_due_date) AS due_date_id,
    b.procedures_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Procedures') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans b
WHERE
    b.procedures_filter = 'Yes'
    OR
    b.procedures_score < @threshold_score;

-- SOURCE DATA

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.source_data_score AS category_score,
    b.source_data_gap AS gap,
    b.source_data_root_cause AS root_cause,
    b.source_data_root_cause_coded AS root_cause_code,
    b.source_data_intervention AS intervention,
    b.source_data_intervention_coded AS intervention_code,
    b.source_data_due_date AS due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = source_data_due_date) AS due_date_id,
    b.source_data_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Source Data') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans b
WHERE
    b.source_data_filter = 'Yes'
    OR
    b.source_data_score < @threshold_score;

-- SITE SUPPLIES

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.site_supplies_score AS category_score,
    b.site_supplies_gap AS gap,
    b.site_supplies_root_cause AS root_cause,
    b.site_supplies_root_cause_coded AS root_cause_code,
    b.site_supplies_intervention AS intervention,
    b.site_supplies_intervention_coded AS intervention_code,
    b.site_supplies_due_date AS due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = site_supplies_due_date) AS due_date_id,
    b.source_data_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Site Supplies') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans b
WHERE
    b.site_supplies_filter = 'Yes'
    OR
    b.site_supplies_score < @threshold_score;

-- PHYSICAL FACILITY

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.physical_facility_score AS category_score,
    b.physical_facility_gap AS gap,
    b.physical_facility_root_cause AS root_cause,
    b.physical_facility_root_cause_coded AS root_cause_code,
    b.physical_facility_intervention AS intervention,
    b.physical_facility_intervention_coded AS intervention_code,
    b.physical_facility_due_date AS due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = physical_facility_due_date) AS due_date_id,
    b.physical_facility_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Physical Facility') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans b
WHERE
    b.physical_facility_filter = 'Yes'
    OR
    b.physical_facility_score < @threshold_score;

-- PARTICIPANT RECRUITMENT

INSERT INTO
    base.fact_cqi_action_plan(
    cqi_action_plan_id,
    category_score,
    gap,
    root_cause,
    root_cause_code,
    intervention,
    intervention_code,
    due_date,
    due_date_id,
    person_responsible,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_id,
    b.participant_recruitment_score AS category_score,
    b.participant_recruitment_gap AS gap,
    b.participant_recruitment_root_cause AS root_cause,
    b.participant_recruitment_root_cause_coded AS root_cause_code,
    b.participant_recruitment_intervention AS intervention,
    b.participant_recruitment_intervention_coded AS intervention_code,
    b.participant_recruitment_due_date AS due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = participant_recruitment_due_date) AS due_date_id,
    b.participant_recruitment_responsible AS person_responsible,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Recruitment & Follow-Up') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans b
WHERE
    b.participant_recruitment_filter = 'Yes'
    OR
    b.participant_recruitment_score < @threshold_score;

-- $END

GO

SELECT  * 
FROM 
base.fact_cqi_action_plan;
