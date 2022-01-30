USE analysis;


-- $BEGIN

CALL sp_derived_hts_fact_hts_create();
CALL sp_derived_hts_fact_hts_insert();
CALL sp_derived_hts_fact_hts_cleaning();

-- $END
