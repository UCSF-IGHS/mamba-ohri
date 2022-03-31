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
                           'key_pop_pwid'
        ));

CALL sp_update_column_values('encounter_hts', @column_labels, '1', '0');

-- $END