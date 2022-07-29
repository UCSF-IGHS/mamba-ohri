-- A Temporary Table storing data for for obs computations to be made

DELIMITER //

DROP PROCEDURE IF EXISTS sp_compute_obs_queue_create;

CREATE PROCEDURE sp_compute_obs_queue_create()
BEGIN

    CREATE TABLE mamba_computed_obs_queue
    (
        id                     INT PRIMARY KEY AUTO_INCREMENT,
        patient_id             INT          NOT NULL,               -- id of patient intercepted at encounter/obs creation
        concept_id             INT          NOT NULL,               -- id of the concept intercepted at encounter/obs creation
        encounter_id           INT          NOT NULL,               -- id of encounter where computed obs affecting observation was intercepted
        compute_procedure_name NVARCHAR(50) NOT NULL,               -- Name of the stored procedure to compute this 'computed obs'
        date_created           DATETIME     NOT NULL DEFAULT now(), -- Datetime time record is inserted
        computed               TINYINT(1)   NOT NULL DEFAULT 0      -- If this record has been processed or Not
    );

    CREATE INDEX idx_patient_id
        ON mamba_computed_obs_queue (patient_id);

    CREATE INDEX idx_concept_id
        ON mamba_computed_obs_queue (concept_id);

    CREATE INDEX idx_encounter_id
        ON mamba_computed_obs_queue (encounter_id);

END;
//

DELIMITER ;