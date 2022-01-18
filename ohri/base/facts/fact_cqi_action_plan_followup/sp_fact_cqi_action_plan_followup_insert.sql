USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.fact_cqi_action_plan_followup;

-- $BEGIN

-- STUDY STAFF

INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.study_staff_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.study_staff_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.study_staff_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.study_staff_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = b.study_staff_new_due_date) AS new_due_date_id,
    b.study_staff_progress_to_date AS progress_to_date,
    b.study_staff_challenges AS challenges,
    b.study_staff_what_was_done AS action_taken,
    b.study_staff_outcome AS outcome,
    b.study_staff_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Study Staff') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.study_staff_score_fu IS NOT NULL
AND
    b.study_staff_intervention_status IS NOT NULL;

-- PROCEDURES

INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.procedures_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.procedures_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.procedures_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.procedures_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = b.procedures_new_due_date) AS new_due_date_id,
    b.procedures_progress_to_date AS progress_to_date,
    b.procedures_challenges AS challenges,
    b.procedures_what_was_done AS action_taken,
    b.procedures_outcome AS outcome,
    b.procedures_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Procedures') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.procedures_score_fu IS NOT NULL
AND
    b.procedures_intervention_status IS NOT NULL;

-- SOURCE DATA
    
INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.source_data_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.source_data_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.source_data_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.source_data_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = source_data_new_due_date) AS new_due_date_id,
    b.source_data_progress_to_date AS progress_to_date,
    b.source_data_challenges AS challenges,
    b.source_data_what_was_done AS action_taken,
    b.source_data_outcome AS outcome,
    b.source_data_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Source Data') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri)
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.source_data_score_fu IS NOT NULL
AND
    b.source_data_intervention_status IS NOT NULL;

-- PHYSICAL FACILITY
    
INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.physical_facility_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.physical_facility_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.physical_facility_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.physical_facility_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = physical_facility_new_due_date) AS new_due_date_id,
    b.physical_facility_progress_to_date AS progress_to_date,
    b.physical_facility_challenges AS challenges,
    b.physical_facility_what_was_done AS action_taken,
    b.physical_facility_outcome AS outcome,
    b.physical_facility_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Physical Facility') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.physical_facility_score_fu IS NOT NULL
AND
    b.physical_facility_intervention_status IS NOT NULL;

-- PARTICIPANT RECRUITMENT

INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.participant_recruitment_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.participant_recruitment_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.participant_recruitment_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.participant_recruitment_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = participant_recruitment_new_due_date) AS new_due_date_id,
    b.participant_recruitment_progress_to_date AS progress_to_date,
    b.participant_recruitment_challenges AS challenges,
    b.participant_recruitment_what_was_done AS action_taken,
    b.participant_recruitment_outcome AS outcome,
    b.participant_recruitment_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Recruitment & Follow-Up') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.participant_recruitment_score_fu IS NOT NULL
AND
    b.participant_recruitment_intervention_status IS NOT NULL;

-- SITE SUPPLIES

INSERT INTO
    base.fact_cqi_action_plan_followup(
    cqi_action_plan_followup_id,
    due_date_changed,
    is_due_date_changed,
    new_due_date,
    new_due_date_id,
    progress_to_date,
    challenges,
    action_taken,
    outcome,
    abandon_reason,
    cqi_category_id,
    cqi_action_plan_assessment_id
    )
SELECT
    NEWID() AS cqi_action_plan_followup_id,
    b.site_supplies_fu_due_date_changed AS due_date_changed,
    (
    CASE
        WHEN b.site_supplies_fu_due_date_changed = 'Yes' THEN 1
        WHEN b.site_supplies_fu_due_date_changed = 'No' THEN 0
        ELSE NULL
    END
    ),
    b.site_supplies_new_due_date AS new_due_date,
    (SELECT date_id FROM base.dim_date WHERE date_yyyymmdd = site_supplies_new_due_date) AS new_due_date_id,
    b.site_supplies_progress_to_date AS progress_to_date,
    b.site_supplies_challenges AS challenges,
    b.site_supplies_what_was_done AS action_taken,
    b.site_supplies_outcome AS outcome,
    b.site_supplies_abandon_reason AS abandon_reason,
    (SELECT cqi_category_id FROM base.dim_cqi_category WHERE name = 'Site Supplies') AS cqi_category_id,
    (SELECT cqi_action_plan_assessment_id FROM base.dim_cqi_action_plan_assessment a WHERE a._uri = b.uri )
FROM
    base.vw_odk_form_cqi_action_plans AS b
WHERE
    b.site_supplies_score_fu IS NOT NULL
AND
    b.site_supplies_intervention_status IS NOT NULL;

-- $END

GO

SELECT  * 
FROM 
base.fact_cqi_action_plan_followup;
