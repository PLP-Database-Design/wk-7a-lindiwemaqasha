CREATE TABLE ProductDetail_1NF AS
WITH split_orders AS(
    SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products,',', n.digit +1), ',', -1)) AS Product
FROM ProductDetail
JOIN(
    SELECT 0 AS digit UNION ALL SELECT 2 UNION ALL
    SELECT 3 UNION ALL SELECT 4
)    n 
ON LENGTH(Products) - LENGTH(REPLACE(Products, ',', ''))>= n.digit
WHERE TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.digit +1), ',', -1)) !=''
)
SELECT * FROM split_orders
ORDER BY OrderID, Product;









CREATE TABLE Orders_2NF AS
SELECT DISTINCT OrderId, CustomerName
FROM OrderDetails;


CREATE TABLE OrderItems_2NF AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;


ALTER TABLE Order_2NF ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems_2NF ADD PRIMARY KEY (OrderID, Product);


ALTER TABLE OrderItems_2NF
ADD CONSTRAINT fk_order
FOREIGN KEYn(OrderID) REFERENCES Orders_2NF(OrderID);