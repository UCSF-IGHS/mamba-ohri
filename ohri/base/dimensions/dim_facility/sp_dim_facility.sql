USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

EXEC base.sp_dim_facility_create;
EXEC base.sp_dim_facility_insert_from_mfl;
EXEC base.sp_dim_facility_cleaning;
EXEC base.sp_dim_facility_update_last_sync_dates;
EXEC base.sp_dim_facility_update_activation_dates;
EXEC base.sp_dim_facility_update_implementing_mechanism_id;

-- $END