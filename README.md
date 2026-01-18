SQL Business Intelligence: Movie Rental Operational Analysis
📌 Project Background
This project provides a deep-dive operational and financial analysis for a movie rental business (Maven Movies). As a Data Analyst, I was tasked with extracting actionable insights to support store management, inventory optimization, and stakeholder relations.

The analysis covers the entire business lifecycle: from inventory auditing and customer lifetime value (LTV) to prestige content coverage analysis.

🎯 Business Problems Solved
Inventory Optimization: Analyzed stock levels across multiple locations, categorized by film ratings and genres to prevent overstocking of unpopular titles.

Customer Segmentation & LTV: Identified high-value customers by combining rental frequency with total revenue, enabling targeted loyalty programs.

Financial Risk Management: Calculated replacement costs across the entire catalog to estimate insurance liability and asset value.

Stakeholder Reporting: Consolidated diverse datasets of internal staff, external advisors, and investors into unified reporting structures for the Board of Directors.

Market Penetration Analysis: Evaluated the library's "prestige" by calculating the percentage of award-winning actors covered in the current inventory.

🛠️ Technical Stack & Skills
Advanced Relational Logic: Implementing complex multi-table chains (up to 5-6 tables) using LEFT JOIN to ensure data integrity.

Data Aggregation: Proficient use of COUNT, SUM, AVG, MIN/MAX with multi-level GROUP BY.

Set Operations: Utilizing UNION to merge heterogeneous data sources (Advisors vs. Investors).

Cohort Analysis: Using CASE WHEN to create custom business logic for grouping actors by award count without the need for subqueries.

Data Quality Assurance: Identifying and resolving the Fan-out problem (cartesian product issues) in financial reporting.

📈 Key SQL Achievement: The "Prestige" Analysis
One of the most complex tasks involved calculating the percentage coverage of award-winning actors.

Problem: How many actors with 1, 2, or 3 awards are represented in our inventory? Solution: I implemented a robust query using COUNT(DISTINCT) and CASE statements to categorize actors into cohorts and calculate penetration rates while avoiding duplicate counts from the film_actor bridge table.
```
SQL
SELECT 
    CASE 
        WHEN awards = 'Emmy, Oscar, Tony ' THEN 3
        WHEN awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN 2
        ELSE 1 
    END AS award_count,
    COUNT(DISTINCT aa.actor_id) AS total_actors,
    COUNT(DISTINCT fa.actor_id) AS actors_with_films,
    ROUND(COUNT(DISTINCT fa.actor_id) / COUNT(DISTINCT aa.actor_id) * 100, 2) AS pct_coverage
FROM actor_award aa
LEFT JOIN film_actor fa ON aa.actor_id = fa.actor_id
GROUP BY 1;
```
🚀 Career & Growth
This project serves as a foundation for my transition toward Data Engineering and building SaaS products. The logic applied here—particularly in handling financial data and inventory—is directly applicable to building scalable API-driven digital products.
