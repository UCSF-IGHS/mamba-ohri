-- A Temporary Table storing data for for obs computations to be made

DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_metadata_create;

CREATE PROCEDURE sp_compute_obs_metadata_create()
BEGIN

    CREATE TABLE mamba_obs_compute_metadata
    (
        id                             INT PRIMARY KEY AUTO_INCREMENT,
        computed_obs_encounter_type_id INT           NULL,
        obs_encounter_type_id          INT           NULL,
        concept_id                     INT           NOT NULL,
        compute_procedure_name         NVARCHAR(50)  NULL,
        concept_label                  NVARCHAR(50)  NOT NULL UNIQUE,
        concept_description            NVARCHAR(255) NULL,

        constraint sp_concept_label
            unique (compute_procedure_name, concept_label)
    );

    CREATE INDEX idx_concept_id
        ON mamba_obs_compute_metadata (concept_id);

    CREATE INDEX idx_obs_encounter_type_id
        ON mamba_obs_compute_metadata (obs_encounter_type_id);

    CREATE INDEX idx_computed_obs_encounter_type_id
        ON mamba_obs_compute_metadata (computed_obs_encounter_type_id);

    CREATE INDEX idx_sp_concept_label
        ON mamba_obs_compute_metadata (compute_procedure_name, concept_label);
END;
//

DELIMITER ;