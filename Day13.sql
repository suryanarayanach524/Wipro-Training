create database ems;
use ems;
-- CONSTRAINTS (DEFAULT,UNIQUE,NOT NULL,CHECK)
create table cartitems(item_id int auto_increment primary key,
                       item_name varchar(200) not null,
                       item_qty int not null,
                       sales_tax dec(5,2) not null default 0.1,
                        constraint chkqty check (item_qty >0),
					    constraint chkst check(sales_tax >=0));
describe cartitems;

insert into cartitems values(101 , "Surya" , 1 , 0.3 );
insert into cartitems(item_id , item_name , item_qty) values(2 , "Pavan",4);
select * from cartitems;
-- drop table cartitems;
-- dropping a constraint
alter table cartitems drop constraint chkqty;
-- to show all the constraints or table query 
show create table cartitems;   -- it returns the syntax of the table creation
    
show tables;
show databases;
use ems;

-- this query is use to get the constraint details 
select * from information_schema.check_constraints where constraint_schema = "ems" ;



-- Joins --
-- Inner join , left join , right join , full outer join , cross join 
create table department(dept_id int primary key , dept_name varchar(10));
create table employee(emp_id int primary key , emp_name varchar(20) , dept_id int , 
						foreign key(dept_id) references department(dept_id));


insert into department values (10 , "HR") , (20 , "IT") , (30, "Sales");
insert into department values (40 , "Admin") , (50 , "Training") , (60, "Finance");
select * from department;

insert into employee values(101 , "Surya" ,10),(102 , "Pavan" ,20),(103 , "Siri" ,30),(104 , "Venkat" ,10);
select * from  employee;

-- INNER JOIN
select  employee.emp_name , department.dept_name  
from  employee inner join department   
on  employee.dept_id = department.dept_id ;

-- or (by giving alias names)
select d.dept_id , emp_name , dept_name  
from  employee e inner join department  d 
on  e.dept_id = d.dept_id ;

-- RIGHT JOIN
select d.dept_id , emp_name , dept_name  
from  employee e right join department  d 
on  e.dept_id = d.dept_id ;

 -- LEFT JOIN 
 select d.dept_id , emp_name , dept_name  
from  employee e left join department  d 
on  e.dept_id = d.dept_id ;




-- full outer join --
select  e.emp_name , d.dept_name  
from  employee e left join department  d 
on  e.dept_id = d.dept_id 
union 
select  e.emp_name , d.dept_name  
from  employee e right join department  d 
on  e.dept_id = d.dept_id ;


-- self join ---
create table empmanager(empid int , name varchar(30) , manager_id int);

insert into empmanager(empid , name) values (1 , "Niti");
insert into empmanager values (2 , "Jiya" , 1) , (3,"Shubham" ,2) , (4,"Richa" ,1); 

select * from empmanager;

-- If we want to display the manager name for a employee 
 select  e1.name as employeename , e2.name as managername 
 from empmanager e1 left join empmanager e2  
 on e1.manager_id = e2.empid;
 
 -- Subquery (Non-Correlated) --
 -- Correlated query --
create table salary (
    emp_id int primary key,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2));
INSERT INTO salary VALUES
(101,'Surya',50000),
(102,'Pavan',45000),
(103,'Siri',60000),
(104,'Venkat',70000),
(105,'Budha',55000);
    
 
 -- Subquery -- A query inside a query where inner query is independent to a outer query 
 
 -- scalar query -- when it will return the single value as a result 
 select emp_name from employee where salary > (select avg(salary) from salary);
 select * from salary;
 
 select e.emp_name from employee e inner join salary  s
 on e.emp_id = s.emp_id  
 where s.salary > (select avg(salary ) from salary);
 
 -- Multi row -- when it will return single column with multiple rows (like a list) that we can achieve using IN , NOTIN  , ANY , ALL
 select * from department;
 select * from employee;
 select dept_id  from department where dept_name in ('Sales' , 'Admin');
 
select e.emp_name from employee e where dept_id in( select dept_id  from department where dept_name in ('Sales' , 'IT'));

-- use case -- find all employees whose salary is greater than any salary in the sales department

select * from employee where salary > any(select salary from employee where dept_id=30);



-- QuickBite Case Study – SQL Activity (Joins + Subqueries)
-- Context
-- QuickBite is a food delivery platform. You are working as a data analyst and need to extract insights using SQL.

--  Tables
-- customers
-- customer_id | customer_name | city
-- restaurants
-- restaurant_id | restaurant_name | city
-- orders
-- order_id | customer_id | restaurant_id | order_amount | order_date

-- create table customers(customer_id int,name varchar(30),email varchar(50),city varchar(20));
-- create table restaurants(restaurant_id int,name varchar(30),cuisine_type varchar(30),city varchar(20));
-- create table orders(order_id int,customer_id int,restaurant_id int,order_amount int,order_date date);


create database quick_bite;
use quick_bite;
CREATE TABLE CUSTOMERS (CUSTOMER_ID INT PRIMARY KEY,CUSTOMER_NAME VARCHAR(30),CITY VARCHAR(20));
describe CUSTOMERS;
CREATE TABLE RESTAURANTS(RESTAURANT_ID INT PRIMARY KEY,RESTAURANT_NAME VARCHAR(30),CITY VARCHAR(20));
DESCRIBE RESTAURANTS;
CREATE TABLE ORDERS(ORDER_ID INT PRIMARY KEY,CUSTOMER_ID INT,RESTAURANT_ID INT,ORDER_AMOUNT INT,
                    ORDER_DATE DATE, FOREIGN KEY(CUSTOMER_ID) references CUSTOMERS(CUSTOMER_ID),
                    FOREIGN KEY(RESTAURANT_ID) REFERENCES RESTAURANTS(RESTAURANT_ID));
                    
INSERT INTO CUSTOMERS VALUES
(1, 'Surya', 'Hyderabad'),
(2, 'Pavan', 'Bangalore'),
(3, 'Siri', 'Hyderabad'),
(4, 'Venkat', 'Chennai'),
(5, 'Budha', 'Mumbai');
SELECT * FROM CUSTOMERS;

INSERT INTO RESTAURANTS VALUES
(101, 'Spicy Hub', 'Hyderabad'),
(102, 'Food Palace', 'Bangalore'),
(103, 'Tasty Treat', 'Chennai'),
(104, 'Urban Bites', 'Mumbai'),
(105, 'Dine Heaven', 'Delhi');
SELECT * FROM RESTAURANTS;

INSERT INTO ORDERS VALUES
(1001, 1, 101, 500, '2026-04-20'),
(1002, 2, 102, 800, '2026-04-21'),
(1003, 3, 101, 300, '2026-04-22'),
(1004, 1, 103, 700, '2026-04-23'),
(1005, 4, 103, 600, '2026-04-24'),
(1006, 2, 104, 900, '2026-04-25'),
(1007, 3, 101, 400, '2026-04-26');
SELECT * FROM ORDERS;
                    


--  ACTIVITY 1 – JOINS (ALL TYPES)
--  Q1. INNER JOIN
--  Display customer name, restaurant name, and order amount
SELECT C.CUSTOMER_NAME,R.RESTAURANT_NAME,O.ORDER_AMOUNT
FROM CUSTOMERS C
INNER JOIN ORDERS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
INNER JOIN RESTAURANTS R
ON R.RESTAURANT_ID=O.RESTAURANT_ID;

--  Q2. LEFT JOIN
--  Display all customers and their orders (even if no orders)
SELECT C.*,O.*
FROM CUSTOMERS C 
LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID=O.CUSTOMER_ID;

--  Q3. RIGHT JOIN
--  Display all restaurants and orders (even if no orders placed)
SELECT R.*,O.*
FROM RESTAURANTS R 
RIGHT JOIN ORDERS O 
ON R.RESTAURANT_ID=O.RESTAURANT_ID;

--  Q4. FULL OUTER JOIN (MySQL workaround)
--  Display all customers and orders (matched + unmatched)
SELECT C.*,O.*
FROM CUSTOMERS C
LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID=O.CUSTOMER_ID
UNION
SELECT C.*,O.*
FROM CUSTOMERS C
RIGHT JOIN ORDERS O 
ON C.CUSTOMER_ID=O.CUSTOMER_ID;


--  Q5. SELF JOIN
--  Find customers from the same city
SELECT C1.*
FROM CUSTOMERS C1
JOIN CUSTOMERS C2
ON C1.CITY = C2.CITY;

--  ACTIVITY 2 – SUBQUERIES
--  Q6.
--  Find customers who placed orders above average order amount
SELECT DISTINCT C.CUSTOMER_NAME
FROM CUSTOMERS C
JOIN ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.ORDER_AMOUNT > (
    SELECT AVG(ORDER_AMOUNT)
    FROM ORDERS
);

-- Q7.
--  Display restaurants that have received at least one order
SELECT DISTINCT R.RESTAURANT_NAME
FROM RESTAURANTS R
JOIN ORDERS O
ON R.RESTAURANT_ID = O.RESTAURANT_ID;


-- Q8.
--  Find the customer who made the highest order
SELECT C.CUSTOMER_NAME, O.ORDER_AMOUNT
FROM CUSTOMERS C
INNER JOIN ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
ORDER BY O.ORDER_AMOUNT DESC
LIMIT 1;


--  ACTIVITY 3 – CORRELATED SUBQUERIES
--  Q9.
--  Find customers whose order amount is greater than their own average order amount
SELECT DISTINCT C.CUSTOMER_NAME
FROM CUSTOMERS C
INNER JOIN ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.ORDER_AMOUNT > (
    SELECT AVG(O2.ORDER_AMOUNT)
    FROM ORDERS O2
    WHERE O2.CUSTOMER_ID = O.CUSTOMER_ID
);

--  Q10.
--  Find restaurants whose average order amount is greater than overall average
SELECT R.RESTAURANT_NAME, AVG(O.ORDER_AMOUNT) AS AVG_ORDER
FROM RESTAURANTS R
INNER JOIN ORDERS O
ON R.RESTAURANT_ID = O.RESTAURANT_ID
GROUP BY R.RESTAURANT_ID, R.RESTAURANT_NAME
HAVING AVG(O.ORDER_AMOUNT) > (
    SELECT AVG(ORDER_AMOUNT)
    FROM ORDERS
);
