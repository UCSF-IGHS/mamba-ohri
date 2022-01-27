USE analysis;

DROP TABLE IF EXISTS  base_dim_concept_name;

-- $BEGIN

CREATE TABLE base_dim_concept_name (
    concept_name_id int NOT NULL AUTO_INCREMENT,
    external_concept_id int,
    concept_name NVARCHAR(255) NULL,
    PRIMARY KEY (concept_name_id)
);

-- $END
