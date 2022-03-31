USE analysis;

DROP TABLE IF EXISTS mamba_dim_concept_metadata;

-- $BEGIN

CREATE TABLE mamba_dim_concept_metadata
(
    concept_metadata_id INT           NOT NULL AUTO_INCREMENT,
    column_number       INT,
    column_label        NVARCHAR(50)  NOT NULL,
    concept_uuid        CHAR(38)      NOT NULL,
    concept_datatype    NVARCHAR(255) NULL,
    report_name         NVARCHAR(255) NOT NULL,
    output_table_name   NVARCHAR(255) NOT NULL,
    concept_answer_obs  TINYINT(1)    NOT NULL DEFAULT 0,
    PRIMARY KEY (concept_metadata_id)
);

ALTER TABLE `mamba_dim_concept_metadata`
    ADD COLUMN `encounter_type_id` INT NOT NULL AFTER `concept_answer_obs`,
    ADD CONSTRAINT `fk_encounter_type_id`
        FOREIGN KEY (`encounter_type_id`) REFERENCES `mamba_dim_encounter_type` (`encounter_type_id`);

-- $END
