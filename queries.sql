-- 1. What are the top 5 brands by receipts scanned for the most recent month?

SELECT b.name AS brand_name, COUNT(*) AS receipt_count
FROM brand b
JOIN receipt_item ri ON b.barcode = ri.barcode
JOIN receipt r ON ri.receipt_id = r.id
WHERE DATE_FORMAT(r.date_scanned, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')
GROUP BY b.name
ORDER BY receipt_count DESC
LIMIT 5;

-- 2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

SELECT cur.brand_name, cur.receipt_count, prev.receipt_count
FROM (
  SELECT b.name AS brand_name, COUNT(*) AS receipt_count
  FROM brand b
  JOIN receipt_item ri ON b.barcode = ri.barcode
  JOIN receipt r ON ri.receipt_id = r.id
  WHERE DATE_FORMAT(r.date_scanned, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')
  GROUP BY b.name
  ORDER BY receipt_count DESC
  LIMIT 5
) AS cur
LEFT JOIN (
  SELECT b.name AS brand_name, COUNT(*) AS receipt_count
  FROM brand b
  JOIN receipt_item ri ON b.barcode = ri.barcode
  JOIN receipt r ON ri.receipt_id = r.id
  WHERE DATE_FORMAT(r.date_scanned, '%Y-%m') = DATE_FORMAT(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH), '%Y-%m')
  GROUP BY b.name
  ORDER BY receipt_count DESC
  LIMIT 5
) AS prev ON cur.brand_name = prev.brand_name;


-- 3. When considering the average spend from receipts with 'rewardsReceiptStatus' of 'Accepted' or 'Rejected', which is greater?

SELECT rewards_receipt_status, AVG(total_spent) AS average_spend
FROM receipt
WHERE rewards_receipt_status IN ('Accepted', 'Rejected')
GROUP BY rewards_receipt_status;
HAVING COUNT(*) > 0
ORDER BY average_spend DESC;

-- 4. When considering the total number of items purchased from receipts with 'rewardsReceiptStatus' of 'Accepted' or 'Rejected', which is greater?

SELECT rewards_receipt_status, SUM(purchased_item_count) AS total_items_purchased
FROM receipt
WHERE rewards_receipt_status IN ('Accepted', 'Rejected')
GROUP BY rewards_receipt_status;
HAVING COUNT(*) > 0
ORDER BY total_items_purchased DESC;

-- 5. Which brand has the most spend among users who were created within the past 6 months?

SELECT b.name AS brand_name, SUM(r.total_spent) AS total_spend
FROM brand b
JOIN receipt_item ri ON b.barcode = ri.barcode
JOIN receipt r ON ri.receipt_id = r.id
JOIN users u ON r.user_id = u.id
WHERE u.created_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY total_spend DESC
LIMIT 1;

-- 6. Which brand has the most transactions among users who were created within the past 6 months?

SELECT b.name AS brand_name, COUNT(*) AS transaction_count
FROM brand b
JOIN receipt_item ri ON b.barcode = ri.barcode
JOIN receipt r ON ri.receipt_id = r.id
JOIN users u ON r.user_id = u.id
WHERE u.created_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY transaction_count DESC
LIMIT 1;