USE analysis;

DROP TABLE IF EXISTS  base_dim_concept_answer;

-- $BEGIN

CREATE TABLE base_dim_concept_answer (
    concept_answer_id int NOT NULL AUTO_INCREMENT,
    concept_id int,
    answer_concept int,
    answer_drug int,
    PRIMARY KEY (concept_answer_id)
);

-- $END
