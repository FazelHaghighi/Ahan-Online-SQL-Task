-- Q1
SELECT SUM(quantity * unitprice) AS total_amount
FROM Sale;

-- Q2
SELECT COUNT(DISTINCT customer) AS unique_customers
FROM Sale;

-- Q3
SELECT product, COUNT(*) AS product_count
FROM Sale
GROUP BY product;

-- Q4
SELECT
  customer,
  SUM(quantity * unitprice) AS amount_of_purchase,
  COUNT(*) AS number_of_purchases,
  SUM(quantity) AS number_of_items
FROM
  Sale
WHERE
  quantity * unitprice > 1500
GROUP BY
  customer;

-- Q5
WITH product_sales AS (
  SELECT
    product,
    SUM(unitprice / 100.0 * quantity) AS total_sales
  FROM
    Sale
  WHERE
    product IN ('P1', 'P2', 'P3', 'P4', 'P5')
  GROUP BY
    product
)
SELECT
  ROUND(SUM(
    CASE
      WHEN product = 'P1' THEN 5 * total_sales
      WHEN product = 'P2' THEN 25 * total_sales
      WHEN product = 'P3' THEN 10 * total_sales
      WHEN product = 'P4' THEN 20 * total_sales
      WHEN product = 'P5' THEN 10 * total_sales
      ELSE 0
    END
  ), 2) AS total_profit_amount,
  ROUND(SUM(
    CASE
      WHEN product = 'P1' THEN 5 * total_sales
      WHEN product = 'P2' THEN 25 * total_sales
      WHEN product = 'P3' THEN 10 * total_sales
      WHEN product = 'P4' THEN 20 * total_sales
      WHEN product = 'P5' THEN 10 * total_sales
      ELSE 0
    END
  ) * 100 / (SELECT SUM(quantity * CAST(unitprice AS numeric)) FROM Sale), 2) AS profit_percentage
FROM
  product_sales;

-- Q6
SELECT SUM(count) AS total_count
FROM (
  SELECT COUNT(DISTINCT customer) AS count
  FROM Sale
  GROUP BY date
) AS count_table;


-- Q7
WITH RECURSIVE manager_hierarchy AS (
  SELECT
    Id,
    name,
    manager,
    Manager_Id,
    1 AS level,
    CASE
      WHEN name = 'Ken' THEN 1
      WHEN name = 'Hugo' THEN 2
    END AS highest_manager
  FROM
    chart
  WHERE
    manager IS NULL
  
  UNION ALL
  
  SELECT
    c.Id,
    c.name,
    c.manager,
    c.Manager_Id,
    mh.level + 1 AS level,
    CASE
      WHEN mh.highest_manager = 1 THEN 1
      WHEN mh.highest_manager = 2 THEN 2
      ELSE mh.highest_manager
    END AS highest_manager
  FROM
    chart c
  INNER JOIN
    manager_hierarchy mh ON c.manager = mh.name
)
SELECT
  c.Id,
  c.name,
  c.manager,
  c.Manager_Id,
  mh.level AS level,
  CASE
    WHEN c.name IN ('Ken', 'Hugo') THEN NULL
    ELSE mh.highest_manager
  END AS highest_manager
FROM
  chart c
LEFT JOIN
  manager_hierarchy mh ON c.Id = mh.Id
ORDER BY
  c.Id;

