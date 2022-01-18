USE recency_uganda_prod_analysis_test
GO

TRUNCATE TABLE [base].[fact_cqi_shortened_assessment];

-- $BEGIN

INSERT INTO [base].[fact_cqi_shortened_assessment] (
	cqi_shortened_assessment_id,
	form_version ,
	uri ,
	form_start_date_time ,
	form_end_date_time ,
	form_date ,
	visit_date ,
	region ,
	district ,
	visit_number,
	reversed_visit_number,
	is_latest_visit ,
	cx_study_staff_score ,
	ss_prop_of_trained_hts_providers ,
	ss_prop_of_trained_hts_providers_available_during_visit ,
	ss_prop_of_hts_providers_trained_on_hiv_rapid_testing,
	cx_procedures_score ,
	cx_source_data_score ,
	sd_prop_of_complete_records_in_logbook ,
	sd_prop_of_complete_records_with_kit_details ,
	sd_prop_of_shipment_forms_completely_filled ,
	cx_physical_facility_score ,
	cx_participant_recruitment_score ,
	prf_prop_of_enrolled_clients_in_rtri ,
	prf_prop_of_enrolled_clients_in_rtri_with_consent_doc ,
	cx_site_supplies_score ,
	assessment_point ,
	assessment_point_other ,
	review_period_start ,
	review_period_end ,
	visitor_name ,
	visitor_name_other ,
	ss_total_hts_providers ,
	ss_number_of_hts_providers_trained,
	ss_number_of_hts_providers_trained_by_cme,
	ss_any_recency_trained_staff_changes_since_training,
	ss_any_recency_trained_staff_changes_since_training_comment,
	procedures_qc_for_positive_and_negative_routinely_used,
	procedures_date_of_qc,
	procedures_kit_lot_number,
	prf_total_clients_eligible,
	prf_total_clients_enrolled_for_rtri,
	prf_total_clients_ineligible,
	prf_total_15_and_above_tested_recent,
	prf_total_15_and_above_tested_long_term,
	prf_prop_clients_tested_recent ,
	prf_prop_clients_tested_long_term ,
	site_supplies_samples_shipped,
	site_supplies_all_rtri_supplies_available,
	site_supplies_all_rtri_supplies_available_comment ,
	facility_id 
)
SELECT
	NEWID(),
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
    ,[ss_number_of_hts_providers_trained_by_cme]
    ,CASE
		[ss_any_recency_trained_staff_changes_since_training]
		WHEN 'yes' THEN 0
		WHEN 'no' THEN 1
		ELSE NULL
	END AS [ss_any_recency_trained_staff_changes_since_training]
    ,[ss_any_recency_trained_staff_changes_since_training_comment]
    ,CASE
		[procedures_qc_for_positive_and_negative_routinely_used]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [procedures_qc_for_positive_and_negative_routinely_used]
    ,[procedures_date_of_qc]
    ,[procedures_kit_lot_number]
    ,[prf_total_clients_eligible]
    ,[prf_total_clients_enrolled_for_rtri]
    ,[prf_total_clients_ineligible]
    ,[prf_total_15_and_above_tested_recent]
    ,[prf_total_15_and_above_tested_long_term]
	,NULL AS prf_prop_clients_tested_recent
	,NULL AS prf_prop_clients_tested_long_term
    ,[site_supplies_samples_shipped]
    ,CASE
		[site_supplies_all_rtri_supplies_available]
		WHEN 'yes' THEN 1
		WHEN 'no' THEN 0
		ELSE NULL
	END AS [site_supplies_all_rtri_supplies_available]
    ,[site_supplies_all_rtri_supplies_available_comment]
    ,f.facility_id

FROM
	base.vw_odk_form_cqi_shortened_checklist vw
LEFT JOIN
	base.dim_facility f
	ON
		f.dhis2_uid = vw.facility_dhis2_uuid
		
-- $END

SELECT TOP 100 * FROM [base].[fact_cqi_shortened_assessment];