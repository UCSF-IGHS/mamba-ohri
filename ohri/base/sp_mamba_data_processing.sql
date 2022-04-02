USE analysis;

-- $BEGIN

-- SELECT 'Starting execution of Base Objects';
-- CALL dbo.sp_xf_system_drop_all_objects_in_schema('analysis');
CALL dbo.sp_xf_system_drop_all_tables_in_schema('analysis');
-- CALL dbo.sp_xf_system_drop_all_views_in_schema('analysis');

-- Base dimensions
-- SELECT 'Executing sp_mamba_dim_concept_datatype';
CALL sp_mamba_dim_concept_datatype;

-- SELECT 'Executing sp_mamba_dim_concept_answer';
CALL sp_mamba_dim_concept_answer;

-- SELECT 'Executing sp_mamba_dim_concept_name';
CALL sp_mamba_dim_concept_name;

-- SELECT 'Executing sp_mamba_dim_concept';
CALL sp_mamba_dim_concept;

-- SELECT 'Executing sp_mamba_dim_encounter_type';
CALL sp_mamba_dim_encounter_type;

-- SELECT 'Executing sp_mamba_dim_encounter';
CALL sp_mamba_dim_encounter;

-- SELECT 'Executing sp_mamba_dim_concept_metadata';
CALL sp_mamba_dim_concept_metadata;

-- SELECT 'Executing sp_mamba_dim_client';
CALL sp_mamba_dim_person;

-- SELECT 'Executing sp_mamba_dim_client';
CALL sp_mamba_dim_person_name;

-- SELECT 'Executing sp_mamba_dim_client';
CALL sp_mamba_dim_person_address;

-- SELECT 'Executing sp_dim_client';
CALL sp_dim_client;

-- SELECT 'Executing sp_mamba_z_tables';
CALL sp_mamba_z_tables;

-- SELECT 'Executing generating fact tables';
CALL sp_fact_hts_encounter;
CALL sp_fact_covid_encounter;

-- $END