USE analysis;

DROP TABLE IF EXISTS  base_dim_concept;

-- $BEGIN

CREATE TABLE base_dim_concept (
    concept_id int NOT NULL AUTO_INCREMENT,
    uuid CHAR(38) NOT NULL,
    external_concept_id int,
    external_datatype_id int, -- make it a FK
    datatype NVARCHAR(255) NULL,
    PRIMARY KEY (concept_id)
);

-- $END
