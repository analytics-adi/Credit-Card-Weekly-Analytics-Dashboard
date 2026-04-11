-- 1. Create cc_detail table

CREATE TABLE cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date VARCHAR(50),
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);


-- 2. Create cc_detail table

CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

-- 3. Copy csv data into SQL (remember to update the file name and file location in below query)

-- copy cc_detail table
BULK INSERT dbo.cc_detail
FROM 'C:\Users\OMEN\Desktop\Portfolio\Data_Analysis\CreditCardTransaction\Data\credit_card.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- Checking Date format in Week_Start_Date column
SELECT 
    DISTINCT Week_Start_Date
FROM dbo.cc_detail;

-- Converting Week_Start_Date to DATE format (dd/mm/yyyy) and creating a new column to store the converted date
SELECT 
    TRY_CONVERT(DATE, Week_Start_Date, 103) AS Clean_Date
FROM dbo.cc_detail;

ALTER TABLE dbo.cc_detail
ADD Week_Start_Date_New DATE;

UPDATE dbo.cc_detail
SET Week_Start_Date_New = TRY_CONVERT(DATE, Week_Start_Date, 103);

-- Replace the original Week_Start_Date column with the new one and drop the old column
ALTER TABLE dbo.cc_detail DROP COLUMN Week_Start_Date;

EXEC sp_rename 
    'dbo.cc_detail.Week_Start_Date_New', 
    'Week_Start_Date', 
    'COLUMN';

SELECT * FROM dbo.cc_detail;

-- Checking for NULL values in Week_Start_Date column
SELECT *
FROM dbo.cc_detail
WHERE Week_Start_Date IS NULL;

-- copy cust_detail table

BULK INSERT dbo.cust_detail
FROM 'C:\Users\OMEN\Desktop\Portfolio\Data_Analysis\CreditCardTransaction\Data\customer.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);