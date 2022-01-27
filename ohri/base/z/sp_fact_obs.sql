USE analysis;


-- $BEGIN

CALL base.sp_fact_obs_create;
CALL base.sp_fact_obs_insert;
CALL base.sp_fact_obs_update_question_uuid;
CALL base.sp_fact_obs_update_value_coded;

-- $END
