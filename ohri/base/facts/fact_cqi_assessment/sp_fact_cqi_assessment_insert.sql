USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE base.fact_cqi_assessment;

-- $BEGIN

INSERT INTO
	base.fact_cqi_assessment
SELECT
	NEWID() AS cqi_assessment_id,
	[form_version]
	,[uri]
	,[form_start_date_time]
	,[form_end_date_time]
	,[form_date]
	,[visit_date]
	,vw.[region]
	,vw.[district]
	, NULL AS visit_number
    , NULL AS reversed_visit_number
    , NULL AS is_latest_visit
    , NULL AS cx_study_staff_score
    , NULL AS ss_prop_of_trained_hts_providers
    , NULL AS ss_prop_of_trained_hts_providers_available_during_visit
	, NULL AS ss_prop_of_hts_providers_trained_on_hiv_rapid_testing
    , NULL AS cx_procedures_score
    , NULL AS cx_source_data_score
    , NULL AS sd_prop_of_complete_records_in_logbook
    , NULL AS sd_prop_of_complete_records_with_kit_details
    , NULL AS sd_prop_of_shipment_forms_completely_filled
    , NULL AS cx_physical_facility_score
    , NULL AS cx_participant_recruitment_score
    , NULL AS prf_prop_of_enrolled_clients_in_rtri
    , NULL AS prf_prop_of_enrolled_clients_in_rtri_with_consent_doc 
    , NULL AS cx_site_supplies_score 
	,[assessment_point]
	,[assessment_point_other]
	,[review_period_start]
	,[review_period_end]
	,[visitor_name]
	,[visitor_name_other]
	,[ss_total_hts_providers]
	,[ss_number_of_hts_providers_trained]
	,[ss_hts_providers_trained_comments]
	,[ss_number_of_hts_providers_trained_available]
	,[ss_number_provider_available_at_point]
	,[ss_number_provider_trained_on_routine_hts]
	,[ss_number_of_hts_providers_trained_working]
	,[ss_number_of_hts_providers_trained_by_cme]
	,CASE
		[ss_hts_providers_follow_sops_for_eligibility]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_hts_providers_follow_sops_for_eligibility]
	,[ss_hts_providers_follow_sops_for_eligibilit_comment]
	,CASE
		[ss_hts_providers_follow_sops_for_testing]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_hts_providers_follow_sops_for_testing]
	,[ss_hts_providers_follow_sops_for_testing_comment]
	,CASE
		[ss_hts_providers_interpret_results_accurately]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_hts_providers_interpret_results_accurately]
	,[ss_hts_providers_interpret_results_accurately_comment]
	,CASE
	[ss_all_tests_with_control_and_verification_line_marked_recent]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_all_tests_with_control_and_verification_line_marked_recent]
	,[ss_all_tests_with_control_and_verification_line_marked_recent_comment]
	,CASE
		[ss_all_tests_with_three_lines_marked_long_term]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_all_tests_with_three_lines_marked_long_term]
	,[ss_all_tests_with_three_lines_marked_long_term_comment]
	,CASE
		[ss_all_tests_with_only_control_line_marked_negative]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_all_tests_with_only_control_line_marked_negative]
	,[ss_all_tests_with_only_control_line_marked_negative_comment]
	,CASE
		[ss_all_invalid_tests_interpreted_correctly]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_all_invalid_tests_interpreted_correctly]
	,[ss_all_invalid_tests_interpreted_correctly_comment]
	,CASE
		[ss_docs_showing_all_hts_providers_trained_in_routine_rapid_testing]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_docs_showing_all_hts_providers_trained_in_routine_rapid_testing]
	,[ss_docs_showing_all_hts_providers_trained_in_routine_rapid_testing_comment]
	,CASE
		[ss_docs_showing_all_hts_providers_trained_in_rtri_testing]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_docs_showing_all_hts_providers_trained_in_rtri_testing]
	,[ss_docs_showing_all_hts_providers_trained_in_rtri_testing_comment]
	,CASE
		[ss_hts_performed_in_private_space]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_hts_performed_in_private_space]
	,[ss_hts_performed_in_private_space_comment]
	,CASE
	[ss_any_recency_trained_staff_changes_since_training]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [ss_any_recency_trained_staff_changes_since_training]
	,[ss_any_recency_trained_staff_changes_since_training_comment]
	,[ss_score_denominator]
	,[ss_score]
	,CASE
		[procedures_sop_manual_visible_at_facility_location]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_sop_manual_visible_at_facility_location]
	,[procedures_sop_manual_visible_at_facility_location_comment]
	,CASE
		[procedures_informed_consent_materials_easily_physically_accessible]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_informed_consent_materials_easily_physically_accessible]
	,[procedures_informed_consent_materials_easily_physically_accessible_comment]
	,CASE
		[procedures_rtri_conducted_correctly]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_rtri_conducted_correctly]
	,[procedures_rtri_conducted_correctly_comment]
	,CASE
		[procedures_sample_buffer_tube_labeled_with_client_identifiers]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_sample_buffer_tube_labeled_with_client_identifiers]
	,[procedures_sample_buffer_tube_labeled_with_client_identifiers_comment]
	,CASE
		[procedures_timers_available_and_used_routinely_for_rtri]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_timers_available_and_used_routinely_for_rtri]
	,[procedures_timers_available_and_used_routinely_for_rtri_comment]
	,CASE
		[procedures_sop_followed_for_rtri]  
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_sop_followed_for_rtri]
	,[procedures_sop_followed_for_rtri_comment]
	,CASE
		[procedures_repeat_testing_of_invalid_tests_done]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_repeat_testing_of_invalid_tests_done]
	,[procedures_repeat_testing_of_invalid_tests_done_comment]
	,CASE
		[procedures_specimen_collection_timely]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_specimen_collection_timely]
	,[procedures_specimen_collection_timely_comment]
	,CASE
		[procedures_qc_for_positive_and_negative_routinely_used]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_qc_for_positive_and_negative_routinely_used]
	,[procedures_qc_for_positive_and_negative_routinely_used_comment]
	,CASE
		[procedures_recency_pt_performed_by_hts_providers]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_recency_pt_performed_by_hts_providers]
	,[procedures_recency_pt_performed_by_hts_providers_comment]
	,CASE
		[procedures_samples_prepared_according_to_schedule]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_samples_prepared_according_to_schedule]
	,[procedures_samples_prepared_according_to_schedule_comment]
	,CASE
		[procedures_electronic_data_entry_done_weekly]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_electronic_data_entry_done_weekly]
	,[procedures_electronic_data_entry_done_weekly_comment]
	,CASE
		[procedures_corrective_action_taken_in_sop_failure_taken]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_corrective_action_taken_in_sop_failure_taken]
	,[procedures_corrective_action_taken_in_sop_failure_taken_comment]
	,[procedures_score_denominator]
	,[procedures_score]
	,[sd_number_records_in_logbook]
	,[sd_number_records_in_logbook_comment]
	,[sd_number_records_in_logbook_rtri_complete]
	,[sd_number_records_in_logbook_rtri_complete_comment]
	,[sd_number_records_with_complete_hts_id]
	,[sd_number_records_with_complete_hts_id_comment]
	,[sd_number_records_in_logbook_with_complete_kit_details]
	,[sd_number_records_in_logbook_with_complete_kit_details_comment]
	,[sd_total_specimen_shipment_forms_created]
	,[sd_total_specimen_shipment_forms_created_comment]
	,[sd_total_specimens_in_shipment_forms]
	,[sd_total_specimens_in_shipment_forms_comment]
	,[sd_total_pages_with_client_records]
	,[sd_total_lab_specimen_eligible_for_shipment]
	,[sd_total_specimen_records]
	,[sd_total_specimens_in_shipment_forms_completely_filled]
	,[sd_total_specimens_in_shipment_forms_completely_filled_comment]
	,CASE
		[sd_only_standard_hts_forms_used]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_only_standard_hts_forms_used]
	,[sd_only_standard_hts_forms_used_comment]
	,CASE
		[sd_hts_forms_correctly_filled]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_hts_forms_correctly_filled]
	,[sd_hts_forms_correctly_filled_comment]
	,CASE
		[sd_all_hts_register_demographics_and_rtri_results_correctly_filled]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_all_hts_register_demographics_and_rtri_results_correctly_filled]
	,[sd_all_hts_register_demographics_and_rtri_results_correctly_filled_comment]
	,CASE
		[sd_all_logbooks_correctly_filled_with_kit_details_and_rtri_results]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_all_logbooks_correctly_filled_with_kit_details_and_rtri_results]
	,[sd_all_logbooks_correctly_filled_with_kit_details_and_rtri_results_comment]
	,CASE
		[sd_all_records_in_hts_register_have_hts_history]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_all_records_in_hts_register_have_hts_history]
	,[sd_all_records_in_hts_register_have_hts_history_comment]
	,CASE
		[sd_all_records_in_hts_register_have_final_hts_diagnosis]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [sd_all_records_in_hts_register_have_final_hts_diagnosis]
	,[sd_all_records_in_hts_register_have_final_hts_diagnosis_comment]
	, NULL AS [sd_prop_of_records_complete_with_hts_id]
	, NULL AS [sd_prop_of_samples_shipped_to_hub]
	,[sd_score_denominator]
	,[sd_score]
	,CASE
		[pf_sufficient_lighting_in_testing_area]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [pf_sufficient_lighting_in_testing_area]
	,[pf_sufficient_lighting_in_testing_area_comment]
	,CASE
		[pf_kits_stored_according_to_instructions]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [pf_kits_stored_according_to_instructions]
	,[pf_kits_stored_according_to_instructions_comment]
	,CASE
		[pf_current_and_past_temperature_charts_available]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [pf_current_and_past_temperature_charts_available]
	,[pf_current_and_past_temperature_charts_available_comment]
	,CASE
		[pf_records_stored_in_secure_storage_room]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [pf_records_stored_in_secure_storage_room]
	,[pf_records_stored_in_secure_storage_room_comment]
	,CASE
		[pf_all_electronic_tools_password_protected]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [pf_all_electronic_tools_password_protected]
	,[pf_all_electronic_tools_password_protected_comment]
	,[pf_score_denominator]
	,[pf_score]
	,[prf_total_15_and_above_received_hts]
	,[prf_total_15_and_above_received_hts_comment]
	,[prf_total_clients_eligible]
	,[prf_total_clients_eligible_comment]
	,[prf_total_clients_enrolled_for_rtri]
	,[prf_total_clients_enrolled_for_rtri_comment]
	,[prf_total_clients_ineligible]
	,[prf_total_clients_ineligible_comment]
	,[prf_total_clients_enrolled_for_rtri_with_correct_consent_doc]
	,[prf_total_clients_enrolled_for_rtri_with_correct_consent_doc_comment]
	,[prf_total_15_and_above_tested_recent]
	,[prf_total_15_and_above_tested_recent_comment]
	,[prf_total_15_and_above_tested_long_term]
	,[prf_total_15_and_above_tested_long_term_comment]
	,[prf_total_clients_enrolled_for_rtri_repoering_adverse_events]
	,[prf_total_clients_enrolled_for_rtri_repoering_adverse_events_comment]
	,[prf_score_denominator]
	,[prf_score]
	,[site_supplies_asante_test_kits_available]
	,[site_supplies_asante_test_kits_available_comment]
	,[site_supplies_specimen_shipment_forms_available]
	,[site_supplies_specimen_shipment_forms_available_comment]
	,[site_supplies_samples_shipped]
	,[site_supplies_samples_shipped_comment]
	,[site_supplies_samples_shipped_rejected]
	,[site_supplies_samples_shipped_rejected_comment]
	,[site_supplies_logbooks_available]
	,[site_supplies_logbooks_available_comment]
	,CASE
		[site_supplies_all_rtri_supplies_available]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [site_supplies_all_rtri_supplies_available]
	,[site_supplies_all_rtri_supplies_available_comment]
	,CASE
		[site_supplies_asante_test_kits_available_and_stocked]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [site_supplies_asante_test_kits_available_and_stocked]
	,[site_supplies_asante_test_kits_available_and_stocked_comment]
	,CASE
		[site_supplies_ppt_edta_tubes_available]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [site_supplies_ppt_edta_tubes_available]
	,[site_supplies_ppt_edta_tubes_available_comment]
	,CASE
		[site_supplies_rtri_supplies_used_before_expiry]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [site_supplies_rtri_supplies_used_before_expiry]
	,[site_supplies_rtri_supplies_used_before_expiry_comment]
	,[site_supplies_score_denominator]
	,[site_supplies_score]
	,f.facility_id
FROM
	base.vw_odk_form_cqi_checklist vw
LEFT JOIN
	base.dim_facility f
	ON
		f.dhis2_uid = vw.facility_dhis2_uuid

-- $END

SELECT TOP 100 * FROM base.fact_cqi_assessment;