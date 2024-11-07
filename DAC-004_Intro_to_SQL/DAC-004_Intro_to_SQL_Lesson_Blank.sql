-- Refresher on how to perform basic query and how the database works:

-- SELECT Clause: everything = *

-- Select department table, the employee table and vendor table. Let's explore the database a little!

SELECT* 
FROM humanresources.department;

SELECT* 
FROM humanresources.employee;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT some columns:

-- Select only name, start time and end time.

SELECT 
	name,
	starttime,
	endtime
FROM humanresources.shift;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT DISTINCT values: Unique column value

-- Distinct group names from department and businessentityid from jobcandidate

SELECT DISTINCT groupname
FROM humanresources.department

SELECT DISTINCT businessentityid
FROM humanresources.jobcandidate

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- From different schemas: sales

SELECT DISTINCT countryregioncode
FROM sales.countryregioncurrency

SELECT DISTINCT currencycode
FROM sales.countryregioncurrency


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LIMIT: As the name suggest it limits the number of *rows* shown at the end result

-- Limit the table productvendor to 10 rows and purchaseorderdetail to 100 rows

SELECT *
FROM purchasing.productvendor
LIMIT 100;

SELECT*
FROM purchasing.purchaseorderdetail
LIMIT 100;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT MDAS: Multiplcation/division/addition/subtraction

-- From the customer table Multiplcation/division/addition/subtraction the store_id

-- The AS keyword is used to create an alias for a column or table, allowing you to assign a temporary name to the selected data in the output
-- The result of the calculation is given an alias ten_storeid, meaning that in the ouput , this calculated value will appear under the name ten_storeid

SELECT customerid,storeid * 10 AS ten_storeid
FROM sales.customer
Limit 15;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Q1: SELECT the DISTINCT title, last name, middlename and first_name of each person from the person schema. Return only 231 rows.
--A1;

SELECT DISTINCT 
	title,
	lastname,
	middlename,
	firstname
FROM person.person
LIMIT 231;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: = 
-- gender is male

SELECT 
    jobtitle,
    maritalstatus,
    gender
FROM humanresources.employee
WHERE gender = 'M';


-- Only Research and Development

SELECT*
FROM humanresources.department
WHERE groupname = 'Research and Development'


-- When dealing with NULL values

SELECT*
FROM purchasing.productvendor
WHERE onorderqty is NULL;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: Arithmetic filter

-- From customer table, territoryid = 4

SELECT*
FROM sales.customer
WHERE territoryid = 4
LIMIT 100;


-- From person table, emailpromotion != 0 (Another way of writing != is <>)

SELECT*
FROM person.person
WHERE emailpromotion != 0




-- From employee table, vacationhours >= 99

SELECT*
FROM humanresources.employee
WHERE vacationhours >= 99




-- From employee table, sickleavehours <= 20

SELECT*
FROM humanresources.employee
WHERE sickleavehours <= 20




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: OR clause

-- From employee table, select either Design Engineer or Tool Designer

SELECT*
FROM humanresources.employee
WHERE jobtitle = 'Design Engineer' OR jobtitle = 'Tool Designer';

-- From product, select either Black or Silver

SELECT* 
FROM production.product
where color = 'Black' or color = 'Silver';


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: AND clause

-- From Vendor, preferredvendorstatus and activeflag must be TRUE

SELECT*
FROM purchasing.vendor
WHERE preferredvendorstatus = TRUE AND activeflag = TRUE;

-- From employee, gender must be 'M' and maritalstatus must be 'S'

SELECT*
FROM humanresources.employee
WHERE gender = 'M' OR maritalstatus = 'S';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: Combined OR & AND clause

-- From the employee table pick either, marital status as single and gender male or marital status as married and gender female.

SELECT 
	jobtitle,gender,
	maritalstatus,
	vacationhours,
	sickleavehours
FROM humanresources.employee
WHERE (maritalstatus = 'S' AND gender = 'M') OR (maritalstatus = 'M' AND gender = 'F');


-- Example of poor formatting and logic.
-- From the salesperson table select territory_id either 4 or 6 and salesquota either 250000 or 300000

SELECT*
FROM sales.salesperson
WHERE territoryid = 4 OR territoryid = 6 AND salesquota = 250000 OR salesquota = 300000;


--Note: AND takes higher priority than OR

-- Reformatted version:
-- The importance of having good SQL formatting when writing your SQL code.

SELECT*
FROM sales.salesperson
WHERE (territoryid = 4 OR territoryid = 6) AND (salesquota = 250000 OR salesquota = 300000);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: IN clause
--Q: Find all the employees whose birthdate fall on these dates.

-- '1977-06-06'
-- '1984-04-30'
-- '1985-05-04'


SELECT *
FROM humanresources.employee
WHERE birthdate IN('1977-06-06','1984-04-30','1985-05-04');


-- Find all the middle names that contains either A or B or C.

SELECT * FROM person.person
WHERE middlename IN ('A','B','C');

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: LIKE clause
-- The placement of the wildcard, %, affects what is getting filtered out.

SELECT*
FROM person.person
WHERE firstname LIKE 'J%';

-- From the person table, select all the firstname starting with a 'J'
-- Works very similar to excel find function

-- Find J

-- Only works for string!

SELECT *
FROM humanresources.employee
WHERE birthdate LIKE '1969-01-29';

--The error in your query occurs because the LIKE operator is used incorrectly with a DATE data type. The LIKE operator is intended for string matching, typically with VARCHAR or CHAR fields, 
--not DATE fields. Since birthdate is likely a DATE column, you should use the equality operator (=) to check for an exact match.

SELECT *
FROM humanresources.employee
WHERE birthdate = '1969-01-29';


-- But what if you know the number of letters in the firstname?

SELECT *
FROM person.person
WHERE firstname LIKE 'J___';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What if we want firstnames that contains the letter a inside?

SELECT *
FROM person.person
WHERE firstname LIKE '%a%';

-- not tallying

-- We have two varying results, we can use things like UPPER() and LOWER() clause

--UPPER() does not actually change the data in the rsult set to uppercase, it only uses UPPER() to perform a case-insensitive
--match. So, although UPPER(firstname) converts each firstname to uppercase for comparison purposes, the original casing of firstname is displayed in the results.

SELECT*
FROM person.person
WHERE UPPER(firstname) LIKE '%A%';


--LOWER() does not actually change the data in the rsult set to uppercase, it only uses LOWER() to perform a case-insensitive
--match. So, although LOWER(firstname) converts each firstname to uppercase for comparison purposes, the original casing of firstname is displayed in the results.

SELECT*
FROM person.person
WHERE LOWER(firstname) LIKE '%a%';

--Instead of doing UPPER() or LOWER() , you can just use ILIKE
--The below 2 query are the same , ILIKE is case-insensitive. Does not matter if capital or non-capital

SELECT*
FROM person.person
WHERE firstname ILIKE '%a%'

SELECT*
FROM person.person
WHERE firstname ILIKE '%A%'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: NOT clause

-- From the person table, lastname should not contain A in it.

SELECT*
FROM person.person
WHERE lastname NOT ILIKE '%a%'

-- From the employee table, choose those that do not fall into this data range:
-- '1977-06-06' , '1984-04-30' . '1985-05-04'

SELECT*
FROM humanresources.employee
WHERE birthdate NOT IN ('1977-06-06' , '1984-04-30' ,'1985-05-04');

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- GROUP BY clause: 
-- From employee table, group by gender

--When you use GROUP BY, SQL will:
--1.Identify unique values in the specified column(s).
--2.Group rows with the same values together.
--3.Allow you to perform aggregate calculations on each group if you choose to.

--In SQL, when you use GROUP BY, all columns in the SELECT clause must either be included in the 
--GROUP BY clause or used with an aggregate function (such as COUNT, SUM, AVG, etc.).

SELECT gender
FROM humanresources.employee
GROUP BY gender;

-- From employee table, group by maritalstatus

SELECT maritalstatus
FROM humanresources.employee
GROUP BY maritalstatus;


-- We can also group more than one column
--grouping is performed in the order in which the columns are listed

--How the Grouping Works:
--1.Gender is considered first, grouping rows by each unique gender.
--2.Within each gender group, rows are further grouped by maritalstatus.
--3.Within each gender and maritalstatus group, rows are further grouped by jobtitle

SELECT gender, maritalstatus, jobtitle -- gender , maritalstatus & jobtitle is being used in SELECT 
FROM humanresources.employee
GROUP BY gender,maritalstatus,jobtitle; -- therefore , gender,maritalstatus & jobtitle need to be used in GROUP BY 

SELECT gender, maritalstatus, jobtitle -- gender , maritalstatus & jobtitle is being used in SELECT 
FROM humanresources.employee
GROUP BY gender,maritalstatus; -- since jobtitle is not included in GROUP BY , this will not run


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- All the AGGREGATES!
--COUNT(*) is an aggregate function in SQL that counts the total number of rows in a specified table or result set
--You cannot use GROUPBY on an aggregate function like SUM(), COUNT(), or AVG() directly in the GROUP BY clause in SQL. 
--The GROUP BY clause is meant to specify columns to group the data by, not to perform calculations. 

SELECT 
gender, 
COUNT(*) AS headcount, 
COUNT(DISTINCT jobtitle) AS distinct_jobtitle, 

SUM(vacationhours) AS sum_vacationhours,
AVG(vacationhours) AS avg_vacationhours,

CEILING(AVG(vacationhours)) AS ceiling_vacationhours, --CEILING always rounds up to the nearest whole no.
FLOOR(AVG(vacationhours)) AS floor_vacationhours, -- FLOOR always rounds down to the nearest whole no.
ROUND(AVG(vacationhours)) AS round_avg_vacationhours, -- ROUND folows traditional rounding rules, rounding up if decimal is 0.5 or higher else it rounds down

MAX(sickleavehours) as max_sickleavehours,
MIN(sickleavehours) as min_sickleavehours
FROM humanresources.employee
GROUP BY gender; --Cannot GROUP BY COUNT(*) as it is aggregate function , you can only GROUPBY column

-- Q2: Analyse if the marital status of each gender affects the number of vacation hours one will take
-- A2: Single takes more vacation hours than Married for each gender

SELECT gender,maritalstatus,AVG(vacationhours) as avg_vacationhours
FROM humanresources.employee
GROUP BY 1,2; --You can use 1,2 instead of typing gender,maritalstatus

-- From employee table, ORDER BY hiredate, ASC and DESC

-- hiredate earliest

SELECT*
FROM humanresources.employee
ORDER BY hiredate ASC;


-- hiredate latest

SELECT*
FROM humanresources.employee
ORDER BY hiredate DESC;

-- Sort table using two or more values

SELECT jobtitle,gender
FROM humanresources.employee
ORDER BY jobtitle ASC;

SELECT jobtitle,gender
FROM humanresources.employee
ORDER BY jobtitle ASC,gender DESC;

-- Sorting by Average

SELECT jobtitle,AVG(vacationhours) AS avg_vacationhours
FROM humanresources.employee
GROUP BY jobtitle
ORDER BY AVG(vacationhours) ASC;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HAVING clause:
--The HAVING clause in SQL is used to filter results based on conditions applied to aggregate functions, 
--like SUM, COUNT, AVG, etc. It’s similar to the WHERE clause which filter rows before grouping. 
--HAVING clause filter groups after grouping , so normally it is used alongside GROUPBY


--This syntax still works , but is meaningless since the aggregate function only gives 1 row of output , filtering it by HAVING does not serve much purpose
SELECT AVG(sickleavehours) as avg_sickleavehours
FROM humanresources.employee
HAVING AVG(sickleavehours) > 30;  

SELECT jobtitle,AVG(sickleavehours) as avg_sickleavehours
FROM humanresources.employee
GROUP BY jobtitle
HAVING AVG(sickleavehours) > 50;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: From the customer table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A3:

SELECT territoryid, COUNT(*) AS no_of_customer
FROM sales.customer
WHERE personid IS NOT NULL AND storeid IS NOT NULL
GROUP BY territoryid
HAVING COUNT(*) > 40;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OFFSET: Using the employee table find the other employees except the top 10 oldest employees.

SELECT *
FROM humanresources.employee
ORDER BY birthdate ASC -- This will order from earliest birthdate to oldest birthdate. So the earliest birthdate is the oldest , so we offset the top 10 birthdate
OFFSET 10;


-- Q4: From the salesperson table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A4:




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER

-- Inner join to get product information along with its subcategory name and category name
-- Joining the 3 tables together ,1.product ,2.productsubcategory and 3.productcategory together with INNER JOIN

SELECT *
FROM production.product;

SELECT *
FROM production.productsubcategory;

SELECT *
FROM production.productcategory;

--Joining table (FROM   table 1   INNER JOIN  table 2) ON (Column 1 = Column 2)

SELECT 
product.productid, -- the productid column from the product table
product.name AS product_name, -- the name column from the product table
productcategory.name AS productcategory_name, -- the name column from the productcategory table
productsubcategory.name AS productsubcategory_name -- the name column from the productsubcategory table
FROM production.product -- LEFT CIRCLE 
INNER JOIN production.productsubcategory -- RIGHT CIRCLE
ON product.productsubcategoryid = productsubcategory.productsubcategoryid
INNER JOIN production.productcategory
ON productsubcategory.productcategoryid = productcategory.productcategoryid -- RIGHT CIRCLE
ORDER BY product.productid ASC;

--You cannot have multiple FROM clauses in single query. You need to use JOIN statement to combine multiple table,
--therefore the bottom will not execute
SELECT 
product.productid, 
product.name AS product_name, 
productcategory.name AS productcategory_name, 
productsubcategory.name AS productsubcategory_name
FROM production.product
FROM production.productsubcategory;


-- Let's create a base table in the humanresources schema, where we are able to get each employee's department history and department name

-- Employee table

SELECT *
FROM humanresources.employee;

-- Unique table or?


-- Employee Department History table

SELECT *
FROM humanresources.employeedepartmenthistory;

-- Unique table or?


-- Department table

SELECT *
FROM humanresources.department;



-- Let's find all the employee, their respecitve departments and the time they served there. Bonus if you can find out the duration in days each employee spent
-- in each department! Duration in days cannot be NULL.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JOINS: LEFT

-- List all products along with their total sales quantities, including products that have never been sold. 
-- For products that have not been sold, display the sales quantity as zero.
-- Sort by total orders descending

SELECT *
FROM production.product;

SELECT *
FROM sales.salesorderdetail


/*
In SQL, the COALESCE function returns the first non-null value from a list of arguments. 
It’s commonly used to handle null values in query results by providing a fallback or default value

E.g COALESCE(SUM(salesorderdetail.orderqty),0) 
SUM(salesorderdetail.orderqty) , if the sum value is null , it is replaced with the default value 0.
*/

SELECT 
product.productid, 
product.name AS productname, 
COALESCE(SUM(salesorderdetail.orderqty),0) AS totalsalesquantity
FROM production.product AS product
LEFT JOIN sales.salesorderdetail AS salesorderdetail
ON product.productid = salesorderdetail.productid
GROUP BY product.productid, product.name
ORDER BY COALESCE(SUM(salesorderdetail.orderqty),0) DESC;


-- Q5: List all employees and their associated email addresses,  
-- display their full name and email address.

SELECT*
FROM humanresources.employee

SELECT*
FROM person.person

SELECT*
FROM person.emailaddress;

SELECT
CONCAT(person.firstname, ' ',person.middlename, ' ',person.lastname) AS fullname,
emailaddress.emailaddress AS email

FROM humanresources.employee AS employee
LEFT JOIN person.person AS person
ON employee.businessentityid = person.businessentityid
LEFT JOIN person.emailaddress AS emailaddress
ON employee.businessentityid = emailaddress.businessentityid;

SELECT*

FROM humanresources.employee AS employee
LEFT JOIN person.person AS person
ON employee.businessentityid = person.businessentityid
LEFT JOIN person.emailaddress AS emailaddress
ON employee.businessentityid = emailaddress.businessentityid;

-- Retrieve a list of all individual customers id, firstname along with the total number of orders they have placed 
-- and the total amount they have spent, removing customers who have never placed an order. 

SELECT *
FROM person.person;

SELECT *
FROM sales.customer;

SELECT *
FROM sales.salesorderheader
ORDER BY customerid;

SELECT
customer.customerid,
person.firstname,
COUNT(salesorderid) AS purchases, -- does not need to specify table name as there is no ambiguity , there is no column salesorderid in any other table except salesorderheader
ROUND(SUM(subtotal),2) AS cost -- does not need to specify table name as there is no ambiguity , there is no column subtotal in any other table except salesorderheader

FROM sales.customer AS customer 
LEFT JOIN person.person AS person
ON customer.personid = person.businessentityid -- how do you know person id in customer table relates to businessentityid in person table??
LEFT JOIN sales.salesorderheader AS salesorderheader
ON customer.customerid = salesorderheader.customerid
GROUP BY customer.customerid, person.firstname
HAVING ROUND(SUM(subtotal),2) IS NOT NULL;




/*
Q6: Can LEFT JOIN cause duplication? How?
A6: It depends on both the relationship that both the tables present from the left join share.
If it is a 1-to-1 relationship , the chances of having duplicate is unlikely
However if it is one to many relationship , there could be chance for duplicate to be present.
*/


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: RIGHT
-- Write a query to retrieve all sales orders and their corresponding customers. If a sales order exists without an associated customer, 
-- include the sales order in the result.

SELECT*
FROM sales.salesorderheader

SELECT*
FROM sales.customer

SELECT 
salesorderheader.salesorderid AS salesorderid, 
salesorderheader.orderdate AS orderdate,
customer.customerid AS customerid,
customer.personid AS personid
FROM sales.customer AS customer  
RIGHT JOIN sales.salesorderheader AS salesorderheader
ON customer.customerid  = salesorderheader.customerid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: FULL OUTER JOIN

-- Write a query to find all employees and their corresponding sales orders. If an employee doesn’t have any sales orders, 
-- still include them in the result, and if there are sales orders without an associated employee, include those as well.

SELECT*
FROM humanresources.employee AS employee

SELECT*
FROM sales.salesorderheader


SELECT 
employee.businessentityid AS employeeid,
salesorderheader.salesorderid AS salesorderid
FROM humanresources.employee AS employee
FULL OUTER JOIN sales.salesorderheader AS salesorderheader
ON employee.businessentityid = salesorderheader.salespersonid;

		
-- Write a query to retrieve a list of all employees and customers, and if either side doesn't have a FirstName, 
-- use the available value from the other side. Use FULL OUTER JOIN and COALESCE.

SELECT *
FROM humanresources.employee;



						 
-- Write a query to list all employees along with their associated sales orders. Include employees who may not have any sales orders. 
-- Use the COALESCE function to handle NULL values in the SalesOrderID column.

SELECT

FROM humanresources.employee AS employee

ORDER BY employee.employeeid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: CROSS JOINS

-- Explanation: A CROSS JOIN in SQL combines every row from the first table with every row from the second table. This type of join creates a Cartesian product, 
-- meaning that if the first table has 10 rows and the second table has 5 rows, the result will have 10 * 5 = 50 rows. 
-- A CROSS JOIN does not require any relationship or matching columns between the two tables.

-- Example: Good for arranging one person to meet multiple people

-- Write a query to generate all possible combinations of product categories and product models. Show the category name and the model name.

SELECT*
FROM production.productcategory AS productcategory


SELECT*
FROM production.productmodel AS productmodel 


SELECT 
productcategory.name AS categoryname,
productmodel.name AS modelname
FROM production.productcategory AS productcategory
CROSS JOIN production.productmodel AS productmodel
ORDER BY productcategory.name ASC;






-- Each category name is matched to each model name

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION, stacking the tables on top of each other without having duplicates

SELECT firstname,lastname,CONCAT(firstname, ' ',lastname) AS fullname
FROM person.person
UNION 
SELECT firstname,lastname,CONCAT(firstname, ' ',lastname) AS fullname
FROM person.person;

-- Union them together segregating employee and customer

SELECT *
FROM person.person;

SELECT*
FROM humanresources.employee;

SELECT *
FROM sales.customer;

SELECT 
firstname,
lastname,
CONCAT(firstname, ' ',middlename,' ',lastname) AS fullname,
'Employee' AS category -- 'Employee' are literal strings (fixed text value) that are added to each row in the result , the column alias name is category
FROM person.person AS person
INNER JOIN humanresources.employee AS employee
ON person.businessentityid = employee.businessentityid

UNION

SELECT 
firstname,
lastname,
CONCAT(firstname, ' ',middlename,' ',lastname) AS fullname,
'Customer' AS category -- 'Customer' are literal strings (fixed text value) that are added to each row in the result , the column alias name is category
FROM person.person AS person
INNER JOIN sales.customer AS customer
ON person.businessentityid = customer.personid
WHERE customer.storeid IS NULL;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION ALL: EVERYTHING

-- Write a query to retrieve all sales orders and purchase orders, displaying the order ID and order date. 
-- Use UNION ALL to combine the sales and purchase order data, keeping all duplicates.

SELECT 
	salesorderid, 
	orderdate
FROM sales.salesorderheader

UNION ALL

SELECT 
	purchaseorderid, 
	orderdate
FROM purchasing.purchaseorderheader;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STRING FUNCTION
-- DATE handling, CONCAT()

-- Getting parts of the date out

SELECT*
FROM sales.salesorderheader

SELECT 
	orderdate,
	EXTRACT(YEAR FROM orderdate) AS year,
	EXTRACT(QUARTER FROM orderdate) AS QUARTER,
	EXTRACT(MONTH FROM orderdate) AS MONTH,
	EXTRACT(WEEK FROM orderdate) AS WEEK,
	EXTRACT(DAY FROM orderdate) AS DAY,
	EXTRACT(MINUTE FROM orderdate) AS MINUTE,
	EXTRACT(SECOND FROM orderdate) AS SECOND,

-- The CAST function is used to convert a data type into another date type
--CAST(orderdate AS TIME) AS time: Converts the orderdate column to the TIME data type, extracting only the time portion.
--CAST(orderdate AS DATE) AS date: Converts the orderdate column to the DATE data type, extracting only the date portion.
CAST(orderdate AS TIME) AS time,
CAST(orderdate AS DATE) AS date

FROM sales.salesorderheader;

-- DATETIME manipulations

SELECT*
FROM sales.salesorderheader

SELECT
orderdate AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Singapore' AS local_time, -- Time difference between UTC AND SGT: Singapore Time is 8 hrs ahead of UTC. 
--If UTC is 00:00:00 , SGT is 08:00:00
CURRENT_DATE AS today, --The CURRENT_DATE function gets today's date from the system clock of the database server. 
CURRENT_DATE + INTERVAL '10 days' AS add_days,
CURRENT_DATE - INTERVAL '10 days' AS minus_days,
CURRENT_DATE + INTERVAL '1 month' AS add_month
FROM sales.salesorderheader
WHERE territoryid = 1 AND EXTRACT(YEAR FROM orderdate) = 2011;

-- Use string functions to format employee names and email addresses
SELECT
CAST(person.businessentityid AS INT),
CAST(person.businessentityid AS numeric) /2 AS numeric_id,
CAST(person.businessentityid AS decimal) /2 AS decimal_id,
CAST(person.businessentityid AS VARCHAR(50)) AS varchar,
person.firstname AS first_name,
person.lastname AS last_name,
UPPER(person.lastname) AS upperlastname,
LOWER(person.lastname) AS lowerlastname,
LENGTH(person.firstname) AS firstnamelength,

LEFT(emailaddress.emailaddress, 10) AS startemail,
RIGHT(emailaddress.emailaddress, 10) AS lastemail,
SUBSTRING(emailaddress.emailaddress, 1,5) AS partialemail_start,
SUBSTRING(emailaddress.emailaddress, 3,5) AS partialemail_middle,
emailaddress.emailaddress AS old_email,
REPLACE(emailaddress.emailaddress, '@adventure-works.com','@gmail.com') AS new_email

FROM person.person AS person
INNER JOIN person.emailaddress AS emailaddress
ON person.businessentityid = emailaddress.businessentityid;

/*
CAST()
UPPER()
LOWER()
LENGTH()
LEFT()
RIGHT()
SUBSTRING()
REPLACE()
CONCAT()
*/


-- From the following table write a query in  SQL to find the  email addresses of employees and groups them by city. 
-- Return top ten rows.

SELECT 
	address.city
FROM 
	person.businessentityaddress AS businessentityaddress  
INNER JOIN 
	person.address AS address


GROUP BY 
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASE FUNCTION: CASE WHEN THEN ELSE END

-- Categorize products based on their list price
SELECT*
FROM production.product

SELECT 
	productid,
	name,
	listprice,
	CASE 
	WHEN listprice = 0 THEN 'Free'
	WHEN listprice < 50 THEN 'Budget'
	WHEN listprice BETWEEN 50 AND 1000 THEN 'Mid-Range'
	ELSE 'Premium'
	END AS price_catgory

FROM production.product
ORDER BY listprice DESC;

-- Write a query to categorize sales orders based on the total amount (TotalDue). If the total amount is less than 1000, categorize it as "Low", 
-- if it's between 1000 and 5000, categorize it as "Medium", and if it's greater than 5000, categorize it as "High".

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.totaldue AS totaldue,

FROM sales.salesorderheader AS salesorderheader;

-- Q7: Write a query to calculate bonuses for each employee. The bonus is calculated based on both their total sales and their length of employment:

-- If an employee has sales greater than 500,000 and has been employed for more than 5 years, they get a 15% bonus.
-- If their sales are greater than 500,000 but they’ve been employed for less than 5 years, they get a 10% bonus.
-- If their sales are between 100,000 and 500,000, they get a 5% bonus, regardless of years of service.
-- If their sales are less than 100,000, they get no bonus.

-- A7:


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- If time permits:
-- Window Functions
-- AGGREGATE

-- Explanation:
/*
A window function in SQL allows you to perform calculations across a set of table rows that are somehow related to the current row. 
Unlike regular aggregate functions (such as SUM, COUNT, AVG), window functions do not group the result into a single output. 
Instead, they return a value for every row while using a "window" of rows to perform the calculation.
*/

-- Let’s say we want to calculate the running total of sales for each salesperson, partitioned by their ID (so each salesperson gets their own total), 
-- and ordered by the order date.



-- Retrieving distinct active employee names along with salary statistics per department:


	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------