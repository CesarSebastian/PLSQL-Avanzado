/*SQL Dinamico*/
DECLARE 
	v_query VARCHAR2(50);
	v_output VARCHAR2(1);
BEGIN
	v_query := 'SELECT dummy FROM dual'; --Se crea SQL dinamico
	EXECUTE IMMEDIATE v_query INTO v_output; --Solo con consultas SQL dinamicas
	DBMS_OUTPUT.PUT_LINE(v_output); --Imprime
END;
/
SET SERVEROUTPUT ON;
/*CUSTOMER*/
DECLARE 
	v_query VARCHAR2(50);
	v_output VARCHAR2(500);
BEGIN
	v_query := 'SELECT name_cus FROM customer WHERE id_cus = :1';--Parametro
	EXECUTE IMMEDIATE v_query INTO v_output USING 1;
	DBMS_OUTPUT.PUT_LINE(v_output);
END;
/
DECLARE 
	v_query VARCHAR2(50);
	v_output VARCHAR2(500);
BEGIN
	v_query := 'SELECT name_cus FROM customer WHERE id_cus = :cID';--Parametro
	EXECUTE IMMEDIATE v_query INTO v_output USING 1;
	DBMS_OUTPUT.PUT_LINE(v_output);
END;
/
/*Cómo se utiliza*/
DECLARE
	v_name customer.name_cus%TYPE := 'César Limón'; -- Se declaran variables
	v_age customer.age_cus%TYPE := 22;

	TYPE t_name IS VARRAY(200) OF VARCHAR2(50); --Se declara arreglo
	v_names t_name;

	--Consulta query
	v_query VARCHAR2(1000) := 'SELECT name_cus FROM customer '|| 
	'WHERE name_cus = '''||v_name||''' AND age_cus = '||v_age||'';

BEGIN
	EXECUTE IMMEDIATE v_query BULK COLLECT INTO v_names;
	
	--Imprime resultados
	FOR I IN 1..v_names.COUNT() LOOP
		DBMS_OUTPUT.PUT_LINE(v_names(I));
	END LOOP;
END;
/
/**/
CREATE OR REPLACE PROCEDURE update_salary (
	column_value NUMBER, empl_column VARCHAR2, commision NUMBER
) IS 
	v_column VARCHAR2(30);
	sql_stmt VARCHAR2(200);
BEGIN
	SELECT column_name INTO v_column 
	FROM user_tab_cols
	WHERE table_name = 'EMPLOYEES'
	AND column_name = empl_column;
	
	sql_stmt := 'UPDATE employees SET commision = commision + :1 WHERE '||v_column||' = :2';
	EXECUTE IMMEDIATE sql_stmt USING commision, column_value;
	IF SQL%ROWCOUNT > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Para '||empl_column||' se ha actualizado su comisión por '||column_value);
	ELSE 
		DBMS_OUTPUT.PUT_LINE('No se hubo actualización');
	END IF;
	
	EXCEPTION WHEN no_data_found THEN
			DBMS_OUTPUT.PUT_LINE('Columna no valida:'||empl_column);
			
END update_salary;
/
EXECUTE update_salary(1,'ID_EM',20);
	SELECT column_name 
	FROM user_tab_cols
	WHERE table_name like 'EMPLOYEES'	;
UPDATE employees SET commision = 0;
/**/
DECLARE
	plsql_block VARCHAR2(500);
BEGIN
	plsql_block := 'BEGIN update_salary(:cvalue, :cname,:amt); END;';
	EXECUTE IMMEDIATE plsql_block USING 110, 'ID_EM', 10;
END;
/
/*Inyecciciones SQL*/
CREATE TABLE login(
	id NUMERIC NOT NULL,
	usr VARCHAR2(20) NOT NULL,
	psw VARCHAR2(20) NOT NULL,
	PRIMARY KEY(ID)
);
INSERT INTO login VALUES(1,'cesar','123');
INSERT INTO login VALUES(2,'leonardo','456');
INSERT INTO login VALUES(3,'samanta','789');
INSERT INTO login VALUES(4,'karen','qwe');
INSERT INTO login VALUES(5,'karla','asd');

DECLARE
	v_usr login.usr%TYPE := 'cesar';
	v_psw login.psw%TYPE := '123';
	TYPE t_user IS VARRAY(200) OF VARCHAR2(50);
	v_users t_user;
	V_QUERY VARCHAR2(4000) := 'SELECT USR FROM LOGIN WHERE USR='''|| V_USR ||''' AND PSW='''||V_PSW||'''';

BEGIN
	DBMS_OUTPUT.PUT_LINE('SQL: '||v_query);
	EXECUTE IMMEDIATE v_query BULK COLLECT INTO v_users;
	IF v_users.COUNT() > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Bienvenido');
		FOR I IN 1..v_users.COUNT() LOOP
			DBMS_OUTPUT.PUT_LINE(v_users(I));
		END LOOP;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Fallo con login');
	END IF;
END;
/
CREATE OR REPLACE PROCEDURE login_access(
	v_usr IN VARCHAR2, v_psw IN VARCHAR2
) AS 
	TYPE t_user IS VARRAY(200) OF VARCHAR2(50);
	v_users t_user;
	V_QUERY VARCHAR2(4000) := 'SELECT USR FROM LOGIN WHERE USR='''|| V_USR ||''' AND PSW='''||V_PSW||'''';

BEGIN
	DBMS_OUTPUT.PUT_LINE('SQL: '||v_query);
	EXECUTE IMMEDIATE v_query BULK COLLECT INTO v_users;
	IF v_users.COUNT() > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Bienvenido');
		FOR I IN 1..v_users.COUNT() LOOP
			DBMS_OUTPUT.PUT_LINE(v_users(I));
		END LOOP;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Fallo con login');
	END IF;
END;
/
EXECUTE login_access('samanta','124');
/*INYECCION*/
SELECT usr,psw FROM login WHERE usr = 'anyUser' AND psw = 'AnyPassword' OR 1=1 OR ''='';
EXECUTE login_access('anyUser',''' OR 1=1 OR ''''=''');
'OR 1=1 OR ''='''