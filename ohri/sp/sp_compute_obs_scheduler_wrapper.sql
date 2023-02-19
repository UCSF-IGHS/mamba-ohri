-- Scheduler / Event fired every 1 minute to compute & insert/update

DROP EVENT IF EXISTS SCHEDULE_COMPUTED_OBS;

CREATE EVENT IF NOT EXISTS SCHEDULE_COMPUTED_OBS
    ON SCHEDULE EVERY 1 MINUTE
    ON COMPLETION PRESERVE
    DO CALL sp_compute_obs_scheduler();