USE recency_uganda_prod_analysis_test;
GO

CREATE OR ALTER VIEW base.vw_odk_form_cqi_shortened_checklist AS 

-- $BEGIN

SELECT
    'v1' AS form_version,
    [meta_instanceID] AS uri,
    [start] AS form_start_date_time,
    [end] AS form_end_date_time,
    [visit_date] AS form_date,
    [review_group_visit_date_2]  AS visit_date,
    [region],
    [district],
    [site] AS facility_dhis2_uuid,
    [entry_point] AS assessment_point,
    [entry_point_other] AS assessment_point_other,
    [review_group_review_period_start] AS review_period_start,
    [review_group_review_period_end] AS review_period_end,
    [review_group_visitor_name] AS visitor_name,
    [review_group_visitor_name_other] AS visitor_name_other,
    [hts_provider_group_number_provider_available_at_point] AS ss_total_hts_providers,
    [hts_provider_trained_group_number_provider_tot_trained] AS ss_number_of_hts_providers_trained,
    [number_hts_provider_not_tot_trained] AS ss_number_of_hts_providers_trained_by_cme,
    [staff_changes_group_provider_obs_staffing_changes] AS ss_any_recency_trained_staff_changes_since_training,
    [staff_changes_group_provider_obs_staffing_changes_comment] AS ss_any_recency_trained_staff_changes_since_training_comment,
    [procedures_obs_qc_performed] AS procedures_qc_for_positive_and_negative_routinely_used,
    [date_last_QC_performed] AS procedures_date_of_qc,
    [kit_lot_mumber] AS procedures_kit_lot_number,
    [recent_eligible_group_recent_eligible] AS prf_total_clients_eligible,
    [participant_recruitment_recent_enrolled] AS prf_total_clients_enrolled_for_rtri,
    [participant_recruitment_recent_ineligible] AS prf_total_clients_ineligible,
    [participant_recruitment_recent_tested_pos] AS prf_total_15_and_above_tested_recent,
    [participant_recruitment_long_term_tested] AS prf_total_15_and_above_tested_long_term,
    [specimen_shipment_group_specimen_shipment] AS site_supplies_samples_shipped,
    [available_required_supplies] AS site_supplies_all_rtri_supplies_available,
    [available_required_supplies_no] AS site_supplies_all_rtri_supplies_available_comment,
    [procedures_obs_data_electronic]

FROM
  [external].shortened_recency_cqi_checklist

  UNION

SELECT
    'v2' AS form_version,
    [meta_instance_id] AS uri,
    [start] AS form_start_date_time,
    [end] AS form_end_date_time,
    [visit_date] AS form_date,
    [review_group_visit_date_2]  AS visit_date,
    [region],
    [district],
    [site] AS facility_dhis2_uuid,
    [entry_point] AS assessment_point,
    [entry_point_other] AS assessment_point_other,
    [review_group_review_period_start] AS review_period_start,
    [review_group_review_period_end] AS review_period_end,
    [review_group_visitor_name] AS visitor_name,
    [review_group_visitor_name_other] AS visitor_name_other,
    [hts_provider_group_number_provider_available_at_point] AS ss_total_hts_providers,
    [hts_provider_trained_group_number_provider_tot_trained] AS ss_number_of_hts_providers_trained,
    [hts_provdr_not_tot_traind_grup_number_provider_not_tot_trained] AS ss_number_of_hts_providers_trained_by_cme,
    [staff_changes_group_provider_obs_staffing_changes] AS ss_any_recency_trained_staff_changes_since_training,
    [staff_changes_group_provider_obs_staffing_changes_comment] AS ss_any_recency_trained_staff_changes_since_training_comment,
    [procedures_obs_qc_performed] AS procedures_qc_for_positive_and_negative_routinely_used,
    [date_last_QC_performed] AS procedures_date_of_qc,
    [kit_lot_mumber] AS procedures_kit_lot_number,
    [recent_eligible_group_recent_eligible] AS prf_total_clients_eligible,
    [participant_recruitment_recent_enrolled] AS prf_total_clients_enrolled_for_rtri,
    [participant_recruitment_recent_ineligible] AS prf_total_clients_ineligible,
    [participant_recruitment_recent_tested_pos] AS prf_total_15_and_above_tested_recent,
    [participant_recruitment_long_term_tested] AS prf_total_15_and_above_tested_long_term,
    [specimen_shipment_group_specimen_shipment] AS site_supplies_samples_shipped,
    [available_required_supplies] AS site_supplies_all_rtri_supplies_available,
    [available_required_supplies_no] AS site_supplies_all_rtri_supplies_available_comment,
    [procedures_obs_data_electronic]

FROM
    [recency_uganda_prod_source].[uganda].[rec1107_core]

-- $END

--- Test view creation
GO
SELECT * FROM 
[base].vw_odk_form_cqi_shortened_checklist;

SELECT COUNT(*) count_shortened_checklist_records FROM [base].vw_odk_form_cqi_shortened_checklist;