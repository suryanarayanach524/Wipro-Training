-- ACTIVITY: “Build a Food Delivery Database”
--  Objective
-- Students will:
-- Design a table structure
-- Create tables using SQL (DDL)
-- Insert real-world data (DML)
-- Understand relationships between tables

-- CASE STUDY: FOOD DELIVERY APP
-- You are working as a Database Developer for a startup called QuickBite 
-- The app needs to store:
-- Customers
-- Restaurants
-- Orders

--  REQUIREMENT
--  
-- Design a database to handle:
-- 1️ Customers
-- customer_id
-- name
-- email
-- city

-- 2️ Restaurants

-- restaurant_id
-- name
-- cuisine_type
-- city

-- 3️ Orders
-- order_id
-- customer_id
-- restaurant_id
-- order_amount
-- order_date


show databases;
create database food_delivery;
use  food_delivery;

create table customers(customer_id int,name varchar(30),email varchar(50),city varchar(20));
create table restaurants(restaurant_id int,name varchar(30),cuisine_type varchar(30),city varchar(20));
create table orders(order_id int,customer_id int,restaurant_id int,order_amount int,order_date date);

insert into customers values(1,"Surya","Surya@gmail.com","Hyderabad");
insert into customers values(2,"Pavan","pavan@gmail.com","Bangalore");
insert into customers values(3,"Siri","siri@gmail.com","Chennai");
select * from customers;
insert into restaurants values(101,"Oura","Indian","Hyderabad");
insert into restaurants values(102,"Pista House","Chinese","Hyderabad");
insert into restaurants values(103,"Paradise","Indian","Hyderabad");
insert into restaurants values(104,"Pizza World","Indian","Hyderabad");
insert into restaurants values(104,"Dominos","Indian","Bangalore");
select * from restaurants;
insert into orders values(1001,1,101,1000,"2026-04-28");
insert into orders values(1002,2,102,2000,"2025-01-11");
insert into orders values(1003,3,103,1500,"2026-04-28");

select * from orders;


create table employees(emp_id int , emp_name varchar(30) ,password varchar(40) not null ,
 emp_dept varchar(40) not null  ,salary int);
 insert into employees values(101, "Surya" , "surya@123" , "Training" , 50000),
							(102, "Pavan" , "pavan@123" , "Admin" , 60000),
                            (103, "Siri" , "siri@123" , "Finance" , 80000),
                            (104, "Venkat" , "venkat@123" , "Finance" , 80000);
                            




-- TASK: WRITE QUERIES BASED ON USE CASES
--  PART 1: SELECT QUERIES (READ OPERATIONS)
--  Use Case 1: View all customers
--  “Show all registered customers”
select *from customers;
--  Use Case 2: Customers from a specific department
--  “Show employees who are in Finance Department”
select * from employees where emp_dept="Finance";
--  Use Case 3: High-value salary
--  “Show salary above ₹60000”
select * from employees where salary>60000;
--  Use Case 4: Orders placed on a specific date
--  “Find orders placed on 2025-01-11”
select * from orders where order_date ="2025-01-11";
--  Use Case 5: Sort orders by amount
--  “Show all employee names sorted by highest salary”
select emp_name from employees order by salary desc;
--  Use Case 6: Limited results (Top orders)
--  “Show top 2 highest paid salary"
select salary from employees order by salary desc limit 2;


--  PART 2: UPDATE QUERIES (MODIFY DATA)
--  Use Case 7: Employee changes to city
--  “Ravi moved from Delhi to Pune”


--  Use Case 8: Restaurant updates cuisine
--  “Pizza World now serves Fast Food”
update restaurants set cuisine_type="Fast Food" where name="Pizza World";
set sql_safe_updates=0;
select * from restaurants;
--  Use Case 9: Order amount correction
--  “Order 1001 amount updated to ₹550”
update orders set order_amount=550 where order_id=1001;
select * from orders;
-- Quick Reminder
--  Always use Where
--  Without it → entire table updates (real production disaster!)


--  PART 3: DELETE QUERIES (REMOVE DATA)
--  Use Case 10: Customer account deletion
--  “Delete customer with ID 3”
delete from customers where customer_id=1;
select * from customers;
--  Use Case 11: Cancel an order
--  “Order 1002 got cancelled”
delete from orders where order_id=1001;
select * from orders;
--  Use Case 12: Remove inactive restaurants
--  “Delete restaurants from Bangalore”
delete from restaurants where city="Bangalore";
select * from restaurants;
-- Quick Reminder
-- Always check before delete:

-- ALTER COMMANDS

update employees set joiningdate = now() where salary = 50000;
update employees set joiningdate = "2026-04-10 15:31:58" where salary = 60000;
update employees set joiningdate = "2026-04-15 15:31:58" where salary = 80000;


rename table employees to emp;
select * from emp;

alter table emp_data modify column emp_id int auto_increment primary key;
describe emp_data;


alter table emp_data rename column joinin_date to joining_datetime;

-- TRUNCATE,DELETE AND DROP 
create table users(emp_id int ,username varchar(30) , role varchar(30));
insert into users values(1, "Surya","developer"),(2 , "Pavan" , "Tester");
select * from users;

drop table users;

truncate users; 

delete from users where emp_id=1; 


