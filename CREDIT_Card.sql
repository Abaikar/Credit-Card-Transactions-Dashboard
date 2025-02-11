create database credit_card;
use credit_card;
 -- Find the total amount spent by each customer.
 SELECT 
    Customer_ID, SUM(Amount) AS Total_Amount
FROM
    credit_card_transactions
GROUP BY Customer_ID;

-- 2 Get the top 5 locations with the highest number of transactions.
SELECT 
    Location, COUNT(Transaction_ID) AS Transactions_Count
FROM
    credit_card_transactions
GROUP BY Location
ORDER BY Transactions_Count DESC
LIMIT 5;
-- 3. List all fraudulent transactions above $1000.
SELECT 
    *
FROM
    credit_card_transactions
WHERE
    Fraud_Status = 'Fraudulent'
        AND Amount > 1000;
        
--  Count the number of transactions for each merchant category.
SELECT 
    Merchant_Category, COUNT(Transaction_ID)
FROM
    credit_card_transactions
GROUP BY Merchant_Category;
-- Find the average transaction amount for online purchases.
SELECT 
    Transaction_Type, AVG(Amount) AS AvgAmt_transaction
FROM
    credit_card_transactions
WHERE
    Transaction_Type = 'Online';
    
    -- Identify the customer who has made the highest number of transactions.
    SELECT 
    Customer_ID, SUM(Amount) AS Amt
FROM
    credit_card_transactions
GROUP BY Customer_ID
ORDER BY Amt DESC
LIMIT 1;
-- Retrieve all transactions made in "New York" in the last year.
SELECT 
    *
FROM
    credit_card_transactions
WHERE
    Location = 'New York'
        AND YEAR(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) = 2024;
-- Identify the top 3 customers who spent the most in the last year.
SELECT 
    Customer_ID, SUM(Amount) as Amt
FROM
    credit_card_transactions
WHERE
    YEAR(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) = 2024
GROUP BY Customer_ID
order by Amt desc 
limit 3;

-- Find the most frequently used transaction type.
SELECT 
    Transaction_Type, COUNT(Transaction_Type) AS Count
FROM
    credit_card_transactions
GROUP BY Transaction_Type
ORDER BY Count DESC
LIMIT 5;
-- Retrieve all transactions where the amount is higher than the average transaction amount.
SELECT 
    *
FROM
    credit_card_transactions
WHERE
    Amount > (SELECT 
            AVG(Amount)
        FROM
            credit_card_transactions);
-- Find the month with the highest total transaction amount.
SELECT 
    monthname(STR_TO_DATE(Transaction_Date, '%m/%d/%y')) AS Month,
    SUM(Amount) AS TotalAmt
FROM
    credit_card_transactions
GROUP BY Month
ORDER BY TotalAmt DESC;

-- Count the number of fraudulent transactions per location.
SELECT 
    Location, COUNT(*) AS Fraud_Transaction_Count
FROM
    credit_card_transactions
WHERE
    Fraud_Status = 'Fraudulent'
GROUP BY Location
ORDER BY Fraud_Transaction_Count DESC;

--  Get the total amount spent per customer in each merchant category.
SELECT 
    Customer_ID, SUM(Amount) AS Spent_Amt, Merchant_Category
FROM
    credit_card_transactions
GROUP BY Customer_ID , Merchant_Category
ORDER BY Spent_Amt DESC;

-- List customers who have made transactions in more than 3 different locations.

SELECT 
    Customer_ID, COUNT(DISTINCT Location) AS Unique_Locations
FROM
    credit_card_transactions
GROUP BY Customer_ID
HAVING Unique_Locations > 3
ORDER BY Unique_Locations DESC;

-- Find the percentage of fraudulent transactions for each transaction type.
SELECT 
    Transaction_Type,  
    COUNT(CASE WHEN Fraud_Status = 'Fraud' THEN 1 END) * 100.0 / COUNT(*) AS Fraud_Percentage  
FROM credit_card_transactions  
GROUP BY Transaction_Type  
ORDER BY Fraud_Percentage DESC;
