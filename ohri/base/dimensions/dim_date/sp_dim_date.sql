USE recency_uganda_prod_analysis_test;
GO

DROP TABLE IF EXISTS base.dim_date;

-- $BEGIN
    
Set nocount on;

DECLARE @BeginDate DATE
SET @BeginDate = '01-01-1900';
DECLARE @EndDate DATE
DECLARE @OFFSET_YEARS INT = 5;
SET @EndDate = DATEADD(year,@OFFSET_YEARS,GETDATE());
DECLARE @RowNum INT = 1;
DECLARE @LastDayOfMon CHAR(1);
DECLARE @DateCounter DATE;  

CREATE TABLE 
  base.dim_date(
    [date_id] INT NOT NULL
    ,[date_yyyymmdd] DATE
    ,[date_slash_yyyymd] NVARCHAR (50)
    ,[date_slash_mdyyyy] NVARCHAR (50)
    ,[date_slash_dmyyyy] NVARCHAR (50)
    ,[day_number_of_week] NVARCHAR (50)
    ,[day_name_of_week] NVARCHAR (50)
    ,[day_of_month] NVARCHAR (50)
    ,[day_of_year] NVARCHAR (50)
    ,[weekday_weekend] NVARCHAR (50)
    ,[week_number_of_year] NVARCHAR (50)
    ,[month_name] NVARCHAR (50)
    ,[month_number_of_year] NVARCHAR (50)
    ,[year] NVARCHAR (50)
    ,[last_day_of_month] NVARCHAR (50)
    ,[datim_annual_period] NVARCHAR (50)
    ,[datim_semiannual_period] NVARCHAR (50)
    ,[datim_quarter_period] NVARCHAR (50)
    ,[quarter_period] NVARCHAR (50)
    ,[semiannual_period] NVARCHAR (50)
    ,[pepfar_annual_period] NVARCHAR (50)
    ,[pepfar_quarter_period] NVARCHAR (50)
);

ALTER TABLE [base].dim_date ADD CONSTRAINT PK_date_id PRIMARY KEY (date_id);
-- #Start the counter at the begin date
SET
 @DateCounter = @BeginDate;

WHILE 
  @DateCounter <= @EndDate
BEGIN
--# Set value for IsLastDayOfMonth
IF 
  EOMONTH(@DateCounter) = CAST(@DateCounter AS DATE)
BEGIN
  SET 
  @LastDayOfMon = 'Y';
END
ELSE
  BEGIN
  SET 
  @LastDayOfMon = 'N';
END

--# add a record into the date dimension table for this date

INSERT INTO base.dim_date
  ([date_id]
  ,[date_yyyymmdd]
  ,[date_slash_yyyymd]
  ,[date_slash_mdyyyy]
  ,[date_slash_dmyyyy]
  ,[day_number_of_week]
  ,[day_name_of_week]
  ,[day_of_month]
  ,[day_of_year]
  ,[weekday_weekend]
  ,[week_number_of_year]
  ,[month_name]
  ,[month_number_of_year]
  ,[year]
  ,[last_day_of_month]
  ,[datim_annual_period]
  ,[datim_semiannual_period]
  ,[datim_quarter_period]
  ,[quarter_period]
  ,[semiannual_period]
  ,[pepfar_annual_period]
  ,[pepfar_quarter_period])
VALUES  
  ( @RowNum --DateDimID
    ,@DateCounter --# FullDate
    ,CONCAT(CAST(YEAR(@DateCounter) AS CHAR(4)),'/',DATEPART(MONTH, @DateCounter),'/',DATEPART(DAY, @DateCounter)) --#DateName
    ,CONCAT(DATEPART(MONTH, @DateCounter),'/',DATEPART(DAY, @DateCounter),'/',CAST(YEAR(@DateCounter) AS CHAR(4))) --#DateNameUS
    ,CONCAT(DATEPART(DAY, @DateCounter),'/',DATEPART(MONTH, @DateCounter),'/',CAST(YEAR(@DateCounter) AS CHAR(4))) --#DateNameEU
    ,DATEPART(WEEKDAY, @DateCounter) --#DayOfWeek
    ,DATENAME(WEEKDAY, @DateCounter) --#DayNameOfWeek
    ,DATENAME(DAY, @DateCounter) --#DayOfMonth
    ,DATENAME(DAYOFYEAR, @DateCounter) --#DayOfYear
    ,CASE DATENAME(WEEKDAY, @DateCounter)
      WHEN 'Saturday' THEN 'Weekend'
      WHEN 'Sunday' THEN 'Weekend'
      ELSE 'Weekday'
    END 
--#WeekdayWeekend
    ,DATEPART(WEEK, @DateCounter) --#WeekOfYear
    ,DATENAME(MONTH, @DateCounter) --#MonthName
    ,DATEPART(MONTH, @DateCounter) --#MonthOfYear
    ,DATEPART(YEAR, @DateCounter)  -- Year
    ,@LastDayOfMon --#IsLastDayOfMonth
    ,NULL
    ,NULL
    ,NULL
    ,CONCAT( datepart(YEAR,@DateCounter), '-Q', DATEPART(QUARTER,@DateCounter)) -- Quarterly_Period
    ,CAST(DATEPART(YEAR, @DateCounter) AS VARCHAR(4)) + '-sa' + CAST(CAST(((DATEPART(mm, @DateCounter)-1)/6) AS INT) + 1 AS VARCHAR(2)) -- Semi_Annual_Period
    ,CASE WHEN DATEPART(MONTH, @DateCounter) >= 10 AND DATEPART(MONTH, @DateCounter) <=12 THEN 'FY' + CAST((DATEPART(YY, @DateCounter) + 1) AS VARCHAR(4))
    ELSE 'FY' + CAST(DATEPART(YY, @DateCounter) AS VARCHAR(4))
    END 
--- == Pepfar Year
    ,CASE WHEN DATEPART(MONTH, @DateCounter) IN (10, 11, 12) THEN 'FY' + CAST((DATEPART(YY, @DateCounter) + 1) AS VARCHAR(4)) + 'Q1' 
    WHEN DATEPART(MONTH, @DateCounter) IN (1, 2, 3) THEN 'FY' + CAST(DATEPART(YY, @DateCounter) AS VARCHAR(4)) + 'Q2' 
    WHEN DATEPART(MONTH, @DateCounter) IN (4, 5, 6) THEN 'FY' + CAST(DATEPART(YY, @DateCounter) AS VARCHAR(4)) + 'Q3' 
    WHEN DATEPART(MONTH, @DateCounter) IN (7, 8, 9) THEN 'FY' + CAST(DATEPART(YY, @DateCounter) AS VARCHAR(4)) + 'Q4' 
    END --- == Pepfar Quarter
);          
            
SET 
    @RowNum = @RowNum + 1;
            
--# Increment the date counter for next pass thru the loop
            
SET 
    @DateCounter = DATEADD(DAY, 1, @DateCounter);
END;
UPDATE base.dim_date 
SET
 day_number_of_week = case day_name_of_week
  when 'Monday' then 1
  when 'Tuesday' then 2
  when 'Wednesday' then 3
  when 'Thursday' then 4
  when 'Friday' then 5
  when 'Saturday' then 6
  when 'Sunday' then 7
END;

-- $END

