/*1.Create a trigger that displays date when changes (insert, update, delete) were made in vendors.*/
CREATE TRIGGER TRIGGER_UPDATE_DEL_INSERT
ON VENDORS
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
	PRINT 'CHANGES WERE MADE AT ' + CAST(GETDATE() AS VARCHAR(50))
END;

INSERT INTO Vendors (vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES ('SIL101', 'Ana Soklic', '158 HEY CHILD', 'Ljubljana', NULL, 95159, 'SI')

delete from Vendors
where vend_id = 'SIL101'

/*2.Create  a  trigger  that  in  case you  remove  an  item  from  an  order,  its  quantity  is returned to the Products table.*/
CREATE TRIGGER TRIGGER_DELETE_ORDER_ITEMS
ON OrderItems
AFTER DELETE
AS
BEGIN
	UPDATE PRODUCTS
	SET AMOUNT += (SELECT quantity FROM DELETED)
	WHERE PROD_ID = (SELECT PROD_ID FROM DELETED)
END;

SELECT * FROM OrderItems WHERE ORDER_NUM = 20009 AND PROD_ID = 'BNBG03'
SELECT * FROM Products WHERE PROD_ID = 'BNBG03'
DELETE FROM OrderItems WHERE ORDER_NUM = 20009 AND PROD_ID = 'BNBG03'
SELECT * FROM OrderItems WHERE ORDER_NUM = 20009 AND PROD_ID = 'BNBG03'
SELECT * FROM Products WHERE PROD_ID = 'BNBG03'

/*3. Create a trigger that in case you add a new customer, a unique cust_id is generated.*/
CREATE TRIGGER AFTER_INSERT_CUSTOMERS
ON Customers
AFTER INSERT
AS
BEGIN
	UPDATE Customers
	SET cust_id = (SELECT MAX(CAST(CUST_ID AS INT)) FROM Customers) + (SELECT CAST(cust_id AS INT) FROM INSERTED)
	WHERE CUST_ID = (SELECT cust_id FROM INSERTED)
END;

DROP TRIGGER AFTER_INSERT_CUSTOMERS

INSERT INTO Customers VALUES
('1', 'SOME NAME', 'TOLE BI 50', 'ALMATY', NULL, '050000', 'KAZAKHSTAN', 'ALUA SMAGULOVA', NULL)
SELECT * FROM Customers

/*4. Create a trigger that in case you delete a vendor, all its links and data are deleted.*/
CREATE TRIGGER AFTER_DELETE_VENDORS
ON VENDORS
INSTEAD OF DELETE
AS
BEGIN

	DELETE FROM OrderItems
	WHERE prod_id IN (SELECT prod_id FROM Products
					WHERE vend_id = (SELECT VEND_ID FROM DELETED))

	DELETE FROM Products
	WHERE vend_id = (SELECT VEND_ID FROM DELETED)

	DELETE FROM Vendors WHERE 
	vend_id = (SELECT VEND_ID FROM DELETED)

END;

INSERT INTO Vendors VALUES ('AAA123', 'NAME', 'ADRESS', 'ATYRAU', NULL, '06000', 'KZ')
INSERT INTO Products VALUES ('AAA1', 'AAA123', '1 PROD', 100, 10.6, '')
INSERT INTO Products VALUES ('AAA2', 'AAA123', '2 PROD', 52, 5.5, '')
INSERT INTO Orders VALUES (20010, '2023-12-12', '1000000001')
INSERT INTO OrderItems (order_num, order_item, prod_id, quantity, item_price) VALUES (20010, 1, 'AAA1', 20, 12.72)
SELECT * FROM OrderItems WHERE prod_id = 'AAA1'
SELECT * FROM Products WHERE vend_id = 'AAA123'
SELECT * FROM Vendors WHERE vend_id = 'AAA123'
DELETE FROM Vendors WHERE vend_id = 'AAA123'
SELECT * FROM OrderItems WHERE prod_id = 'AAA1'
SELECT * FROM Products WHERE vend_id = 'AAA123'
SELECT * FROM Vendors WHERE vend_id = 'AAA123'

/*5. Create a trigger that in case you insert a product to the table Products, it increases
product’s price by 20% and shows a message that this product has been added. (u
can use TRIM function)*/
CREATE TRIGGER AFTER_INSERT_PRODUCTS
ON PRODUCTS
AFTER INSERT
AS
BEGIN
	DECLARE @NAME VARCHAR(255) = (SELECT PROD_NAME FROM INSERTED)
	UPDATE Products
	SET prod_price = (SELECT prod_price FROM inserted) + (SELECT prod_price FROM inserted) * 0.2
	WHERE prod_id = 'BR04' AND vend_id = 'BRS01'
	PRINT TRIM(@NAME) + ' ADDED!'
END;

INSERT INTO Products VALUES
('BR04', 'BRS01', '20 INCH TEDDY BEAR', 50, 12, '20 INCH TEDDY BEAR, COMES WITH CAP AND JACKET')
SELECT * FROM Products

/*6. Create a trigger that in case you add a new order, its date automatically assigns the
date when the insert was made. (u can use CONVERT and GETDATE functions)*/
CREATE TRIGGER AFTER_INSERT_ORDERS
ON ORDERS
INSTEAD OF INSERT
AS
BEGIN
	UPDATE ORDERS
	SET order_date = '2020-12-04'
	WHERE order_num = (SELECT order_num FROM inserted)

	INSERT INTO ORDERS
	VALUES ((SELECT order_num FROM INSERTED), '2020-12-04', (SELECT cust_id FROM INSERTED))
END;

DROP TRIGGER AFTER_INSERT_ORDERS

INSERT INTO ORDERS (order_num, cust_id) VALUES (20010, '1000000006')
DELETE FROM Orders
WHERE order_num = 20010

SELECT *FROM Orders