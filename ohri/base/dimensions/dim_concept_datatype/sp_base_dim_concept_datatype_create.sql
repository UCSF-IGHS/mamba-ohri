USE analysis;

DROP TABLE IF EXISTS base_dim_concept_datatype;

-- $BEGIN

CREATE TABLE base_dim_concept_datatype (
    concept_datatype_id int NOT NULL AUTO_INCREMENT,
    external_datatype_id int,
    datatype_name NVARCHAR(255) NULL,
    PRIMARY KEY (concept_datatype_id)
);

-- $END