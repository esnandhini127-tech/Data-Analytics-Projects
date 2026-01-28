Create database customer_churn
use customer_churn

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    region VARCHAR(50),
    signup_date DATE
);

select * from customers;

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_type VARCHAR(50),
    monthly_fee DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),   -- Active / Churned
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),  -- Paid / Failed / Delayed
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE usage_logs (
    usage_id INT PRIMARY KEY,
    customer_id INT,
    usage_date DATE,
    data_used_gb DECIMAL(5,2),
    calls_made INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1,'Amit Sharma','Male',34,'North','2023-01-10'),
(2,'Priya Nair','Female',28,'South','2023-03-15'),
(3,'Rahul Verma','Male',41,'West','2022-11-05'),
(4,'Sneha Iyer','Female',36,'East','2023-05-20'),
(5,'Arjun Patel','Male',30,'West','2023-02-01');

select * from customers;

INSERT INTO subscriptions VALUES
(101,1,'Premium',999,'2023-01-10',NULL,'Active'),
(102,2,'Basic',499,'2023-03-15','2024-01-10','Churned'),
(103,3,'Standard',699,'2022-11-05','2023-12-15','Churned'),
(104,4,'Premium',999,'2023-05-20',NULL,'Active'),
(105,5,'Basic',499,'2023-02-01',NULL,'Active');

select * from subscriptions;

INSERT INTO payments VALUES
(201,1,'2024-01-01',999,'Paid'),
(202,2,'2023-12-01',499,'Delayed'),
(203,3,'2023-11-01',699,'Failed'),
(204,4,'2024-01-01',999,'Paid'),
(205,5,'2024-01-01',499,'Paid');

select * from payments;

INSERT INTO usage_logs VALUES
(301,1,'2024-01-01',45.5,320),
(302,2,'2023-12-01',5.2,45),
(303,3,'2023-11-01',8.1,60),
(304,4,'2024-01-01',50.0,400),
(305,5,'2024-01-01',30.3,210);

select * from usage_logs;

select count(*) as Total_customers from customers group by region;

SELECT plan_type, AVG(monthly_fee) AS avg_monthly_fee FROM subscriptions GROUP BY plan_type;

SELECT c.region, COUNT(*) AS churn_count
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.status = 'Churned'
GROUP BY c.region
HAVING COUNT(*) > 1;

SELECT c.customer_name, s.plan_type, s.status, s.monthly_fee
FROM customers c
JOIN subscriptions s
ON c.customer_id = s.customer_id;

SELECT c.customer_name, p.payment_date, p.amount, p.payment_status
FROM customers c
LEFT JOIN payments p
ON c.customer_id = p.customer_id;

SELECT c.customer_id,
       c.customer_name,
       CASE
           WHEN s.status = 'Churned' THEN 'Churned'
           WHEN p.payment_status IN ('Failed','Delayed') THEN 'High Risk'
           ELSE 'Low Risk'
       END AS churn_risk
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
LEFT JOIN payments p ON c.customer_id = p.customer_id;

SELECT customer_id,
       DATEDIFF(COALESCE(end_date, CURDATE()), start_date) AS tenure_days
FROM subscriptions;

SELECT 
    YEAR(end_date) AS year,
    MONTH(end_date) AS month,
    COUNT(*) AS churned_customers
FROM subscriptions
WHERE status = 'Churned'
GROUP BY YEAR(end_date), MONTH(end_date);

SELECT customer_id,
       plan_type,
       monthly_fee,
       RANK() OVER (PARTITION BY plan_type ORDER BY monthly_fee DESC) AS fee_rank
FROM subscriptions;

SELECT customer_id,
       usage_date,
       data_used_gb,
       LAG(data_used_gb) OVER (PARTITION BY customer_id ORDER BY usage_date) AS previous_usage,
       (data_used_gb -
        LAG(data_used_gb) OVER (PARTITION BY customer_id ORDER BY usage_date)) AS usage_change
FROM usage_logs;


WITH churn_revenue AS (
    SELECT customer_id, monthly_fee
    FROM subscriptions
    WHERE status = 'Churned'
)
SELECT SUM(monthly_fee) AS total_revenue_lost
FROM churn_revenue;

SELECT 
    ROUND(
        (COUNT(CASE WHEN status = 'Churned' THEN 1 END) * 100.0) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM subscriptions;

SELECT SUM(monthly_fee) AS revenue_lost
FROM subscriptions
WHERE status = 'Churned';

SELECT SUM(p.amount) AS revenue_at_risk
FROM payments p
WHERE p.payment_status IN ('Failed','Delayed');

SELECT 
    AVG(monthly_fee * 
        (DATEDIFF(COALESCE(end_date, CURDATE()), start_date) / 30)
       ) AS avg_clv
FROM subscriptions;

SELECT c.customer_id,
       c.customer_name,
       s.plan_type,
       s.monthly_fee,
       p.payment_status
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
JOIN payments p ON c.customer_id = p.customer_id
WHERE s.status = 'Active'
  AND p.payment_status IN ('Failed','Delayed');

CREATE VIEW vw_customer_overview AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.region,
    s.plan_type,
    s.monthly_fee,
    s.status AS subscription_status,
    s.start_date,
    s.end_date
FROM customers c
JOIN subscriptions s
ON c.customer_id = s.customer_id;

CREATE VIEW vw_churn_metrics AS
SELECT 
    YEAR(end_date) AS churn_year,
    MONTH(end_date) AS churn_month,
    COUNT(*) AS churned_customers,
    SUM(monthly_fee) AS revenue_lost
FROM subscriptions
WHERE status = 'Churned'
GROUP BY YEAR(end_date), MONTH(end_date);

CREATE VIEW vw_revenue_at_risk AS
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.amount) AS revenue_at_risk
FROM customers c
JOIN payments p
ON c.customer_id = p.customer_id
WHERE p.payment_status IN ('Failed','Delayed')
GROUP BY c.customer_id, c.customer_name;

CREATE VIEW vw_usage_behavior AS
SELECT 
    customer_id,
    usage_date,
    data_used_gb,
    calls_made
FROM usage_logs;
