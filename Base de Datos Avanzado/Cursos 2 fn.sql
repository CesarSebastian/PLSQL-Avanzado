/*Sentencia PL-SQL*/
SET SERVEROUTPUT ON;
	/*Se utiliza para el encendido de la impresión (Solo se utiliza una vez)*/
DECLARE 
	/*Blocke de declaración*/
BEGIN
	/*Declaración a ejecutar*/
EXCEPTION
	/*Linea de excepciones*/
END;
	/*Fin de blocke*/
/
	/*Indicación de finalización*/	
/*ejemplo PL-SQL*/
SET SERVEROUTPUT ON;
DECLARE 
	mensaje VARCHAR2 (20) := 'Hola Mundo';
BEGIN
	DBMS_OUTPUT.PUT_LINE(mensaje);
END;
	/
/*Ejecicio NÚMEROS*/
DECLARE 
	numero1 INTEGER := 1;
	numero2 REAL := 1;
	numero3 DOUBLE PRECISION := 1;
BEGIN
	DBMS_OUTPUT.PUT_LINE(numero1+numero2+numero3);
END;
	/
/*Definir por usuario*/
DECLARE 
	SUBTYPE name IS CHAR(20);
	SUBTYPE mensaje IS VARCHAR2(100);
	saludo name;
	greentings mensaje;
BEGIN
	saludo := 'Todos';
	greentings := 'Estoy trabajando con PL-SQL';
	DBMS_OUTPUT.PUT_LINE('Hola a'||saludo||greentings);
END;
	/
/*Declaraciones*/
DECLARE 
	/*Declaraciones de las variables con valor por defecto*/
	contador BINARY_INTEGER := 0;
	mensaje VARCHAR2(100) DEFAULT 'Bienvenido a PL/SQL'; 
BEGIN
	/*Impresión*/
	DBMS_OUTPUT.PUT_LINE(contador);
	DBMS_OUTPUT.PUT_LINE(mensaje);
END;
	/
/*Asignación por resultado*/
DECLARE 
	a INTEGER := 10;
	b INTEGER := 20;
	c INTEGER := 0; 
	d REAL;
BEGIN
	c := a + b;--Asignación por resultado
	DBMS_OUTPUT.PUT_LINE('El valor de c es ' || c);
	d := 70.00 / 3.00;--Asignación por resultado
	DBMS_OUTPUT.PUT_LINE('El valor de d es ' || d);
END;
	/
/*Variables locales y globales*/
DECLARE --Global
	num1 NUMBER := 95;
	num2 NUMBER := 21;
BEGIN--Local
	DBMS_OUTPUT.PUT_LINE('El primer número es ' || num1);
	DBMS_OUTPUT.PUT_LINE('El segundo número es ' || num2);
	DECLARE 
		num1 NUMBER := 21;
		num2 NUMBER := 95;
	BEGIN
		DBMS_OUTPUT.PUT_LINE('El segundo/primer número es ' || num1);
		DBMS_OUTPUT.PUT_LINE('El segundo/segundo número es ' || num2);
	END;
END;
	/
/*Asignación por resultado de variable*/

CREATE TABLE EMPLEADO(
id number(2) primary key, 
nombre varchar2 (10) not null,
edad number (2) not null, 
direccion varchar2 (20),
salario NUMERIC (6,2) 
);
INSERT INTO EMPLEADO VALUES 
(1,'César',21,'Sierra Mojada',5000.50);
INSERT INTO EMPLEADO VALUES 
(2,'Yasmin',25,'Sierra Mojada',9000.50);
INSERT INTO EMPLEADO VALUES 
(3,'Oscar',21,'Sierra Mojada',5000.50);
INSERT INTO EMPLEADO VALUES 
(4,'Ricardo ',20,'Sierra Mojada',9000.50);
INSERT INTO EMPLEADO VALUES 
(5,'Omar',26,'Sierra Mojada',9000.50);

DECLARE 
	id_e EMPLEADO.id%type := 1;
	nombre_e EMPLEADO.nombre%type;
	direccion_e EMPLEADO.direccion%type;
	salario_e EMPLEADO.salario%type;
BEGIN
	SELECT 
		nombre,direccion,salario INTO nombre_e, direccion_e,salario_e
	FROM
		EMPLEADO
	WHERE 
		id = id_e;
	DBMS_OUTPUT.PUT_LINE('Nombre '||nombre_e||' de '||direccion_e||' gana '||salario_e);
END;
	/
/*Declaración de constantes*/
DECLARE --ERROR
	pi CONSTANT NUMBER := 3.1416;
BEGIN
	pi := 4;
END;
	/
DECLARE --CORRECTO
	pi CONSTANT NUMBER := 3.1416;
BEGIN
	DBMS_OUTPUT.PUT_LINE(pi);
END;
	/

/*CREACIÓR DE PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE holaMundo
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hola mundo');
END holaMundo;--Importante colocar el nombre del procedimiento al terminar procedimiento
	/
EXECUTE holaMundo;
/*Blocke SQL anomino/procedimiento*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('Bye Bye');
END ;
	/