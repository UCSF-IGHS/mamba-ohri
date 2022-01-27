USE analysis;

DROP TABLE IF EXISTS  base_dim_concept_metadata;

-- $BEGIN

CREATE TABLE base_dim_concept_metadata (
    concept_metadata_id int NOT NULL AUTO_INCREMENT,
    column_number int,
    column_label NVARCHAR(50) NOT NULL,
    concept_uuid CHAR(38) NOT NULL,
    concept_data_type NVARCHAR(255) NULL,
    PRIMARY KEY (concept_metadata_id)
);

-- $END
