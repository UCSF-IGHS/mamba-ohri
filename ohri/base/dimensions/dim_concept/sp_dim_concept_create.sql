USE analysis;
GO

DROP TABLE IF EXISTS  base.concept;

-- $BEGIN

CREATE TABLE base.concept (
    concept_id int NOT NULL AUTO_INCREMENT,
    uuid CHAR(38) NOT NULL,
    external_concept_id int,
    external_datatype_id int, -- make it a FK
    datatype NVARCHAR(255) NULL,
    PRIMARY KEY (concept_id)
);

-- $END
