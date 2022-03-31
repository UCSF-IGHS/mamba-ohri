USE analysis;

-- $BEGIN

-- Update multi-select value with 1/0
SET @column_labels = (
    SELECT GROUP_CONCAT(column_label SEPARATOR ', ') AS 'column_label'
    FROM mamba_dim_concept_metadata
    WHERE column_label IN (
       'assessment_contact_case',
       'assessment_entry_country',
       'assessment_follow_up',
       'assessment_health_worker',
       'assessment_frontline_worker',
       'assessment_post_mortem',
       'assessment_quarantine',
       'assessment_rdt_confirmatory',
       'assessment_surveillance',
       'assessment_symptomatic',
       'assessment_travel_out_country',
       'assessment_voluntary',
       'assessment_other',
       'symptom_abdominal_pain',
       'symptom_chest_pain',
       'symptom_cough',
       'symptom_diarrhoea',
       'symptom_disturbance_consciousness',
       'symptom_general_weakness',
       'symptom_headache',
       'symptom_fever_chills',
       'symptom_irritability_confusion',
       'symptom_joint_pain',
       'symptom_loss_smell',
       'symptom_loss_taste',
       'symptom_muscular_pain',
       'symptom_nausea_vomiting',
       'symptom_red_eyes',
       'symptom_runny_nose',
       'symptom_shortness_breath',
       'symptom_sneezing',
       'symptom_sore_throat',
       'symptom_tiredness',
       'symptom_other',
       'comorbidity_cardiovascular',
       'comorbidity_chronic_lung',
       'comorbidity_chronic_neurological',
       'comorbidity_current_smoker',
       'comorbidity_diabetes',
       'comorbidity_hiv_aids',
       'comorbidity_former_smoker',
       'comorbidity_hypertension',
       'comorbidity_immunodeficiency',
       'comorbidity_liver',
       'comorbidity_malignancy',
       'comorbidity_renal',
       'comorbidity_tb',
       'comorbidity_other'
    ));

CALL sp_update_column_values('encounter_covid', @column_labels, '1', '0');

-- $END