USE analysis;
GO

DROP TABLE IF EXISTS  base.encounter_type;

-- $BEGIN

CREATE TABLE base.encounter_type (
    encounter_type_id int NOT NULL AUTO_INCREMENT,
    external_encounter_type_id int,
    encounter_type_uuid CHAR(38) NOT NULL,
    PRIMARY KEY (encounter_type_id)
);

-- $END
