USE analysis;

TRUNCATE TABLE base_dim_concept_datatype;

-- $BEGIN

INSERT INTO base_dim_concept_datatype (
    external_datatype_id,
    datatype_name,
    z_column_name
)
SELECT
    dt.concept_datatype_id AS external_datatype_id,
    dt.name AS datatype_name,
	CASE name
	  WHEN 'Text' 	  THEN 'obs_value_text'
		WHEN 'Coded' 	  THEN 'obs_value_text'
		WHEN 'Date' 	  THEN 'obs_value_datetime'
		WHEN 'Datetime' THEN 'obs_value_datetime'
		WHEN 'Numeric'  THEN 'obs_value_numeric'
		ELSE NULL
	END AS z_column_name
FROM
    openmrs_working.concept_datatype dt
WHERE
    dt.retired = 0;

-- $END
