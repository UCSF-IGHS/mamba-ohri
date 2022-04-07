USE analysis;

DROP TABLE IF EXISTS covid_fact_encounter;

-- $BEGIN
create table if not exists covid_fact_encounter (
    encounter_id                      int  null,
    client_id                         int  null,
    covid_test                        nvarchar(255) null,
    order_date                        date null,
    result_date                       date null,
    date_assessment                   date null,
    assessment_presentation           nvarchar(255) null,
    assessment_contact_case           int null,
    assessment_entry_country          int null,
    assessment_travel_out_country     int null,
    assessment_follow_up              int null,
    assessment_voluntary              int null,
    assessment_quarantine             int null,
    assessment_symptomatic            int null,
    assessment_surveillance           int null,
    assessment_health_worker          int null,
    assessment_frontline_worker       int null,
    assessment_rdt_confirmatory       int null,
    assessment_post_mortem            int null,
    assessment_other                  int null,
    date_onset_symptoms               date null,
    symptom_cough                     int null,
    symptom_headache                  int null,
    symptom_red_eyes                  int null,
    symptom_sneezing                  int null,
    symptom_diarrhoea                 int null,
    symptom_sore_throat               int null,
    symptom_tiredness                 int null,
    symptom_chest_pain                int null,
    symptom_joint_pain                int null,
    symptom_loss_smell                int null,
    symptom_loss_taste                int null,
    symptom_runny_nose                int null,
    symptom_fever_chills              int null,
    symptom_muscular_pain             int null,
    symptom_general_weakness          int null,
    symptom_shortness_breath          int null,
    symptom_nausea_vomiting           int null,
    symptom_abdominal_pain            int null,
    symptom_irritability_confusion    int null,
    symptom_disturbance_consciousness int null,
    symptom_other                     int null,
    comorbidity_present               int null,
    comorbidity_tb                    int null,
    comorbidity_liver                 int null,
    comorbidity_renal                 int null,
    comorbidity_diabetes              int null,
    comorbidity_hiv_aids              int null,
    comorbidity_malignancy            int null,
    comorbidity_chronic_lung          int null,
    comorbidity_hypertension          int null,
    comorbidity_former_smoker         int null,
    comorbidity_cardiovascular        int null,
    comorbidity_current_smoker        int null,
    comorbidity_immunodeficiency      int null,
    comorbidity_chronic_neurological  int null,
    comorbidity_other                 int null,
    diagnostic_pcr_test               nvarchar(255) null,
    diagnostic_pcr_result             nvarchar(255) null,
    rapid_antigen_test                nvarchar(255) null,
    rapid_antigen_result              nvarchar(255) null,
    long_covid_description            nvarchar(255) null,
    patient_outcome                   nvarchar(255) null,
    date_recovered                    date null,
    date_died                         date null
);

-- $END
