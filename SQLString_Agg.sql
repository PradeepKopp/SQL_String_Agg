select * from employee;

alter table  employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate())

/*1- write a query to print emp name , their manager name and diffrence in their age (in days) 
for employees whose year of birth is before their managers year of birt */

Select e1.emp_name, e2.emp_name as manager_name, DATEDIFF(DAY, e1.dob, e2.dob) as age_diff_days
from employee e1 inner join employee e2 on 
e1.manager_id =e2.emp_id 
where DATEPART(year,e1.dob)<DATEPART(year, e2.dob);

/*2- write a query to find subcategories
who never had any return orders in the month of november (irrespective of years) */

Select * from Orders
select * from returns

select o.sub_category
from Orders o left join returns r on o.order_id = r.[Order Id]
where datepart(month,o.order_date)=11 
group by o.sub_category
having COUNT(r.[Order Id]) =0;

/*3- orders table can have multiple rows for a particular order_id 
when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer. */

select order_id from Orders
group by order_id
having COUNT(*)=1;

select order_id
from Orders
group by order_id
having count(1)=1

/*4- write a query to print manager names along 
with the comma separated list(order by emp salary) 
of all employees directly reporting to him. */

select e2.emp_name as Manager_name, STRING_AGG(e1.emp_name, ',') within group (order by e1.salary)
from employee e1 inner join employee e2 on e1.manager_id= e2.emp_id 
group by e2.emp_name

select * from employee;


/*5- write a query to get number of business days between order_date 
and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only */


select order_id,order_date,ship_date ,datediff(day,order_date,ship_date)-2*datediff(week,order_date,ship_date) as no_of_business_days
from 
Orders

/*6- write a query to print 3 columns : category, total_sales 
and (total sales of returned orders) */

select o.category, SUM(o.sales), SUM(case when r.[Order Id]is not null then sales end) as Return_sales 
from Orders o left join returns r 
 on o.order_id= r.[Order Id]
 group by category;


select o.category,sum(o.sales) as total_sales
,sum(case when r.[Order Id] is not null then sales end) as return_orders_sales
from Orders o
left join returns r on o.order_id=r.[Order Id]
group by category

/*7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020) */

select category, sum(case when DATEPART(year, order_date) =2019 then sales end) as Total_sales_2019,
SUM(case when datepart(year, order_date) =2020 then sales end) as Total_sales_2020 from Orders
group by category



/*8- write a query print top 5 cities in west region 
by average no of days between order date and ship date. */


select top 5 city, AVG(datediff(day, order_date, ship_date)) as Avg_days
from Orders 
where region= 'West'
group by city 
order by Avg_days desc;

/*9- write a query to print emp name, manager name and 
senior manager name (senior manager is manager's manager) */

select e1.emp_name, e2.emp_name as Manager_name, e3.emp_name as Top_Manager
from employee e1 inner join employee e2 
on e1.manager_id =e2.emp_id inner join employee e3 
on e2.manager_id= e3.emp_id;

