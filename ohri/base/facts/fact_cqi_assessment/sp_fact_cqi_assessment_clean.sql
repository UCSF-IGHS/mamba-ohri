USE recency_uganda_prod_analysis_test
GO

-- $BEGIN
 
UPDATE 
	[base].[fact_cqi_assessment]
SET 
		assessment_point = 'ART Verification Point',
		assessment_point_other = NULL
WHERE
		uri 
            IN
            (
                'uuid:f4d41004-7e17-4a26-94db-b65dc0e7dbbb'
                ,'uuid:b8dc67eb-5e29-49cc-8d76-1ecd58a1e1da'
                ,'uuid:a9aa2cce-bdba-47cd-ac0f-edffef17afe3'
                ,'uuid:091d940b-05a5-40be-ba69-a636d2fb55e2'
                ,'uuid:d7aa7e0d-0fd8-4a99-b9f8-7a2d691dccbb'
                ,'uuid:bba781da-dd2b-447b-8bc6-e8125a458061'
                ,'uuid:a02b0dfc-c06c-4ff4-914e-268575b9f316'
                ,'uuid:659318d3-17ed-4f65-98ca-d87545e2d905'
                ,'uuid:eae8f4f1-4ee9-4925-8f30-87a6edbd71b7'
                ,'uuid:5985cc29-b17b-4068-8a75-d91b043ebb0f'
            );

UPDATE 
	[base].[fact_cqi_assessment]
SET 
    assessment_point = 'ART Laboratory',
    assessment_point_other = NULL
WHERE
		uri 
            IN
            (
                'uuid:f316d47b-efb5-4dfa-853c-63cb7381e865'
                ,'uuid:412ff02a-a565-42a1-82d2-d687354b5d2f'
                ,'uuid:15e606d3-118a-4fab-8967-2a7bf92126b8'
            );

UPDATE
    [base].[fact_cqi_assessment]
SET
    assessment_point = 'General Laboratory',
    assessment_point_other = NULL
WHERE
	assessment_point = 'general_laboratory';






-- $END