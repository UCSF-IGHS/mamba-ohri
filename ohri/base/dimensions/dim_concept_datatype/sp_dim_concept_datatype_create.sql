USE analysis;
GO

DROP TABLE IF EXISTS  base.concept_datatype;

-- $BEGIN

CREATE TABLE base.concept_datatype (
    concept_datatype_id int NOT NULL AUTO_INCREMENT,
    external_datatype_id int,
    datatype NVARCHAR(255) NULL,
    PRIMARY KEY (concept_datatype_id)
);

-- $END
