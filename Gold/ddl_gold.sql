/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
*/


create view  gold.ZeroCodeHR_data as
select
distinct T1.Emp_ID,
T1.First_Name,
T1.Last_Name,
T1.Hire_Date_Clean,
T1.Dept_Code_Clean,
T1.Annual_Salary_Clean,
datediff(year, T1.Hire_Date_Clean, getdate()) as Years_of_Service_Metric,
case
when datediff(year, T1.Hire_Date_Clean, getdate()) > 1 then 'Y'
else 'N'
end as Eligible_For_Merit_FLAG,

case upper(T1.Review_Rating_Clean)
when 'EXCELLENT' then 'A'
when 'GOOD' then 'B'
when 'AVERAGE' then 'C'
else 'FAIL_RATING'
end as Review_Rating_Standard,

case
when T1.Annual_Salary_Clean IS NULL OR T1.Orphan_Data_FLAG = 'Yes' then 'No'
when T1.Dept_Code_Clean = 'UNKNOWN' then 'No'
when (case upper(T1.Review_Rating_Clean) when 'EXCELLENT' then 'A' when 'GOOD' then 'B' when 'AVERAGE' then 'C' else 'FAIL_RATING' end) = 'FAIL_RATING' then 'No'
else 'Yes'
end as Details_Validation
from
silver.clean_data as T1;
