---1st task
create function prod_change_price(@prod_id char(10),@percents float,@decrease_increase char(10))
returns varchar(255)
begin
	declare @newprice float;
	declare @output varchar(255);
	set @newprice = 0
	set @newprice = 
		(
			SELECT (CASE WHEN @decrease_increase = '+' THEN prod_price*(1+@percents/100) WHEN @decrease_increase = '-' THEN prod_price*(1-@percents/100) ELSE -1 END) AS smth
			FROM Products
			WHERE prod_id = @prod_id
		);
	set @output = (case when @newprice> = 0 then cast(@newprice as varchar(255)) else 'Input error' end)
	return @output
end
go 
select dbo.prod_change_price('BNBG01',10,'+') as prod_price;
----

---2nd task
create function FIND_STATE(@vend_idd char(10))
returns VARCHAR(255)
begin
	declare @outputt varchar(255);
	set @outputt = (SELECT IIF(vend_id is null,vend_state,'UNKNOWN') FROM Vendors WHERE vend_id = @vend_idd)
	return @outputt
end
go
PRINT dbo.FIND_STATE('FNG01');
---

---3rd task
create function task3(@country_name varchar(255))
returns @outputt table (vend_n int,cust_n Sint,country varchar(255))
begin
	declare @vend int;
	declare @cust int;
	set @vend = (SELECT COUNT(vend_id) FROM Vendors where vend_country = @country_name)
	set @cust = (SELECT COUNT(cust_id) FROM Customers where cust_country = @country_name)
	insert into @outputt values(@vend,@cust,@country_name)
	return 
end
go
select * FROM dbo.task3('England');
---

---4th task
create function task4(@vend_name VARCHAR(255))
returns VARCHAR(255)
begin
	declare @outputt varchar(255);
	set @outputt = CONCAT(lower(replace((left(@vend_name,CHARINDEX(' ',@vend_name)+1)),' ','.')),'@gmail.com')
	return @outputt
end
go
select vend_name,dbo.task4(vend_name) as vend_email from Vendors
---

---5th task
create function task5(@datee varchar(255))
returns int 
begin
	declare @num int;
	set @num = (SELECT count(order_date) FROM Orders WHERE  DATENAME(month,order_date) = @datee)
	return @num 
end
go
select dbo.task5('May');
---

---6th task
create function task6(@ordernum int)
returns int 
begin
	declare @num int;
	set @num = (SELECT datediff(day,order_date,getdate()) FROM Orders WHERE  order_num = @ordernum)
	return @num 
end
go
select dbo.task6(20005) as daysAfterOrder;
---

---7th task
create function task7()
returns table
as 
return(select *,CONCAT(CAST(quantity*item_price as varchar(255)),'$') as total_price from OrderItems) 
select * FROM dbo.task7();
---

---8th task
CREATE FUNCTION task8(@cust_idd VARCHAR(255))
returns VARCHAR(255)
begin
declare @adress varchar(255) = (select cust_address from Customers where cust_id = @cust_idd)
declare @output varchar(255) = ''
while PATINDEX('%[0-9]%',@adress)>0
	begin
		set @output = @output+SUBSTRING(@adress,PATINDEX('%[0-9]%',@adress),1)
		set @adress = stuff(@adress,PATINDEX('%[0-9]%',@adress),1,'')
	end
	return @output
end
go
select dbo.task8(1000000001)
---

---task9
CREATE FUNCTION task9(@word VARCHAR(255))
RETURNS VARCHAR(255)
begin
declare @output varchar(255)
set @output = (CASE WHEN reverse(@word) = @word THEN 'YES' ELSE 'NO' END)
return @output
end
go
PRINT dbo.task9('AHA')
PRINT dbo.task9('YES')
---

---10th task
---Returns number of items when given correct product id else retuns error message
CREATE FUNCTION task10(@prod_idd VARCHAR(255))
RETURNS VARCHAR(255)
begin
declare @output varchar(255)
set @output = (CASE WHEN (@prod_idd in (SELECT prod_id FROM Products)) THEN CAST((SELECT amount FROM Products WHERE @prod_idd = prod_id) as varchar(255))
			   ELSE 'Such product does not exist' END)
return @output
end
go
print dbo.task10('akjakj')
print dbo.task10('BNBG01')
---
