# SQL-CSI
# AdventureWorks SQL Queries Project

## Overview
This project contains a set of SQL queries written for the AdventureWorks database. The queries cover a variety of common database tasks such as filtering, joining tables, aggregating data, and sorting results.

## Database
- The queries are written against the AdventureWorks sample database schema.
- The main tables used include: `Customers`, `Orders`, `Order_Details`, `Products`, `Employees`, `Suppliers`, `Categories`, `CITY`, and `STATION`.

## Queries Included
- Listing customers, filtering by city, country, and order activity
- Product listings, filtering by name and order status
- Employee and manager hierarchy queries
- Sales and revenue aggregation
- Various advanced queries combining multiple tables
- City and station related queries for location data

## How to Run
1. Make sure the AdventureWorks database is installed and populated.
2. Use any MySQL client (Workbench, CLI, phpMyAdmin) to run the SQL scripts.
3. Example command line to run queries from a file:
   ```bash
   mysql -u username -p adventureworks < queries.sql
