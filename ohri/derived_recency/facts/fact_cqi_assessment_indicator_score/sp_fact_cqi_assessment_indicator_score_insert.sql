USE recency_uganda_prod_analysis_test 
GO

TRUNCATE TABLE [derived_recency].[fact_cqi_assessment_indicator_score];

-- $BEGIN

DECLARE
	@colsUnpivot AS NVARCHAR ( MAX ),
	@query AS NVARCHAR ( MAX )

-- Code might look repeated on this file, but this was done to 
-- solve the issue with UNPIVOT function restriction of working only with values with same data type 

SELECT
    @colsUnpivot = 
		stuff(
                (
                    SELECT
                        ',' + quotename( C.attribute_name )
                    FROM
                        [derived_recency].[dim_cqi_indicator] AS C
                    WHERE
                        C.display = 1
                    AND
                        C.data_type IN ('yes_no', 'yes_no_unk')
                    FOR xml path ( '' ) 
                ),
                1,
                1,
                '' 
            )
SET 
	@query = 
            'INSERT INTO [derived_recency].[fact_cqi_assessment_indicator_score] 
            ( 
                cqi_assessment_indicator_score_id,
                _attribute_name,
                value,
                comment,
                cqi_assessment_id
            )
            SELECT 
                NEWID() AS cqi_assessment_indicator_score_id,
                attribute_name,
                value,
                NULL,
                cqi_assessment_merged_id
            FROM
                [base].[fact_cqi_assessment_merged]
            UNPIVOT
            (
                value FOR attribute_name IN ('+ @colsUnpivot+')
            ) u'

EXEC(@query)

SELECT
    @colsUnpivot = 
		stuff(
                (
                    SELECT
                        ',' + quotename( C.attribute_name )
                    FROM
                        [derived_recency].dim_cqi_indicator AS C
                    WHERE
                        C.display = 1
                    AND
                        C.data_type IN ('percentage')
                    FOR xml path ( '' ) 
                ),
                1,
                1,
                '' 
            )
SET 
	@query = 
            'INSERT INTO [derived_recency].[fact_cqi_assessment_indicator_score] 
            ( 
                cqi_assessment_indicator_score_id,
                _attribute_name,
                value,
                comment,
                cqi_assessment_id 
            )
            SELECT 
                NEWID() AS cqi_assessment_indicator_score_id,
                attribute_name,
                value,
                NULL,
                cqi_assessment_merged_id
            FROM
                [base].[fact_cqi_assessment_merged]
            UNPIVOT
            (
                value FOR attribute_name IN ('+ @colsUnpivot+')
            ) u'

EXEC(@query)


SELECT
    @colsUnpivot = 
		stuff(
                (
                    SELECT
                        ',' + quotename( C.attribute_name )
                    FROM
                        [derived_recency].dim_cqi_indicator AS C
                    WHERE
                        C.display = 1
                    AND
                        C.data_type IN ('number')
                    FOR xml path ( '' ) 
                ),
                1,
                1,
                '' 
            )
SET 
	@query = 
            'INSERT INTO [derived_recency].[fact_cqi_assessment_indicator_score] 
            ( 
                cqi_assessment_indicator_score_id,
                _attribute_name
                value,
                comment,
                cqi_assessment_id 
            )
            SELECT 
                NEWID() AS cqi_assessment_indicator_score_id,
                attribute_name,
                value,
                NULL,
                cqi_assessment_merged_id
            FROM
                [base].[fact_cqi_assessment_merged]
            UNPIVOT
            (
                value FOR attribute_name IN ('+ @colsUnpivot+')
            ) u'

EXEC(@query)

UPDATE 
    [derived_recency].[fact_cqi_assessment_indicator_score] 
SET
    cqi_indicator_id = (SELECT cqi_indicator_id FROM [derived_recency].[dim_cqi_indicator] WHERE attribute_name = _attribute_name);

-- $END

SELECT 
    TOP 1000 * 
FROM 
    [derived_recency].[fact_cqi_assessment_indicator_score];