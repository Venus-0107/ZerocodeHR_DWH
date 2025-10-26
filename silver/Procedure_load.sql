/* 
==============================================================
stored procedur= loads silver layer (bronze--->silver)
Transformation performed= data cleaning,data enrichment,coloumns derivating.

Usage example = exec silver.load_silver
===============================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME;
print  '========================================================================';
print  'loading Silver layer';
print  '========================================================================';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: silver.clean_data ';
TRUNCATE TABLE silver.clean_data ;
PRINT '>> Inserting Data Into: silver.clean_data ';
insert into silver.clean_data (
Emp_ID,
First_Name,
Last_Name,
Hire_Date_Clean,
Dept_Code_Clean,
Annual_Salary_Clean,
Bonus_Amount_Clean,
Review_Rating_Clean,
Orphan_Data_FLAG,
Salary_Quality_FLAG
)
select
T1.Emp_ID,
T1.First_Name,
T1.Last_Name,
cast(T1.Hire_Date_Raw as date) as Hire_Date_Clean,
coalesce(T3.Dept_ID, 'UNKNOWN') as Dept_Code_Clean,
CAST(replace(replace(T2.Annual_Salary_Raw, '$', ''), ',', '') as decimal(10, 2)) as Annual_Salary_Clean,
CAST(replace(replace(T2.Bonus_Amount_Raw, '$', ''), ',', '') as decimal(10, 2)) as Bonus_Amount_Clean,

case
when T2.Review_Rating_Raw='A' then 'EXCELLENT'
when T2.Review_Rating_Raw='B' then 'GOOD'
when T2.Review_Rating_Raw='C' then 'AVERAGE'
WHEN T2.Review_Rating_Raw IN ('EXCELLENT', 'GOOD', 'AVERAGE') THEN T2.Review_Rating_Raw
else 'N/A'
end as Review_Rating_Clean,
case
when T2.Emp_ID IS NULL then 'Y' 
else 'N'
end as Orphan_Data_FLAG,
case
when T2.Annual_Salary_Raw IS NULL OR T2.Annual_Salary_Raw LIKE '%N/A%' OR
try_cast(replace(replace(T2.Annual_Salary_Raw, '$', ''), ',', '') as decimal(10, 2)) IS NULL
then 'N'
else 'Y'
end as Salary_Quality_FLAG
from
bronze.Emp_info as T1
left join
bronze.compensation_info as T2 on T1.Emp_ID = T2.Emp_ID
left join
bronze.dept_lookup as T3 on T1.Department_Code_Raw = T3.Dept_ID
where
T1.Emp_ID is not null;

set @end_time = GETDATE();
print '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';
end
