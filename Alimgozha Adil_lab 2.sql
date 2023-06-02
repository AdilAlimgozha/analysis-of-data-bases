--Alimgozha Adil
--Lab 2

SELECT * FROM EMPLOYEES
SELECT * FROM DEPARTMENTS
SELECT * FROM JOB_GRADES

ALTER TABLE EMPLOYEES
ADD DEPARTMENT_ID INT


UPDATE EMPLOYEES
SET DEPARTMENT_ID = 10
WHERE JOB_ID LIKE 'AD%'

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 20
WHERE JOB_ID LIKE 'MK%'

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 50
WHERE JOB_ID LIKE 'SH%'

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 60
WHERE JOB_ID LIKE 'IT%'

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 80
WHERE JOB_ID LIKE 'SA%'

UPDATE EMPLOYEES
SET DEPARTMENT_ID = 110
WHERE JOB_ID LIKE 'AC%'


/*1. Write a query to display all the information about employees whose salaries are higher
than the average salary of programmers.*/
SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (
	SELECT AVG(SALARY)
	FROM EMPLOYEES
	WHERE JOB_ID = 'IT_PROG');

/*2. Write a query to display the id, full names and salary of the employees with the
minimum salaries in each department.*/
SELECT EMPLOYEE_ID, FULL_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY IN (
	SELECT MIN(SALARY)
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID);

/*3. Write a query to display the information of department managed by the manager with
the most experience (the one who got the job first).
consider spaces).*/
SELECT *
FROM EMPLOYEES
WHERE LEN(REPLACE(FULL_NAME, ' ', '')) IN (
	SELECT MAX(LEN(REPLACE(FULL_NAME, ' ', '')))
	FROM EMPLOYEES);

/*5. Write a query to display the average salary for the most numerous department.*/
SELECT AVG(SALARY)
AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(DEPARTMENT_ID) = (
	SELECT MAX(COUNT_D)
	FROM (
		SELECT COUNT(DEPARTMENT_ID) AS COUNT_D
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID) AS MAX_COUNT_D);

/*6. Write a query to display in which departments the minimum salary is greater than the
minimum salary in the 50th department.*/
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN (
	SELECT DEPARTMENT_ID
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
	HAVING MIN(SALARY) > (
		SELECT MIN(SALARY)
		FROM EMPLOYEES
		WHERE DEPARTMENT_ID = 50));

/*7. Write a query to display the maximum average salary by department.*/
SELECT MAX(AVG_SALARY_DEP.AVG_SALARY) AS MAX_SALARY
FROM (
	SELECT AVG(SALARY) AS AVG_SALARY
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID) AS AVG_SALARY_DEP;

/*8. Write a query to display the department names for each employee using JOIN.*/
SELECT FULL_NAME, DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/*9. Write a query to display all departments in which there is no employee.
	SELECT DEPARTMENT_ID
	FROM EMPLOYEES);

/*10. Write a query to display the JOB_Grade for each employee.*/
SELECT FULL_NAME, GRA
FROM EMPLOYEES E
JOIN JOB_GRADES J
ON J.LOWEST_SAL <= E.SALARY AND E.SALARY <= J.HIGHEST_SAL;

/*11. Write a query to display the full name, job title, department name of employee, and hire
date for all the jobs which started on or after 1st of January, 1995 and ending with on or
before 11th of Febraury, 2021 and whose GRA is A, B or C.
monthly and annual mandatory pension contributions (10% of the salary) indicating the
column �montly_pension_contribution�, �annual_pension_contribution� and show also
medicine contributions for the rest money (10% of the remained salary after pension
contributions).*/
SELECT FULL_NAME, LOC_NAME,
whose average salaries are the greatest among others.*/
SELECT TOP 3 LOC_NAME, AVG(SALARY) AS AVG_SAL
only their colleagues, without a manager.*/
SELECT FULL_NAME AS COLLEAGUES
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID = 50 AND E.EMPLOYEE_ID != 144 AND E.EMPLOYEE_ID != 142 AND E.EMPLOYEE_ID != D.MANAGER_ID;

/*16. Write a query to display all the information about the employees whose
department location is <select any city from the table LOCATIONS at your
discretion>.*/
SELECT EMPLOYEE_ID, LOC_NAME, 
FULL_NAME,EMAIL, PHONE_NUMBER, 
HIRE_DAT, JOB_ID, 
SALARY, E.DEPARTMENT_ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOC_ID
WHERE LOC_NAME = 'Astana';

/*17. Write a query to display all employees who are not managers.
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(
	SELECT MANAGER_ID
	FROM DEPARTMENTS
	WHERE MANAGER_ID IN(
		SELECT EMPLOYEE_ID AS ID_OF_SUBORD
at least 2 employees are working.*/
SELECT COUNTRY_NAME, LOC_NAME AS CITY, D.DEPARTMENT_ID, NUM_OF_EMPLOYEES
FROM COUNTRIES C
INNER JOIN LOCATIONS L
ON C.COUNTRY_ID = L.COUNTRY_ID
INNER JOIN DEPARTMENTS D
ON L.LOC_ID = D.LOCATION_ID
INNER JOIN (
	SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS NUM_OF_EMPLOYEES
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID) AS DEP_NUM_EMPL
ON D.DEPARTMENT_ID = DEP_NUM_EMPL.DEPARTMENT_ID
WHERE NUM_OF_EMPLOYEES >= 2;

/*22. Your query. 
Show all infromation about employee with MAX salary in Omsk*/
SELECT *
FROM EMPLOYEES E
INNER JOIN (
	SELECT LOC_NAME AS CITY, MAX(SALARY) AS MAX_SALARY_IN_CITY
	FROM EMPLOYEES E
	INNER JOIN DEPARTMENTS D
	ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
	INNER JOIN LOCATIONS L
	ON D.LOCATION_ID = L.LOC_ID
	GROUP BY L.LOC_NAME
	HAVING LOC_NAME = 'Omsk') AS MAX_OMSK
ON E.SALARY = MAX_OMSK.MAX_SALARY_IN_CITY