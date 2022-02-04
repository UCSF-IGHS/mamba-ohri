USE analysis;

-- $BEGIN

-- SELECT 'Starting execution of Base Objects';

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

-- Base Objects
-- SELECT 'Executing sp_mamba_z_tables';
CALL sp_mamba_z_tables;

-- $END