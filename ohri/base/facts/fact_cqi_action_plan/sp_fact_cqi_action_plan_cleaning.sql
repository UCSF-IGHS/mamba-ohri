USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

-- Remove None of the above where not applicable

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = 'uuid:af415c2c-c3d4-4a0d-a1ee-a3a5b9cdbf37'
                            AND
                            t.category_code = 200
                            AND
                            t.root_cause = 'none'
                            AND
                            t.intervention = 'none');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = 'KWSK6E7JV3CSZ5TIXWRIC2PG0'
                            AND
                            t.category_code = 400
                            AND
                            t.root_cause = 'nonnon'
                            AND
                            t.intervention = 'non');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = 'uuid:af415c2c-c3d4-4a0d-a1ee-a3a5b9cdbf37'
                            AND
                            t.category_code = 500
                            AND
                            t.root_cause = 'N/A'
                             AND
                            t.intervention = 'N/A');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = '7UBGZW74RAYWSV6Y8GDTULWMT'
                            AND
                            t.category_code = 500
                            AND
                            t.root_cause = 'N/A'
                            AND
                            t.intervention = 'N/A');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = 'LY3H4UPDC5MVF068O0EEIHLJ8'
                            AND
                            t.category_code = 200
                            AND
                            t.root_cause = 'non'
                            AND
                            t.intervention = 'non');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = '5KFF9MK5EQXL4E0T9D7EIUHGG'
                            AND
                            t.category_code = 500
                            AND
                            t.root_cause = 'non'
                            AND
                            t.intervention = 'non');

DELETE

FROM base.fact_cqi_action_plan
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.action_plan_uri = 'KWSK6E7JV3CSZ5TIXWRIC2PG0'
                            AND
                            t.category_code = 600
                            AND
                            t.root_cause = 'non'
                            AND
                            t.intervention = 'non');

-- study staff coded corrections 

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Minimal or insufficient training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 100
                            AND
                            t.action_plan_uri IN ('uuid:af415c2c-c3d4-4a0d-a1ee-a3a5b9cdbf37', 
                                         '3BDRSQO42VV99U26FARNX0F42', 
                                         '3N2IMO5MBPTXGJX80B8YTKEQ2', 
                                         '0LQDDB6KQY0NXQCZBI0CX9IA5', 
                                         '9TQNYBT946T2652TALKB6V7AA', 
                                         'LJFVAI1T178BJ8T9EKY96RPBG'));

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Lack of documentation of training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 100
                            AND
                            t.action_plan_uri IN ('LX0W5CZDF4FT4VPV0PGKUS3SX', 
                                         'UFKJ138S7R94MHFC4XP7222C4', 
                                         'BL5CC9CALVSBXO4XZM0QM9PUK', 
                                         'BVJC6N7Q9KTGHA8J9JEQDR0U2'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Enroll staff in training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 100
                            AND
                            t.action_plan_uri IN ('3N2IMO5MBPTXGJX80B8YTKEQ2', 
                                         '0LQDDB6KQY0NXQCZBI0CX9IA5'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide or request training certificates'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 100
                            AND
                            t.action_plan_uri IN ('uuid:aa48692a-2b26-415a-84bc-8ab30219dc14', 
                                         'uuid:cc6ba196-68c9-4167-a41d-4d27ee7991a3',
                                         'uuid:59bfc996-6415-4382-8863-f9e5708b072d',
                                         'uuid:c0321380-43c2-451c-a819-18fab9c361ef',
                                         '7UBGZW74RAYWSV6Y8GDTULWMT',
                                         'uuid:a6b6762a-cf05-4d40-bea1-8ac88bcdc050',
                                         'uuid:8185d2b3-b373-474f-8e19-a006f4159772',
                                         'uuid:a57bef33-6d6e-44f4-bd82-024db8564918',
                                         'uuid:1f78fc5f-4dce-424d-b2ff-536c0a2f1569',
                                         'uuid:cc5fb04c-8779-42c7-a9bd-e751a8fbf924',
                                         'uuid:c76642ec-c4a4-4703-a2d4-8e9bc65f06ff',
                                         'CZHLAMBFH2H0MPL2A3I42ZXGE',
                                         '2S4QPJ91BUCN7RJEO9GXIS6UT',
                                         'Z5AM8COF02MWL9KK0O3DFJ938',
                                         '08HQCSU6E5J9TPMPLOWC6W5V4',
                                         'NWEB8FJO58D7SJ9RGLNU22RQ9',
                                         'FCTR6FKNGDYVY6EOSXF1VYXX5',
                                         'KST2WN2IBN8I6ZJL9YZ93VFI8',
                                         'O0VDQPZKDJZ115WMLL3F7NE55',
                                         '5E6PYMGKXG2PIF4OH3B652CZ3',
                                         '6RJWCGDQDTKSM3PSTCWQ8IXZA',
                                         'VAZWG1TF8IMJIBMMAA3JE5MDC',
                                         '2SBP1A52Y9MYJXL4BP7AJTB8Y',
                                         'SIWCTA7R8P4DPMWYEJ2ZVALP4',
                                         'R5C293J6P2XR0VYRSS4ITHM72',
                                         'JBOHAQIQQ5G8KBXCEUBX9N916',
                                         'OV3F43ULTHLFE4NFCDD4S5V4W',
                                         '9FB8VZ7YN2Z8PSKLW0IE8S4T6',
                                         '4PB9TI6TUH1F0XWNSA4X5VYN8',
                                         'BQOI2GGHPU0ZYXI0NFAVUEKQU',
                                         'YY5C0FN263O7V5TWE5UMMA7DB',
                                         'CXC5YZINO6310CLV669YIDFSK',
                                         'RWG7HRUCE4C56ATRD5CRKM5DE',
                                         'XS5UCTE623SN3MONFFJ8PUGDY',
                                         '69YEN7GXYRC2J098GZZK36NE0',
                                         '8TT3HPKK5IMZ666F7GEF0B6R3',
                                         'LX0W5CZDF4FT4VPV0PGKUS3SX',
                                         'UFKJ138S7R94MHFC4XP7222C4',
                                         'BL5CC9CALVSBXO4XZM0QM9PUK',
                                         'BVJC6N7Q9KTGHA8J9JEQDR0U2',
                                         'P0FTIT2HK5WIKUBT3Q8F8GIXZ'));

-- procedures coded corrections 

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Lack of supplies (other)'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('uuid:a6b6762a-cf05-4d40-bea1-8ac88bcdc050', 
                                         'uuid:a57bef33-6d6e-44f4-bd82-024db8564918', 
                                         '6RJWCGDQDTKSM3PSTCWQ8IXZA', 
                                         '69YEN7GXYRC2J098GZZK36NE0', 
                                         'UFKJ138S7R94MHFC4XP7222C4', 
                                         'BL5CC9CALVSBXO4XZM0QM9PUK', 
                                         'BVJC6N7Q9KTGHA8J9JEQDR0U2',   
                                         'P0FTIT2HK5WIKUBT3Q8F8GIXZ'));

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Poor coordination at facility'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri = '8TT3HPKK5IMZ666F7GEF0B6R3');

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Minimal or insufficient training – Data'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri = 'FOONB8U1BFRK0LY3UUS7H70XL');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Improve site infrastructure'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri = '7UBGZW74RAYWSV6Y8GDTULWMT');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Improve site infrastructure – technology'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('uuid:c76642ec-c4a4-4703-a2d4-8e9bc65f06ff', 
                                         '2S4QPJ91BUCN7RJEO9GXIS6UT', 
                                         'FCTR6FKNGDYVY6EOSXF1VYXX5', 
                                         'KST2WN2IBN8I6ZJL9YZ93VFI8', 
                                         '5E6PYMGKXG2PIF4OH3B652CZ3',   
                                         '2SBP1A52Y9MYJXL4BP7AJTB8Y'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Review and update supply chain procedures to ensure adequate supply'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('uuid:a6b6762a-cf05-4d40-bea1-8ac88bcdc050', 
                                         'uuid:a57bef33-6d6e-44f4-bd82-024db8564918', 
                                         '6RJWCGDQDTKSM3PSTCWQ8IXZA', 
                                         'BL5CC9CALVSBXO4XZM0QM9PUK', 
                                         'BVJC6N7Q9KTGHA8J9JEQDR0U2',   
                                         'P0FTIT2HK5WIKUBT3Q8F8GIXZ'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide printed forms/registers'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('08HQCSU6E5J9TPMPLOWC6W5V4', 
                                         'NWEB8FJO58D7SJ9RGLNU22RQ9', 
                                         'JBOHAQIQQ5G8KBXCEUBX9N916',   
                                         '9TQNYBT946T2652TALKB6V7AA'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Procure supplies'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('69YEN7GXYRC2J098GZZK36NE0',   
                                         'UFKJ138S7R94MHFC4XP7222C4'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide refresher training to staff'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri IN ('LX0W5CZDF4FT4VPV0PGKUS3SX',   
                                         'Q0LY3902RNGU6KKS62Y42DNW3'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Improve sample transport coordination'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 200
                            AND
                            t.action_plan_uri = '8TT3HPKK5IMZ666F7GEF0B6R3');

-- source data coded corrections 

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Minimal or insufficient training – Data'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri IN ('3N2IMO5MBPTXGJX80B8YTKEQ2',   
                                         '4PB9TI6TUH1F0XWNSA4X5VYN8'));

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Insufficient staff'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri = 'KWSK6E7JV3CSZ5TIXWRIC2PG0');

UPDATE
    base.fact_cqi_action_plan 
SET 
    root_cause_code = 'Poor coordination at facility'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri = '5KFF9MK5EQXL4E0T9D7EIUHGG');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide refresher training to staff'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri IN ('KST2WN2IBN8I6ZJL9YZ93VFI8',   
                                         '4PB9TI6TUH1F0XWNSA4X5VYN8'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide printed forms/registers'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri = '9TQNYBT946T2652TALKB6V7AA');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Enroll staff in training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 300
                            AND
                            t.action_plan_uri IN ('KWSK6E7JV3CSZ5TIXWRIC2PG0',   
                                         '5KFF9MK5EQXL4E0T9D7EIUHGG'));

-- physical facility coded corrections 

UPDATE
    base.fact_cqi_action_plan
SET 
    root_cause_code = 'Lack of supplies (other)'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 400
                            AND
                            t.action_plan_uri IN ('7UBGZW74RAYWSV6Y8GDTULWMT', 
                                         'NWEB8FJO58D7SJ9RGLNU22RQ9', 
                                         '5E6PYMGKXG2PIF4OH3B652CZ3', 
                                         '6RJWCGDQDTKSM3PSTCWQ8IXZA', 
                                         'VAZWG1TF8IMJIBMMAA3JE5MDC', 
                                         'P0FTIT2HK5WIKUBT3Q8F8GIXZ'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Procure supplies'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 400
                            AND
                            t.action_plan_uri IN ('7UBGZW74RAYWSV6Y8GDTULWMT', 
                                         'NWEB8FJO58D7SJ9RGLNU22RQ9', 
                                         '5E6PYMGKXG2PIF4OH3B652CZ3', 
                                         '6RJWCGDQDTKSM3PSTCWQ8IXZA', 
                                         'VAZWG1TF8IMJIBMMAA3JE5MDC',   
                                         'P0FTIT2HK5WIKUBT3Q8F8GIXZ'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Improve site infrastructure '
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 400
                            AND
                            t.action_plan_uri IN ('uuid:81fb8bc7-f854-4b4a-acfc-fd68935a17db',   
                                         'YY5C0FN263O7V5TWE5UMMA7DB',   
                                         'XS5UCTE623SN3MONFFJ8PUGDY'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide printed forms/registers'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 400
                            AND
                            t.action_plan_uri = 'uuid:a57bef33-6d6e-44f4-bd82-024db8564918');

-- participant recruitment coded corrections 

UPDATE
    base.fact_cqi_action_plan 
SET 
    root_cause_code = 'Minimal or insufficient training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 500
                            AND
                            t.action_plan_uri = 'uuid:8185d2b3-b373-474f-8e19-a006f4159772');

UPDATE
    base.fact_cqi_action_plan 
SET 
    root_cause_code = 'Lack of supplies (other)'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 500
                            AND
                            t.action_plan_uri = '5E6PYMGKXG2PIF4OH3B652CZ3');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide printed forms/registers'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 500
                            AND
                            t.action_plan_uri IN ('uuid:a6b6762a-cf05-4d40-bea1-8ac88bcdc050', 
                                         'NWEB8FJO58D7SJ9RGLNU22RQ9', 
                                         'BL5CC9CALVSBXO4XZM0QM9PUK',   
                                         'BVJC6N7Q9KTGHA8J9JEQDR0U2'));

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Enroll staff in training'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 500
                            AND
                            t.action_plan_uri = 'uuid:8185d2b3-b373-474f-8e19-a006f4159772');

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Provide refresher training to staff'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 500
                            AND
                            t.action_plan_uri = '5O9PKHI4JU70KH8N4KHTMFCRL');

-- site supplies coded corrections 

UPDATE
    base.fact_cqi_action_plan
SET 
    intervention_code = 'Procure supplies'
    
WHERE
    cqi_action_plan_id IN (SELECT t.cqi_action_plan_id
                            FROM staging.staging_cqi_action_plan t
                            WHERE
                            t.category_code = 600
                            AND
                            t.action_plan_uri = '9TQNYBT946T2652TALKB6V7AA');

-- $END