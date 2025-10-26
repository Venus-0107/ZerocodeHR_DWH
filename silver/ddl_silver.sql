/* 

DDL : creating silver tabel
script : this script creates the tables in the 'silver' schema, dropping existing tables if they are already existing.

*/



IF OBJECT_ID('silver.clean_data', 'U') IS NOT NULL
DROP TABLE silver.clean_data;
GO
CREATE TABLE silver.clean_data (
Emp_ID INT PRIMARY KEY NOT NULL,
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Hire_Date_Clean DATE,
Dept_Code_Clean VARCHAR(10),
Annual_Salary_Clean DECIMAL(10, 2),
Bonus_Amount_Clean DECIMAL(10, 2),
Review_Rating_Clean VARCHAR(10),
-- QA and Integration Flags (The Implementation Analyst's Deliverable)
Orphan_Data_FLAG CHAR(1) NOT NULL,       -- 'Y' if comp record exists without a master record
Salary_Quality_FLAG CHAR(1) NOT NULL     -- 'N' if raw salary was non-numeric/invalid
);
GO
