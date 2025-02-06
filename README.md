# Lewis-Product-Portfolio
## Lewis Revenue: Data-Driven Insights into Product Sales Performance

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/Lewis_Cover.png" alt="Displays" width="800" height="400"/> 

### Introduction
This report analyzes sales data using PostgreSQL to identify the top-selling product by quantity in 2015. It applies SQL techniques like aggregations, CASE, COALESCE, and CAST to extract insights, handle missing values, and account for discounts. The queries provide a structured approach to sales analytics, making them valuable for data analysts and business professionals. Future enhancements include profitability analysis, query optimization, and data visualization. This report serves as a foundation for deeper business intelligence and database management insights. 🚀

### ✨Revenue generated from each product category.
**Objective:** To determine the revenue generated from each product category, considering different discount scenarios.

#### Methodology:
**1. Initial Revenue Calculation:**
- Calculate the total revenue for each product category without any discounts.

      select "ProductCategory", 
      		    sum("Price" * "Quantity") as revenue
      from orders
      join products on orders."ProductID" = products."ProductID"
      group by "ProductCategory";

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/1a.%20Rev.png" alt="Displays" width="600" height="300"/> 

**2. Discounted Revenue Calculation:**
- Apply a 10% discount for products priced above $100.
- Apply a 5% discount for products priced between $50 and $100.
- No discount for products priced below $50.

      select "ProductCategory", 
      		sum(case
      				when "Price" > 100 then "Price" * 0.9 * "Quantity"
      				when "Price" between 50 and 100 then "Price" * 0.95 * "Quantity"
      				else "Price" * "Quantity"
      				end) as "discounted revenue";

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/1b.%20Discount.png" alt="Displays" width="600" height="300"/> 

**Insights:**
- The analysis reveals the impact of discount strategies on revenue generation across different product categories.
- By comparing the initial and discounted revenues, we can identify which categories benefit most from discounting and which remain stable.

**Recommendations:**
- **Targeted Discounts:** Focus on applying discounts to categories that show significant revenue increases with discounts to boost sales.
- **Stable Categories:** Maintain pricing strategies for categories that remain stable, ensuring consistent revenue.

### ✨Total Revenue with Default Pricing for Null Values
**Objective**: To calculate the total revenue, treating products with a NULL price as having a default price of $10.

**Methodology:**
- Use the COALESCE function to replace NULL prices with $10.

      select sum(coalesce("Price", 10) * "Quantity")
      from orders
      join products on orders."ProductID" = products."ProductID";

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/2.%20Null.png" alt="Displays" width="600" height="300"/> 

**Insights:**
- This approach ensures that all products contribute to the total revenue, even if their prices are not specified.
- It provides a more comprehensive view of revenue generation, accounting for potential data gaps.

**Recommendations:**
- Data Quality Improvement: Ensure that product prices are consistently recorded to avoid reliance on default values.
- Revenue Assurance: Regularly review and update product pricing to reflect accurate revenue figures.

### ✨Order Analysis for the Year 2015
**Objective:** To determine the number of orders placed in the year 2015.

**Methodology:**
- Filter orders based on the order date falling within the year 2015.

      select count (distinct "OrderID")
      from orders
      where cast("OrderDate" as date) between '2015-01-01' and '2015-12-31';

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/3.%20Order%20placed.png" alt="Displays" width="600" height="300"/> 

**Insights:**
- This analysis helps understand the order volume for a specific year, which can be useful for trend analysis and forecasting.

**Recommendations:**
- Trend Analysis: Use historical order data to identify trends and forecast future demand.
- Marketing Strategies: Develop targeted marketing campaigns based on peak order periods.

### ✨Top-Selling Product in 2015
**Objective:** To identify the name and category of the top-selling product (in terms of quantity) in the year 2015.

**Methodology:**

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

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/4.%20Top%20sell.png" alt="Displays" width="600" height="300"/> 

**Insights:**
- Identifying the top-selling product helps in understanding customer preferences and product performance.

**Recommendations:**
- Product Promotion: Focus on promoting top-selling products to maximize sales.
- Inventory Management: Ensure adequate stock levels for popular products to meet demand.

### ✨Average Price of Never-Ordered Products
**Objective:** To find the average price of products that have never been ordered.

**Methodology:**
- Use a subquery to identify products not present in the orders table.
- Calculate the average price of these products.

      select 
      	coalesce(
      		cast(avg("Price") as text),
      		'All products were ordered')
      from products
      where "ProductID" not in (
      	select distinct "ProductID" from orders);

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/5.%20AV%20price.png" alt="Displays" width="600" height="300"/> 

**Insights:**
- This analysis highlights products that have not been popular or marketed effectively.
- It can inform decisions on product discontinuation or promotional strategies.

**Recommendations:**
- Product Review: Evaluate why certain products have never been ordered and consider discontinuation or rebranding.
- Promotional Strategies: Develop targeted promotions to increase the visibility and sales of underperforming products.
________________________________________
This report provides a comprehensive overview of revenue generation, order analysis, and product performance based on the SQL code provided. Each section offers valuable insights and actionable recommendations that can guide strategic decisions and improve business outcomes. 
________________________________________

<br>

### *Kindly share your feedback and I am happy to Connect 🌟*

<img src="https://github.com/jamesehiabhi/Lewis-Product-Portfolio/blob/main/Displays/My%20Card1.jpg" alt="Displays" width="600" height="150"/>

