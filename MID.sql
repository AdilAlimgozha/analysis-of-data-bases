CREATE TABLE STUDENTS(
STUDENT_ID INT PRIMARY KEY,
STUDENT_NAME VARCHAR (50),
);

CREATE TABLE TEACHERS(
TEACHER_ID INT PRIMARY KEY,
TEACHER_NAME VARCHAR (50));

CREATE TABLE BOOKS(
BOOK_ID INT PRIMARY KEY,
BOOK_NAME VARCHAR (50),
BOOK_AUTHOR VARCHAR (50));

CREATE TABLE ISSUE(
CUSTOMER_ID INT,
BOOK_ID INT FOREIGN KEY REFERENCES BOOKS(BOOK_ID),
ISSUE_DATE DATE,
RETURN_DATE DATE,
PRIMARY KEY (CUSTOMER_ID, BOOK_ID));

CREATE TABLE RETURND(
CUSTOMER_ID INT,
BOOK_ID INT,
RETURN_DATE DATE,
ACTUAL_RETURN DATE,
FINE INT,
CONSTRAINT FK
FOREIGN KEY (CUSTOMER_ID, BOOK_ID) REFERENCES ISSUE(CUSTOMER_ID, BOOK_ID));

ALTER TABLE ISSUE ADD CHECK ( (SELECT TOP 1 STUDENT_ID FROM STUDENTS WHERE ISSUE.CUSTOMER_ID = STUDENTS.STUDENT_ID) IS NOT NULL AND COUNT(ISSUE.CUSTOMER_ID) < 2 );

INSERT INTO STUDENTS
VALUES(101, 'ALI_MUGALIEV'),
(102, 'JOHN_STAM'),
(103, 'ERKE_SAPAROV');

INSERT INTO BOOKS
VALUES(001, 'BOOKNAME', 'AUTHOR'),
(102, 'NAMEBOOK', 'AUTHRR' ),
(103, 'BOK_NAM', 'AUTH');