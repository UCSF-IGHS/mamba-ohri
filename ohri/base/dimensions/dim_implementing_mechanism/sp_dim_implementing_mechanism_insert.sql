USE recency_uganda_prod_analysis_test;
GO

TRUNCATE TABLE base.dim_implementing_mechanism;

-- $BEGIN

INSERT INTO base.dim_implementing_mechanism (
	[name],
	ip_name,
	agency,
	composite_id	
)
SELECT DISTINCT
	implementing_mechanism,
	supporting_ip,
	agency,
	CONCAT(supporting_ip,implementing_mechanism,agency)
FROM 
	[external].emr_facility_activation
WHERE 
	implementing_mechanism IS NOT NULL;


-- $END

select * from base.dim_implementing_mechanism;