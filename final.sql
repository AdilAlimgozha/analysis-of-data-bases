USE FINAL

CREATE TABLE CUSTOMERS(
customer_id int identity(1,1) primary key,
name varchar(50) not null,
email varchar(50) not null, 
wallet float not null
)

CREATE TABLE VENUE(
venue_id int identity(1,1) primary key,
name varchar(50) not null,
address varchar(100) not null
)

CREATE TABLE EVENT(
event_id int identity(1,1) primary key,
name varchar(50) not null,
venue_id int not null,
date date not null,
price int,
seat_amount int
FOREIGN KEY REFERENCES VENUE(venue_id)
)

CREATE TABLE ORDERS(
order_id int primary key,
customer_id int not null,
total float not null,
date date not null,
FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id))

CREATE TABLE ORDER_ITEM (  
order_item_id int identity(1,1),
order_id int,  
status varchar(30) not null,
amount int,  event_id int,
PRIMARY KEY (order_item_id),  
FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
FOREIGN KEY (event_id) REFERENCES EVENT(event_id));


alter table event
add beginning time, ends time
UPDATE EVENT
SET beginning =  
  CASE 
    WHEN event_id BETWEEN 100 AND 199 THEN '00:00:00' 
    WHEN event_id BETWEEN 200 AND 299 THEN '09:20:00' 
    WHEN event_id BETWEEN 300 AND 399 THEN '11:20:00' 
    WHEN event_id BETWEEN 400 AND 499 THEN '15:10:00' 
  END, 
    ends =  
  CASE 
    WHEN event_id BETWEEN 100 AND 199 THEN '23:59:59' 
    WHEN event_id BETWEEN 200 AND 299 THEN '15:00:00' 
    WHEN event_id BETWEEN 300 AND 399 THEN '14:00:00' 
    WHEN event_id BETWEEN 400 AND 499 THEN '17:42:30' 
  END;

BULK INSERT CUSTOMERS
FROM 'C:\Programming\SQL 4 semester\customers.csv'
WITH (format='csv', firstrow=2,fieldterminator=',',rowterminator='0x0a')
BULK INSERT VENUE
FROM 'C:\Programming\SQL 4 semester\VENUE.csv'
WITH (format='csv', firstrow=2,fieldterminator=',',rowterminator='0x0a')
BULK INSERT EVENT
FROM 'C:\Programming\SQL 4 semester\event (3).csv'
WITH (format='csv', firstrow=2,fieldterminator=',',rowterminator='0x0a')
BULK INSERT ORDERS
FROM 'C:\Programming\SQL 4 semester\orders.csv'
WITH (format='csv', firstrow=2,fieldterminator=',',rowterminator='0x0a')
BULK INSERT ORDER_ITEM
FROM 'C:\Programming\SQL 4 semester\order_item.csv'
WITH (format='csv', firstrow=2,fieldterminator=',',rowterminator='0x0a')

SELECT * FROM CUSTOMERS
SELECT * FROM ORDER_ITEM
SELECT * FROM ORDERS
SELECT * FROM VENUE
SELECT * FROM EVENT

DROP TABLE CUSTOMERS
DROP TABLE VENUE
DROP TABLE EVENT
DROP TABLE ORDERS
DROP TABLE ORDER_ITEM



CREATE PROCEDURE DELETE_EVENT 
@EVENT_ID INT
AS
BEGIN
	DELETE FROM EVENT
	WHERE event_id = @EVENT_ID

END;

CREATE TRIGGER DELETE_AFTER_EVENT_REFUND
ON EVENT
INSTEAD OF DELETE
AS
BEGIN

	DECLARE @COUNTER INT
	SET @COUNTER = (SELECT COUNT(total) FROM ORDERS
					WHERE customer_id IN (SELECT distinct O.customer_id
						FROM ORDERS O
						INNER JOIN ORDER_ITEM OI
						ON O.order_id = OI.order_id
						WHERE OI.event_id = (SELECT event_id FROM DELETED)))

	WHILE (@COUNTER != 0)
	BEGIN
		DECLARE @CUST_TOP INT
		SET @CUST_TOP = (SELECT DISTINCT TOP 1 O.customer_id
							FROM ORDERS O
							LEFT JOIN ORDER_ITEM OI
							ON O.order_id = OI.order_id
							WHERE OI.event_id = (SELECT event_id FROM DELETED))

		DECLARE @ORDER_TOP INT
		SET @ORDER_TOP = (SELECT DISTINCT TOP 1 O.order_id
							FROM ORDERS O
							LEFT JOIN ORDER_ITEM OI
							ON O.order_id = OI.order_id
							WHERE OI.event_id = (SELECT event_id FROM DELETED))
		UPDATE CUSTOMERS
		SET  wallet += (SELECT TOP 1 total FROM ORDERS
						WHERE order_id IN 
							(SELECT distinct O.customer_id
							FROM ORDERS O
							INNER JOIN ORDER_ITEM OI
							ON O.order_id = OI.order_id
							WHERE OI.event_id = 
								(SELECT event_id FROM DELETED)))
		WHERE customer_id = @CUST_TOP

		DELETE FROM ORDER_ITEM
		WHERE order_id = @ORDER_TOP
		
		DELETE FROM ORDERS
		WHERE customer_id = @CUST_TOP

		SET @COUNTER = @COUNTER - 1
	END

	DELETE FROM	EVENT
	WHERE event_id = (SELECT event_id FROM DELETED)

END;

EXEC DELETE_EVENT @EVENT_ID = 8

DROP TRIGGER DELETE_AFTER_EVENT_REFUND

/*DELETE FROM VENUE
	WHERE venue_id IN (SELECT V.venue_id
					FROM VENUE V
					INNER JOIN EVENT E
					ON V.venue_id = E.venue_id
					WHERE E.event_id = (SELECT event_id FROM DELETED))*/

