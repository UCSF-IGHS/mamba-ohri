USE analysis;


-- $BEGIN

CALL base.sp_fact_hts_create;
CALL base.sp_fact_hts_insert;
CALL base.sp_fact_hts_update;
CALL base.sp_fact_hts_cleaning;

-- $END
