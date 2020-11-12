-- Lab | SQL Iterations


-- Write a query to find what is the total business done by each store.
select staff_id as store, sum(amount) as total_business 
from payment 
group by store ; 


-- Convert the previous query into a stored procedure.
drop procedure if exists total_business_store;

delimiter //
create Procedure total_business_store()
begin
select staff_id as store, sum(amount) as total_business 
from payment 
group by store;
end;
//
delimiter ;

call total_business_store();

-- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
drop procedure if exists total_business_store2;

delimiter //
create Procedure total_business_store2 (in param int)
begin
select staff_id as store, sum(amount) as total_business 
from payment 
where staff_id COLLATE utf8mb4_general_ci = param
group by store;
end;
//
delimiter ;

call total_business_store2(1);


-- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.

drop procedure if exists total_business_store3;

delimiter //
create procedure total_business_store3 (in store_in int)
begin
declare total_business float default 0.0;
select sum(amount) into total_business 
join store s on s.manager_staff_id = p.staff_id
where s.store_id = store_in
group by s.store_id;
select store_in, total_busines;
end;
//
delimiter ;

call total_business_store3(1);


-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.


drop procedure if exists total_business_store4;

delimiter //
create procedure total_business_store4 (in store_in int)
begin
declare total_business float default 0.0;
declare flag char(10) default '';
select sum(amount) into total_business 
join store s on s.manager_staff_id = p.staff_id
where s.store_id = store_in
group by s.store_id;
case 
when total_business > 30.000 
then set flag = 'Green';
else set flag = 'Red';
end case;
select store_in, total_busines, flag;
end;
//
delimiter ;

call total_business_stor4(1);