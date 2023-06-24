create database library;
use library;

/* creating table branch*/
create table branch
(branch_no int primary key,
manager_id int,
branch_address varchar(30),
contact_no int );

/*creating table employee*/
create table employee
(emp_id int primary key,
emp_name varchar(30),
position varchar(30),
salary decimal(20,4));

/* creating table customer */
create table customer
(customer_id int primary key,
customer_name varchar(30),
customer_address varchar(30),
reg_date date);

/* creating table issuestatus */
create table issuestatus
(issue_id int primary key ,
issue_cust int,
issued_book_name varchar(30),
issue_date date,
isbn_book int,
foreign key (issue_cust) references customer(customer_id),
foreign key (isbn_book) references books (isbn));

/* creating table returnstatus */
create table returnstatus
(return_id int primary key,
return_cust varchar(30),
return_book_name varchar(30),
return_date date,
isbn_book2 int,
foreign key (isbn_book2) references books (isbn) on delete cascade);

/* creating table books */
create table books
(isbn int primary key,
book_title varchar(30),
category varchar(30),
rental_price decimal(10,2),
status varchar(30),
author varchar(30),
publisher varchar(30));

/* inserting values into table branch */
insert into branch values 
(1,100,'main street',85678567),
(2,101,'121 red lane',986589543),
(3,102,'amity road',88706873),
(4,103,'down street',809213493),
(5,104,'aine villa road',905643786);

/* inserting values into table employee*/
insert into employee values 
(200,'cedric','manager',45000),
(201,'ryan','assistant',20000),
(202,'robert','accounting',30000),
(203,'emma','outreacher',40000),
(204,'sana','director',38000);

/* inserting values into table customer*/
insert into customer values 
(300,'andrew','elm street','2022-12-02'),
(301,'sakib','avenue villas','2021-01-04'),
(302,'sheza','121 tulip apartment','2023-02-06'),
(303,'zayn','green villa','2022-11-09'),
(304,'lola','spring lane','2022-02-14');

/* inserting values into table issue status*/
insert into issuestatus values 
(400,300,'Da vinci code','2023-05-02',1000),
(401,301,'The alchemist','2023-01-04',1100),
(402,302,'It ends with us','2023-06-06',1200),
(403,303,'Pride and prejudice','2023-03-09',1300),
(404,304,'The summer i turned pretty','2023-02-10',1400);

/* inserting values into table books*/
insert into books values 
(1000,'Da vinci code','mystery',150,'no','Dan brown','doubleday'),
(1100,'The alchemist','adventure',70,'yes','Paulo coelho','harper torch'),
(1200,'It ends with us','romance',120,'no','Colleen hoover','simon&schuster'),
(1300,'Pride and preudice','drama',99,'no','Jane austen','simon&schuster'),
(1400,'The summer i turned pretty','romance',100,'yes','Jenny han','simon&schuster');

/* inserting values into table return status*/
insert into returnstatus values 
(500,010,'Da vinci code','2023-07-01',1000),
(501,020,'The alchemist','2023-05-19',1100),
(502,030,'It ends with us','2023-07-10',1200),
(503,040,'Pride and prejudice','2023-08-08',1300),
(504,050,'The summer i turned pretty','2023-05-17',1400);

/* write following queries*/

#1.Retrieve the book title, category, and rental price of all available books.
select book_title,category,rental_price 
from books;

#2.List the employee names and their respective salaries in descending order of salary
select emp_name,salary  
from employee 
order by salary desc;

#3.Retrieve the book titles and the corresponding customers who have issued those books
select issuestatus.issued_book_name ,customer.customer_name 
from issuestatus
join customer on issuestatus.issue_cust=customer.customer_id;

#4. Display the total count of books in each category.
select category,count(*) as total_count
from books
group by category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
select emp_name,position
from employee
where salary>50000;

#6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
select customer.customer_name
from issuestatus
join customer on issuestatus.issue_cust=customer.customer_id
where reg_date < '2022-01-01' and customer_id not in (select issue_cust from issuestatus);

#7. Display the branch numbers and the total count of employees in each branch.
select branch.branch_no,count(*)
from branch
join employee on branch.manager_id= employee.emp_id 
group by branch.branch_no;

#8. Display the names of customers who have issued books in the month of June 2023
select customer.customer_name
from issuestatus
join customer on issuestatus.issue_cust=customer.customer_id
where issue_date between '2023-06-01' and '2023-06-30';

#9.Retrieve book_title from book table containing history.
select book_title
from books 
where category='history';

#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select branch.branch_no,count(*) as emp_count
from branch
join employee on branch.manager_id= employee.emp_id 
group by branch.branch_no
having emp_count>5;
