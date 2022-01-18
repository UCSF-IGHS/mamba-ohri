USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE derived_recency.dim_implementing_mechanism;

-- $BEGIN

INSERT INTO derived_recency.dim_implementing_mechanism (
	implementing_mechanism_id,
	[name],
	ip_name,
	agency,
	composite_id	
)
SELECT
	implementing_mechanism_id,
	[name],
	ip_name,
	agency,
	composite_id
FROM 
	base.dim_implementing_mechanism 	

-- $END

select * from derived_recency.dim_implementing_mechanism;