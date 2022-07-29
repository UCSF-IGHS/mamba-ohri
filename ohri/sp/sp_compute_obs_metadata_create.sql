-- A Temporary Table storing data for for obs computations to be made

DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_metadata_create;

CREATE PROCEDURE sp_compute_obs_metadata_create()
BEGIN

    CREATE TABLE mamba_obs_compute_metadata
    (
        id                             INT PRIMARY KEY AUTO_INCREMENT,
        computed_obs_encounter_type_id INT          NOT NULL,
        obs_encounter_type_id          INT          NOT NULL, --
        concept_id                     INT          NOT NULL,
        compute_procedure_name         NVARCHAR(50) NOT NULL,
        concept_label                  NVARCHAR(50) NOT NULL,
        concept_description            NVARCHAR(255)
    );

    CREATE INDEX idx_concept_id
        ON mamba_obs_compute_metadata (concept_id);

    CREATE INDEX idx_obs_encounter_type_id
        ON mamba_obs_compute_metadata (obs_encounter_type_id);

    CREATE INDEX idx_computed_obs_encounter_type_id
        ON mamba_obs_compute_metadata (computed_obs_encounter_type_id);

    CREATE INDEX idx_compute_procedure_name
        ON mamba_obs_compute_metadata (compute_procedure_name);

    CREATE INDEX idx_concept_label
        ON mamba_obs_compute_metadata (concept_label);

END;
//

DELIMITER ;