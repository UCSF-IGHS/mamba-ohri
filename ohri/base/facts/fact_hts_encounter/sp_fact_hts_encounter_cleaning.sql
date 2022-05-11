USE analysis;

-- $BEGIN

-- Update with 1/0 values
SET @column_labels = (
    SELECT GROUP_CONCAT(column_label SEPARATOR ', ') AS 'column_label'
    FROM mamba_dim_concept_metadata
    WHERE column_label in (
                            'key_pop_migrant_worker',
                            'key_pop_uniformed_forces',
                            'key_pop_transgender',
                            'key_pop_AGYW',
                            'key_pop_fisher_folk',
                            'key_pop_prisoners',
                            'key_pop_refugees',
                            'key_pop_msm',
                            'key_pop_fsw',
                            'key_pop_truck_driver',
                            'key_pop_pwd',
                            'key_pop_pwid',
                            'tb_symptoms_fever',
                            'tb_symptoms_cough',
                            'tb_symptoms_hemoptysis',
                            'tb_symptoms_nightsweats',
                            'sti_symptoms_female_genitalulcers',
                            'sti_symptoms_genitalsores',
                            'sti_symptoms_lower_abdominalpain',
                            'sti_symptoms_scrotalmass',
                            'sti_symptoms_male_genitalulcers',
                            'sti_symptoms_urethral_discharge',
                            'sti_symptomsVaginal_discharge',
                            'client_linked_care',
                            'referred_prevention_services',
                            'referred_srh_services',
                            'referred_clinical_services',
                            'referred_support_services',
                            'referred_preexposure_services',
                            'referred_postexposure_services',
                            'referred_vmmc_services',
                            'referred_harmreduction_services',
                            'referred_behavioural_services',
                            'referred_postgbv_services',
                            'referred_prevention_info_services',
                            'referred_other_prevention_services',
                            'referred_hiv_partner_kpcontacts_testing',
                            'referred_hiv_partner_testing',
                            'referred_sti_testing_tx',
                            'referred_analcancer_screening',
                            'referred_cacx_screening_tx',
                            'referred_pregnancy_check',
                            'referred_contraception_fp',
                            'referred_srh_other',
                            'referred_tb_program',
                            'referred_ipt_rogram',
                            'referred_ctx_services',
                            'referred_vaccinations_services',
                            'referred_other_clinical_services',
                            'referred_psychosocial_support',
                            'referred_mentalhealth_support',
                            'referred_violence_support',
                            'referred_legal_support',
                            'referred_disclosure_support',
                            'referred_other_support'
        ));

CALL sp_multiselect_values_update('flat_encounter_hts', @column_labels, '1', '0');

-- $END