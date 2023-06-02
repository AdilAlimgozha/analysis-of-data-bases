create database test; 
use test;
create table aboniment(num_passport varchar(28) primary key, full_name varchar(128), 
address varchar(128)); 

create table operator (name varchar(128) primary key, code varchar(28), num_numbers int);

create table connect (phone_number varchar(28) primary key, 
num_passport varchar(28), name_op varchar(128) ,
tarif_plan varchar(128), debt int, date_start datetime,
foreign key(num_passport) references aboniment(num_passport),
foreign key(name_op) references operator(name));

insert into aboniment values
('KZ1234567', 'Askanbayev Askar Serikovich', 'Almaty, Orbita-1-5-25'),
('KZ1000000', 'Smailov Damen Kydyruly', 'Astana, Egemen, 22'),
('KZ1234588', 'Drikulova Asem Magzhankyzy', 'Oskemen, Lenina, 35'),
('RU25893256', 'Petrov Dmitryi Andreevich', 'Moskva, Aleksino,123'),
('TR56N235981', 'Sultanahmet Amir Berdybekugly', 'Kemer, Sunbeach, 1'); 

insert into operator values
('tele2', '+747, +707', 1000000),
('activ', '+701', 700000),
('kcell', '+702', 50000),
('beeline', '+705, +777', 85000);

insert into connect values
('+77078256932', 'KZ1234567', 'tele2', 'VSE2', 0, getdate()),
('+77052589865', 'RU25893256', 'beeline', 'All1', 0, getdate());

select * from aboniment
select * from connect
select * from operator



GO
CREATE FUNCTION CountNonRes()
RETURNS INT
BEGIN
	DECLARE @total_num INT = (
	SELECT COUNT(num_passport)
	FROM aboniment
	WHERE num_passport NOT LIKE 'KZ%')

	RETURN @total_num
END
GO

SELECT DBO.CountNonRes() as CountNonRes

GO
CREATE FUNCTION ABON_OPER(@NUM_PASS VARCHAR(28),
@NAME_OP VARCHAR(128))

RETURNS INT
BEGIN
	DECLARE @COUNT_OF_AB_OP INT = (
		SELECT COUNT(name_op)
		FROM CONNECT
		--WHERE num_passport = @NUM_PASS AND name_op = @NAME_OP
		GROUP BY num_passport, name_op
		HAVING num_passport = @NUM_PASS AND name_op = @NAME_OP)

	RETURN @COUNT_OF_AB_OP
END
GO

DROP FUNCTION ABON_OPER

print DBO.ABON_OPER('KZ1234567', 'tele2')





CREATE VIEW vw_getRANDValue
AS
SELECT RAND() AS Value

GO
CREATE FUNCTION RND_NUM_GEN(@op_name VARCHAR(45))
RETURNS VARCHAR(25)

BEGIN
	DECLARE @RND_NUMBER VARCHAR(25)
	DECLARE @RESULT VARCHAR(25)
	SET @RND_NUMBER = 0

	IF @op_name = 'beeline'
		SET @RESULT = '+7705'
	ELSE IF @op_name = 'tele2'
		SET @RESULT = '+7707'
	ELSE IF @op_name = 'activ'
		SET @RESULT = '+7701'
	ELSE
		SET @RESULT = '+7700'

	WHILE (LEN(@RESULT) < 12)
		BEGIN
			SET @RND_NUMBER = (select floor((select value from vw_getRANDValue)*(9-0)+0))
			SET @RESULT = CONCAT(@RESULT, CAST(@RND_NUMBER AS CHAR))
		END

	RETURN @RESULT
END
GO

PRINT dbo.RND_NUM_GEN('beeline')

