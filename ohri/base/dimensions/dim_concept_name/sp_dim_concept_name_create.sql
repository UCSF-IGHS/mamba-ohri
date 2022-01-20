USE analysis;
GO

DROP TABLE IF EXISTS  base.concept_name;

-- $BEGIN

CREATE TABLE base.concept_name (
    concept_name_id int NOT NULL AUTO_INCREMENT,
    external_concept_id int,
    concept_name NVARCHAR(255) NULL,
    PRIMARY KEY (concept_name_id)
);

-- $END
