--A
--Q1 How many unique nodes are there on the Data Bank system? 
Select count(distinct node_id) as Unique_Nodes from customer_nodes;
--unique_nodes
--5

--Q2 What is the number of nodes per region?
Select r.region_name , count(distinct c.node_id) from regions r join customer_nodes
c on r.region_id=c.region_id group by r.region_name;
-- region_name	node_count
-- Africa	      5
-- America	    5
-- Asia	        5
-- Australia	  5
-- Europe	      5

--Q3 How many customers are allocated to each region? 
Select r.region_name , count( c.customer_id) as Customers from regions r join customer_nodes
c on r.region_id=c.region_id group by r.region_name;
-- region_name	Customers
-- 1	          770
-- 2	          735
-- 3	          714
-- 4	          665
-- 5	          616

--Q4 How many days on average are customers reallocated to a different node? 
WITH node_days AS ( 
  SELECT 
    customer_id, 
    node_id,
    DATEDIFF(day, start_date, end_date) AS days_in_node 
  FROM customer_nodes 
  WHERE end_date != '9999-12-31' 
  GROUP BY customer_id, node_id, start_date, end_date
),
total_node_days AS ( 
  SELECT 
    customer_id,
    node_id, 
    SUM(days_in_node) AS total_days_in_node 
  FROM node_days 
  GROUP BY customer_id, node_id
) 
SELECT 
  ROUND(AVG(CAST(total_days_in_node AS FLOAT)), 0) AS avg_node_reallocation_days 
FROM total_node_days;
-- avg_node_reallocation_days
-- 24

--Q5 What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
WITH node_days AS ( 
  SELECT 
    customer_id, 
    region_id,
    node_id,
    DATEDIFF(day, start_date, end_date) AS days_in_node 
  FROM customer_nodes 
  WHERE end_date != '9999-12-31' 
  GROUP BY customer_id, region_id, node_id, start_date, end_date
),
total_node_days AS ( 
  SELECT 
    customer_id,
    region_id,
    node_id, 
    SUM(days_in_node) AS total_days_in_node 
  FROM node_days 
  GROUP BY customer_id, region_id, node_id
),
percentiles_cte AS (
  SELECT 
    r.region_name,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY t.total_days_in_node) 
        OVER (PARTITION BY r.region_name) AS median_days,
    PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY t.total_days_in_node) 
        OVER (PARTITION BY r.region_name) AS percentile_80,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY t.total_days_in_node) 
        OVER (PARTITION BY r.region_name) AS percentile_95
  FROM total_node_days t
  INNER JOIN regions r 
    ON t.region_id = r.region_id
)
SELECT DISTINCT 
  region_name,
  ROUND(median_days, 0) AS median_reallocation_days,
  ROUND(percentile_80, 0) AS percentile_80_reallocation_days,
  ROUND(percentile_95, 0) AS percentile_95_reallocation_days
FROM percentiles_cte
ORDER BY region_name;

-- region_name median_reallocation_days percentile_80_reallocation_days percentile_95_reallocation_days
-- ----------- ------------------------ ------------------------------- -------------------------------
-- Africa      22                       35                              54
-- America     22                       34                              54
-- Asia        22                       35                              52
-- Australia   21                       34                              51
-- Europe      23                       34                              51


--B
--Q1 What is the unique count and total amount for each transaction type? 
select txn_type , count( txn_type) as Total_Count, sum(txn_amount) as Total_Amount
from dbo.customer_transactions group by txn_type;

-- txn_type	Total_Count	Total_Amount
-- withdrawal	1580	793003
-- deposit	2671	1359168
-- purchase	1617	806537

--Q2What is the average total historical deposit counts and amounts for all customers? 
--For each month - how many Data Bank customers make more than 1 deposit and either 1 
--purchase or 1 withdrawal in a single month?
WITH deposits AS ( 
  SELECT 
    customer_id, 
    COUNT(customer_id) AS txn_count, 
    AVG(CAST(txn_amount AS FLOAT)) AS avg_amount 
  FROM customer_transactions 
  WHERE txn_type = 'deposit' 
  GROUP BY customer_id
) 
SELECT 
  ROUND(AVG(CAST(txn_count AS FLOAT)), 0) AS avg_deposit_count, 
  ROUND(AVG(avg_amount), 0) AS avg_deposit_amt 
FROM deposits;
-- avg_deposit_count      avg_deposit_amt
-- ---------------------- ---------------
-- 5                      509
