/* 

DDL : creating bronze table
script : this script creates the tables in the 'bronze' schema, dropping existing tables if they are already existing.
creating two new tables bronze.emp_info for employee details and bronze.compensation_info for compensation details.
*/


If object_id('bronze.Emp_info', 'U') is not null
Drop table bronze.Emp_info;
create table bronze.Emp_info(
Emp_ID int,
Hire_Date_Raw DATE,
First_Name nvarchar(50),
Last_Name nvarchar(50),
Department_Code_Raw nvarchar(50),
Location_ID int

);

If object_id('bronze.compensation_info', 'U') is not null
Drop table bronze.compensation_info;
create table bronze.compensation_info(
Emp_ID int,
Annual_Salary_Raw nvarchar(50),
Bonus_Amount_Raw nvarchar(50),
Review_Rating_Raw nvarchar(25)
);
