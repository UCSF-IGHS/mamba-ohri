USE analysis;


TRUNCATE TABLE derived_hts.fact_hts;

-- $BEGIN

INSERT INTO derived_hts.fact_hts (
     fact_hts_id,
     encounter_id,
     client_id,
     test_setting,
     community_service_point,
     facility_service_point,
     hts_approach,
     pop_type,
     key_pop_type,
     key_pop_migrant_worker
)
SELECT
    NEWID() AS fact_hts_id,
    o.encounter_id AS encounter_id,
    o.person_id AS client_id,
    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 1
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 2
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 3
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 4
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 5
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT (CASE cm.data_type
                WHEN 'Text' THEN eo.obs_value_text
                WHEN 'Coded' THEN eo.obs_value_text
                WHEN 'Date' THEN eo.obs_value_datetime
                WHEN 'Numeric' THEN eo.obs_value_numeric
            END)
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.obs_question_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 6
    ORDER BY eo.obs_datetime DESC LIMIT 1),

    (SELECT
        (IF (eo.obs_value_text = NULL, 'No', 'Yes'))
    FROM base.fact_obs eo
    INNER JOIN base.dim_metadata cm ON cm.concept_uuid= eo.value_coded_uuid
    WHERE eo.encounter_id=o.encounter_id and cm.column_number = 7
    ORDER BY eo.obs_datetime DESC LIMIT 1)

FROM base.fact_obs o
WHERE o.encounter_type_uuid='79c1f50f-f77d-42e2-ad2a-d29304dde2fe'
GROUP BY o.encounter_id;

-- $END


