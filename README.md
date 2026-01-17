# 🎬 Movie Rental Business Analysis (SQL)

## 📌 Project Overview
This project involves a comprehensive analysis of a movie rental database (simulating a real-world scenario like Blockbuster or a SaaS VOD platform). The goal was to extract key operational insights to support decision-making for inventory management, customer engagement, and financial auditing.

**Role:** Data Analyst / Backend Logic Designer  
**Tech Stack:** SQL (PostgreSQL/MySQL), Relational Database Management

## 🎯 Business Problems Solved
The SQL queries in this repository address specific business questions posed by stakeholders:
* **Inventory Management:** Analyzed film distribution across stores to optimize stock levels.
* **Customer Segmentation:** Identified VIP customers based on rental volume (Top 30+ rentals) for loyalty programs.
* **Financial Health:** calculated replacement costs and average payment processing values to assess fraud risk and asset value.
* **Staff Auditing:** Generated active staff and customer lists for security compliance.

## 🛠️ Key SQL Skills Demonstrated
* **Complex Joins:** Utilized `LEFT JOIN` and `INNER JOIN` to merge data from up to 3 tables (`film`, `inventory`, `category`, `payment`).
* **Aggregations:** Advanced use of `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` combined with `GROUP BY`.
* **Filtering Logic:** Applied `WHERE` for row-level filtering and `HAVING` for aggregate-level filtering (e.g., filtering high-volume customers).
* **Data Cleaning:** Handled potential duplicates using `DISTINCT`.

## 📊 Sample Insight (Code Snippet)
*Identifying high-value customers for the marketing team:*

```sql
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(r.rental_id) as number_of_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING count(r.rental_id) > 30
ORDER BY number_of_rentals DESC;
