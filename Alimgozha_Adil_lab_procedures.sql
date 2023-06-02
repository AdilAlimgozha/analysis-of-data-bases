
-- Создание таблиц
 
CREATE TABLE Customers
(
  cust_id      char(10)  NOT NULL ,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL
);
CREATE TABLE OrderItems
(
  order_num  int          NOT NULL ,
  order_item int          NOT NULL ,
  prod_id    char(10)     NOT NULL ,
  quantity   int          NOT NULL ,
  item_price decimal(8,2) NOT NULL
);
 
 
CREATE TABLE Orders
(
  order_num  int      NOT NULL ,
  order_date date     NOT NULL ,
  cust_id    char(10) NOT NULL
);
 

CREATE TABLE Products
(
  prod_id    char(10)      NOT NULL ,
  vend_id    char(10)      NOT NULL ,
  prod_name  char(255)     NOT NULL ,
  amount int NOT NULL,
  prod_price decimal(8,2)  NOT NULL ,
  prod_desc  text          NULL
);
 
 
CREATE TABLE Vendors
(
  vend_id      char(10) NOT NULL ,
  vend_name    char(50) NOT NULL ,
  vend_address char(50) NULL ,
  vend_city    char(50) NULL ,
  vend_state   char(5)  NULL ,
  vend_zip     char(10) NULL ,
  vend_country char(50) NULL
);
 
--  Определим главные ключи (изменение структуры таблиц)------------
 
ALTER TABLE Customers ADD PRIMARY KEY (cust_id);
ALTER TABLE OrderItems ADD PRIMARY KEY (order_num, order_item);
ALTER TABLE Orders ADD PRIMARY KEY (order_num);
ALTER TABLE Products ADD PRIMARY KEY (prod_id);
ALTER TABLE Vendors ADD PRIMARY KEY (vend_id);
 
 
--  Определим внешние ключи (изменение структуры таблиц)------------
 
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_num) REFERENCES Orders (order_num);
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Products FOREIGN KEY (prod_id) REFERENCES Products (prod_id);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Vendors FOREIGN KEY (vend_id) REFERENCES Vendors (vend_id);
 
 
 
 
------------- Заполнение таблиц данными ---------------------
 
 
-- Заполняем данными таблицу Customers 
 
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000001', 'Village Toys', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'John Smith', 'mailto:sales@villagetoys.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000002', 'Kids Place', '333 South Lake Drive', 'Columbus', 'OH', '43333', 'USA', 'Michelle Green');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000003', 'Fun4All', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', '<mailto:jjones@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000004', 'Fun4All', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Denise L. Stephens', '<mailto:dstephens@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000005', 'The Toy Store', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'Kim Howard');
 
 
-- Заполняем данными таблицу Vendors
 
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRS01','Bears R Us','123 Main Street','Bear Town','MI','44444', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRE02','Bear Emporium','500 Park Street','Anytown','OH','44333', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('DLL01','Doll House Inc.','555 High Street','Dollsville','CA','99999', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FRB01','Furball Inc.','1000 5th Avenue','New York','NY','11111', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FNG01','Fun and Games','42 Galaxy Road','London', NULL,'N16 6PS', 'England');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('JTS01','Jouets et ours','1 Rue Amusement','Paris', NULL,'45678', 'France');
 
 
-- Заполняем данными таблицу Products 
 select*from Products;
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BR01', 'BRS01', '8 inch teddy bear', 100, 5.99, '8 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BR02', 'BRS01', '12 inch teddy bear', 18, 8.99, '12 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BR03', 'BRS01', '18 inch teddy bear', 35, 11.99, '18 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BNBG01', 'DLL01', 'Fish bean bag toy', 50, 3.49, 'Fish bean bag toy, complete with bean bag worms with which to feed it');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BNBG02', 'DLL01', 'Bird bean bag toy', 200, 3.49, 'Bird bean bag toy, eggs are not included');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy', 140, 3.49, 'Rabbit bean bag toy, comes with bean bag carrots');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('RGAN01', 'DLL01', 'Raggedy Ann', 45, 4.99, '18 inch Raggedy Ann doll');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('RYL01', 'FNG01', 'King doll', 120, 9.49, '12 inch king doll with royal garments and crown');
INSERT INTO Products(prod_id, vend_id, prod_name, amount, prod_price, prod_desc)
VALUES('RYL02', 'FNG01', 'Queen doll', 18, 9.49, '12 inch queen doll with royal garments and crown');
 
 
/* Заполняем данными таблицу Orders */
 
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20005, '2019-05-01', '1000000001');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20006, '2019-01-12', '1000000003');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20007, '2019-01-30', '1000000004');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20008, '2019-02-03', '1000000005');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20009, '2019-02-08', '1000000001');
 
 
-- Заполняем данными таблицу OrderItems 
 
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 1, 'BR01', 100, 5.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 2, 'BR03', 100, 10.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 1, 'BR01', 20, 5.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 2, 'BR02', 10, 8.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 3, 'BR03', 10, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 1, 'BR03', 50, 11.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 2, 'BNBG01', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 3, 'BNBG02', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 4, 'BNBG03', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 5, 'RGAN01', 50, 4.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 1, 'RGAN01', 5, 4.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 2, 'BR03', 5, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 3, 'BNBG01', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 4, 'BNBG02', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 5, 'BNBG03', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 1, 'BNBG01', 250, 2.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 2, 'BNBG02', 250, 2.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 3, 'BNBG03', 250, 2.49);

--1.Create a stored procedure to show each vendor's products, separated by commas.(u can use STRING_AGGand TRIM functions)
CREATE PROCEDURE VENDOR_PRODUCT
AS
BEGIN
	SELECT V.VEND_ID, VEND_NAME, VEND_COUNTRY, PRODUCTS
	FROM Vendors AS V
	LEFT JOIN (
		SELECT VEND_ID, STRING_AGG (CONVERT(NVARCHAR(max), TRIM(PROD_NAME)), ', ') AS PRODUCTS
		FROM Products
		GROUP BY vend_id) AS P
	ON V.VEND_ID = P.vend_id
END

EXEC VENDOR_PRODUCT

/*2.Create a procedure that updates emails for null values in Customers table.
It hasto be started from ‘kztoys’, @nameofcustomer without spaces.
(u can use CONCAT,LOWERand REPLACEfunctions)*/
CREATE PROCEDURE UPDATE_EMAIL
@nameofcustomer VARCHAR(50)

AS
BEGIN
	UPDATE CUSTOMERS
	SET cust_email = CONCAT('kztoys.@', REPLACE(LOWER(@nameofcustomer), ' ', ''), '.com')
	WHERE cust_name = @nameofcustomer
END

EXEC UPDATE_EMAIL @nameofcustomer = 'Kids Place'
EXEC UPDATE_EMAIL @nameofcustomer = 'The Toy Store'

SELECT * FROM Customers

/*3.Create  a  stored  procedure  that  showsthe  customers  and  regularities  of  their  visits  to  the market.
The customer is said to be ‘REGULAR CUSTOMER’ if he/she bought at least 2 things, otherwise ‘SELDOM CUSTOMER’.
Show all the info with this description.(u can use CASEstatement)*/
CREATE PROCEDURE REGULAR_SELDOM_CUST
AS
BEGIN
	SELECT C.cust_id, cust_name, cust_address, cust_city, cust_email, O.AMOUNT_OF_ORDERS,
	CASE 
		WHEN O.AMOUNT_OF_ORDERS = 1
		THEN 'seldom customer'
		ELSE 'regular customer'
	END AS CUSTOMER_DESCRIPTION
	FROM Customers C
	JOIN (
		SELECT cust_id, COUNT(order_num) AS AMOUNT_OF_ORDERS
		FROM ORDERS
		GROUP BY cust_id
	) AS O
	ON C.cust_id = O.cust_id
END

EXEC REGULAR_SELDOM_CUST

/*4.Create a stored procedure that shows all the id, name, countryas well as description of all the vendors. 
The description must indicate whether or not the length of the countryOddor Even.*/
CREATE PROCEDURE EVEN_ODD
AS
BEGIN
	SELECT vend_id, vend_name, vend_country, 
	CASE
		WHEN LEN(vend_country) % 2 = 0
		THEN 'even'
		ELSE 'odd'
	END AS VEND_COUNTRY_DESCRIPTION
	FROM Vendors
END

EXEC EVEN_ODD

/*5.Create a stored procedure to display full cost for product by input id. */
CREATE PROCEDURE PRICE
@PROD_ID CHAR(10),
@ORDER_NUM INT

AS
BEGIN
	DECLARE @FULL_COST FLOAT = (SELECT item_price * quantity 
	FROM OrderItems
	WHERE PROD_ID = @PROD_ID AND ORDER_NUM = @ORDER_NUM)

	PRINT 'FULL COST ' + CAST(@FULL_COST AS VARCHAR(50))
END

EXEC PRICE @PROD_ID = 'BR01', @ORDER_NUM = 20006

/*6.Create a stored procedure that gives  a  message
'There  are  some  vendors  with  unknown locations'
if exists unknown locations in vendors table.
Otherwise it should show 'Information about location is filled'.*/
CREATE PROCEDURE [MESSAGE]
AS
BEGIN
	DECLARE @COUNT_NULL_LOC INT = (SELECT COUNT(*) FROM(
		SELECT vend_address, vend_city, vend_state, vend_country
		FROM VENDORS
		WHERE vend_address IS NULL OR vend_city IS NULL OR vend_state IS NULL OR vend_country IS NULL) AS COUNT_NULL_LOC_T)
	IF @COUNT_NULL_LOC = 0
		PRINT 'Information about location is filled'
	ELSE
		PRINT 'There  are  some  vendors  with  unknown locations'
END

EXEC [MESSAGE]

/*7.Create a stored procedure that shows is there vendor in the state where customer lives.*/
CREATE PROCEDURE SAME_STATE
AS
BEGIN
	SELECT cust_name,
	CASE
		WHEN cust_state IN (
			SELECT vend_state
			FROM Vendors)
		THEN 'YES'
		ELSE 'NO'
	END AS VEND
	FROM Customers
END

EXEC SAME_STATE

/*8.Createa stored procedure that shows all the products whoseprice is located 
between average price  and  second  higher  average  price  of  the  products.
The  second  higher  average  price  is  located exactly in the middle
of the mean value and max value price of the products.*/
CREATE PROCEDURE PROD
AS
BEGIN
	DECLARE @AVG FLOAT = (SELECT AVG(prod_price) FROM PRODUCTS)
	DECLARE @MAX FLOAT = (SELECT MAX(prod_price) FROM PRODUCTS)
	DECLARE @SEC_HIGH_AVG FLOAT = (
		SELECT AVG(prod_price) FROM Products
		WHERE prod_price BETWEEN @AVG AND @MAX)
	SELECT * FROM PRODUCTS
	WHERE prod_price BETWEEN @AVG AND @SEC_HIGH_AVG
END

EXEC PROD

/*9.Create  a storedprocedure thatshows  customer  ids,  number  of items  that  they  bought,
total amount of moneythatthey paid, and to one column write if it is max amount of money –‘maximum’,
if second maximum write ‘second maximum’ and otherwise write ‘usual’.*/
CREATE PROCEDURE CUST_MONEY
AS
BEGIN

	DECLARE @MAX FLOAT = (
		SELECT MAX(MONEY) FROM(
		SELECT SUM(OI.item_price * OI.quantity) AS MONEY
		FROM Customers C
		INNER JOIN Orders O
		ON C.cust_id = O.cust_id
		INNER JOIN OrderItems OI
		ON O.order_num = OI.order_num
		GROUP BY C.cust_id) AS MONEY_T
	)

	DECLARE @SECOND_MAX FLOAT = (
	SELECT MAX(MONEY) FROM(
		SELECT SUM(OI.item_price * OI.quantity) AS MONEY
		FROM Customers C
		INNER JOIN Orders O
		ON C.cust_id = O.cust_id
		INNER JOIN OrderItems OI
		ON O.order_num = OI.order_num
		GROUP BY C.cust_id) AS MONEY_T
	WHERE MONEY NOT IN (SELECT MAX(MONEY) FROM(
		SELECT SUM(OI.item_price * OI.quantity) AS MONEY
		FROM Customers C
		INNER JOIN Orders O
		ON C.cust_id = O.cust_id
		INNER JOIN OrderItems OI
		ON O.order_num = OI.order_num
		GROUP BY C.cust_id) AS MONEY_T)
	) 

	SELECT C.cust_id, COUNT(O.order_num) AS NUM_ITEMS, SUM(OI.item_price * OI.quantity) AS MONEY,
	CASE
		WHEN SUM(OI.item_price * OI.quantity) = @MAX
		THEN 'MAXIMUM'
		WHEN SUM(OI.item_price * OI.quantity) = @SECOND_MAX
		THEN 'SECOND MAXIMUM'
		ELSE 'USUAL'
	END AS DER

	FROM Customers C
	INNER JOIN Orders O
	ON C.cust_id = O.cust_id
	INNER JOIN OrderItems OI
	ON O.order_num = OI.order_num
	GROUP BY C.cust_id
END

EXEC CUST_MONEY

/*10.Your procedure.
Create procedure that takes customer's id and shows the customer's name, quantity of all items and total price*/
CREATE PROCEDURE ORDER_INFO
@CUST_ID INT

AS
BEGIN
	SELECT cust_name, SUM(quantity) AS QUANTITY_ALL_ITEMS, SUM((quantity * item_price)) AS TOTAL_PRICE
	FROM Customers C
	JOIN Orders O
	ON C.cust_id = O.cust_id
	JOIN OrderItems OI
	ON O.order_num = OI.order_num
	WHERE C.cust_id = @CUST_ID
	GROUP BY cust_name
END

EXEC ORDER_INFO @CUST_ID = 1000000001