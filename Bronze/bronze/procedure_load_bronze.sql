/* 
==============================================================
stored procedur= loads bronze layer (source--->bronze)

-Inserting the raw data from source Emp_info.csv ------> bronze.Emp_info table
-Inserting the raw data from source Compensation_info.csv ------> bronze.Compensation_info table

Usage example = exec bronze.load_bronze
===============================================================
*/

Create or alter procedure bronze.load_bronze as 
begin
declare @start_time datetime, @end_time datetime;
print  '========================================================================';
print  'loading bronze layer';
print  '========================================================================';

set @start_time = getdate();
print  '>> Truncating the table: bronze.Emp_info';
Truncate table bronze.Emp_info;
Print '>> Inserting data into : bronze.Emp_info';
bulk insert bronze.Emp_info
from 'C:\Users\leela\OneDrive\Desktop\ZerocodeHR\Emp_info.csv'
with (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);
set @end_time = getdate();
print '>>load duration time: ' + cast(datediff(second,@start_time, @end_time) as nvarchar);
print '-----------------------------------';



set @start_time = getdate();
print  '>> Truncating the table: bronze.compensation_info';
Truncate table bronze.compensation_info;
Print '>> Inserting data into : bronze.compensation_info';
bulk insert bronze.compensation_info
from 'C:\Users\leela\OneDrive\Desktop\ZerocodeHR\compensation_info.csv'
with (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);
set @end_time = getdate();
print '>>load duration time: ' + cast(datediff(second,@start_time, @end_time) as nvarchar)
print '-----------------------------------'
end


