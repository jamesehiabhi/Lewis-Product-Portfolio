-- Question 1(CASE and WHEN fnx)
--||How much revenue did we generate from each product category.
--After considering a 105 discount for products that cost more than $100,
--and a 5% discount for products that cost between $50 and $100?||

select "ProductCategory", 
		sum("Price" * "Quantity") as revenue
from orders
join products on orders."ProductID" = products."ProductID"
group by "ProductCategory";
------------------------------------------------------------------
select "ProductCategory", 
		sum(case
				when "Price" > 100 then "Price" * 0.9 * "Quantity"
				when "Price" between 50 and 100 then "Price" * 0.95 * "Quantity"
				else "Price" * "Quantity"
				end) as "discounted revenue"
from orders
join products on orders."ProductID" = products."ProductID"
group by "ProductCategory";


--Question 2 (COALESCE fnx)
--What is the total revenue generated,
--considering that products with a NULL price should be treated as having a default price of $10?

select sum(coalesce("Price", 10) * "Quantity")
from orders
join products on orders."ProductID" = products."ProductID";
-------------------------------------------------------------------
select sum(coalesce("Price", 10) * orders."Quantity") as "Total revenue"
from orders
join products on orders."ProductID" = products."ProductID";


--Question 3 (CAST fnx)
--How many orders were placed in the year 2015? 

select count (distinct "OrderID")
from orders
where cast("OrderDate" as date) between '2015-01-01' and '2015-12-31';
------------------------------------------------------------------------
select count (distinct "OrderID")
from orders
where cast("OrderDate" as text) between '2015-01-01' and '2015-12-31';


--Question 4 ()
--What is the name and category of the top selling product (in terms of quantity) in the year 2015?

select "ProductName", "ProductCategory"
from products
join (
    select "ProductID", sum("Quantity") as total_quantity
    from orders
    where cast("OrderDate" as date) between '2015-01-01' and '2015-12-31'
    group by "ProductID"
    order by total_quantity desc
    limit 1
) as top_product
on products."ProductID" = top_product."ProductID";



--Question 5 (COALESCE and SUBQUERIES)
--What is the average price of products that have never been ordered? 
select avg("Price")
from products
where "ProductID" not in (
	select distinct "ProductID" from orders);
-------------------------------------------------------------------------
select 
	coalesce(
		cast(avg("Price") as text),
		'All products were ordered')
from products
where "ProductID" not in (
	select distinct "ProductID" from orders);


























