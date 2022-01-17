USE recency_uganda_prod_analysis_test

GO


 
CREATE OR ALTER VIEW base.vw_cqi_action_plans_history AS 

-- $BEGIN

WITH
ap_visit_calc_cte

AS

(SELECT
	uri
	, convert(varchar, visit_date, 106) as form_date
	, site
	, entry_point
	, CONCAT(site, entry_point) AS action_plan_key
	, convert(varchar, participant_recruitment_due_date, 106) AS participant_recruitment_due_date
	, participant_recruitment_gap
	, participant_recruitment_intervention
	, participant_recruitment_intervention_coded
	, participant_recruitment_responsible
	, participant_recruitment_root_cause
	, participant_recruitment_root_cause_coded
	, participant_recruitment_score
	, convert(varchar, physical_facility_due_date, 106) AS physical_facility_due_date
	, physical_facility_gap
	, physical_facility_intervention
	, physical_facility_intervention_coded
	, physical_facility_responsible
	, physical_facility_root_cause
	, physical_facility_root_cause_coded
	, physical_facility_score
	, convert(varchar, procedures_due_date, 106) AS procedures_due_date
	, procedures_gap
	, procedures_intervention
	, procedures_intervention_coded
	, procedures_responsible
	, procedures_root_cause
	, procedures_root_cause_coded
	, procedures_score
	, convert(varchar, site_supplies_due_date, 106) AS site_supplies_due_date
	, site_supplies_gap
	, site_supplies_intervention
	, site_supplies_intervention_coded
	, site_supplies_responsible
	, site_supplies_root_cause
	, site_supplies_root_cause_coded
	, site_supplies_score
	, convert(varchar, source_data_due_date, 106) AS source_data_due_date
	, source_data_gap
	, source_data_intervention
	, source_data_intervention_coded
	, source_data_responsible
	, source_data_root_cause
	, source_data_root_cause_coded
	, source_data_score
	, convert(varchar, study_staff_due_date, 106) AS study_staff_due_date
	, study_staff_gap
	, study_staff_intervention
	, study_staff_intervention_coded
	, study_staff_responsible
	, study_staff_root_cause
	, study_staff_root_cause_coded
	, study_staff_score
	, ROW_NUMBER () OVER (PARTITION BY site, entry_point ORDER BY visit_date DESC) as ap_visit_number
	FROM
	base.vw_odk_form_cqi_action_plans
)

SELECT *
FROM
ap_visit_calc_cte
WHERE ap_visit_number = 1

GO

-- $END

SELECT * 
FROM base.vw_cqi_action_plans_history;