/* 
Create Database and schemas
-------------------------------------------------------------------------------------------
script purpose:
 This script creates a newdatabase named ZerocodeHR. Additionally the script setups three schemas
 within in the database: 'bronze'.'silver','gold'.

*/

Use master;
go
--- Create ZerocodeHR database
create database ZerocodeHR;

use ZerocodeHR;

create schema bronze;
go
create schema silver;
go
create schema gold;
go
