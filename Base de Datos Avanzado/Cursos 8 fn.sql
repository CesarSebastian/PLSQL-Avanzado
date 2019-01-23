/*Rastreo de dependencias*/
DESC user_dependencies;/*Almacena todos los objetos dependientes*/
/*creación de tabla*/
CREATE TABLE employees(
	id_em NUMERIC NOT NULL, 
	name_em VARCHAR2(30) NOT NULL,
	salary_em NUMERIC NOT NULL,
	PRIMARY KEY(id_em)
);
/*inserciones*/
INSERT INTO employees
VALUES (1,'César Limón',15000);
INSERT INTO employees
VALUES (2,'Karen Cruz',10000);
/*procedimiento*/
CREATE OR REPLACE PROCEDURE p_get_sal(e_id IN NUMERIC)
AS
	v_name VARCHAR2(30);
	v_salary NUMERIC;
BEGIN
	SELECT name_em,salary_em INTO v_name, v_salary
	FROM employees
	WHERE id_em = e_id;
	DBMS_OUTPUT.PUT_LINE('Nombre: '||v_name||' Salario: '||v_salary);
END;--Importante colocar el nombre del procedimiento al terminar procedimiento
/*vista*/
CREATE OR REPLACE VIEW v_get_all_employees
AS 
SELECT * FROM employees;
/*consulta*/
SELECT d.referenced_name, o.status
FROM user_dependencies d, user_objects o
WHERE d.name = o.object_name
AND d.name = 'V_GET_ALL_EMPLOYEES';--Objetos compilados en mayuscula
/**/
SELECT d.referenced_name, o.status
FROM user_dependencies d, user_objects o 
WHERE d.name = o.object_name
AND d.name = 'P_GET_SAL';
/*Alteración*/
ALTER TABLE employees ADD commision NUMERIC;
/*tabla para todas dependencias*/
CREATE TABLE customer(
	id_cus NUMERIC NOT NULL,
	name_cus VARCHAR2(30) NOT NULL,
	age_cus INTEGER NOT NULL,
	address VARCHAR2(100) NOT NULL, 
	PRIMARY KEY(id_cus)
);
INSERT INTO customer
VALUES (1,'César Limón',22,'...');
INSERT INTO customer
VALUES (2,'Karen Cruz',29,'...');
/*paquete*/
CREATE OR REPLACE PACKAGE cetech_student
AS 
	PROCEDURE display(id IN NUMERIC);
END cetech_student;
/
CREATE OR REPLACE PACKAGE BODY cetech_student
IS 
	PROCEDURE display(id IN NUMERIC) IS 
	BEGIN
		DBMS_OUTPUT.PUT_LINE('ID estudiante: '||id);
	END display;
END cetech_student;
/
/*Procedimiento*/
CREATE OR REPLACE PROCEDURE find_customer(p_id IN NUMERIC)
AS 
	v_name VARCHAR2(30);
	v_age INTEGER;
BEGIN
	SELECT name_cus, age_cus INTO v_name,v_age 
	FROM customer
	WHERE id_cus = p_id;
	DBMS_OUTPUT.PUT_LINE('Nombre: '||v_name||' Años: '||v_age);
	cetech_student.display(p_id);
END;
/
/*vista*/
CREATE OR REPLACE VIEW view_fin_all_customers
AS 
SELECT * FROM customer;
/*RASTREO DE DEPENDENCIAS*/
--Formato de columnas 
COLUMN name FORMAT a25
COLUMN type FORMAT a15
COLUMN referenced_type FORMAT a16
COLUMN refecenced_name FORMAT a17

SELECT name, type, referenced_type, referenced_name
FROM all_dependencies --toda la informacion de objetos creados por usuario
WHERE referenced_owner = 'ORACLEDEV';

SELECT name, type, referenced_type, referenced_name
FROM all_dependencies
WHERE referenced_name = 'CUSTOMER';

SELECT name, type, referenced_type, referenced_name
FROM all_dependencies
WHERE owner = 'ORACLEDEV'
AND referenced_type IN ('TABLE','VIEW')
ORDER BY 1,2;
/*Ejecutada solo con usuario SYS*/
SELECT name, type, referenced_type, referenced_name
FROM dba_dependencies
WHERE referenced_name = 'CUSTOMER';
/*Codigo de rastreo DEPTREE*/
@C:\app\cesarsebastian\product\11.2.0\dbhome_1\RDBMS\ADMIN\utldtree.sql
EXEC deptree_fill('PACKAGE','ORACLEDEV','cetech_student');
/**/
COLUMN nested_lev FORMAT 9999
COLUMN type FORMAT a12
COLUMN schema FORMAT a12
COLUMN name FORMAT a25

SELECT * FROM deptree;
