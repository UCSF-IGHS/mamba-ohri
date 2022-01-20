USE analysis;
GO

-- $BEGIN

EXEC base.sp_fact_obs_create;
EXEC base.sp_fact_obs_insert;
EXEC base.sp_fact_obs_update_question_uuid;
EXEC base.sp_fact_obs_update_value_coded;

-- $END
