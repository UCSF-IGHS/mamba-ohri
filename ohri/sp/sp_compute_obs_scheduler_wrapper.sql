-- Scheduler / Event fired every 1 minute to compute & insert/update

DROP EVENT IF EXISTS SCHEDULE_COMPUTED_OBS;

CREATE EVENT IF NOT EXISTS SCHEDULE_COMPUTED_OBS
    ON SCHEDULE EVERY 1 MINUTE
    ON COMPLETION PRESERVE
    DO CALL sp_compute_obs_scheduler();

SET GLOBAL event_scheduler = ON; -- Enables event schedulers to run TODO: probably run: show PROCESSLIST; before to check so we can call this only when event_scheduler is OFF: