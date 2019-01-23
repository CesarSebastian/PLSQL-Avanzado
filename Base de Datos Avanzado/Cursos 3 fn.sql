SET SERVEROUTPUT ON;
/*Manejo de IF con manejo procedure dentro del blocke PL SQL*/
DECLARE 
	a number;
	b number;
	c number;
PROCEDURE findMind(x IN number, y IN number, z OUT number) IS
BEGIN
	IF x < y THEN
		z:=x;
	ELSE 
		z:=y;
	END IF;
END;
BEGIN
	a:= 23;
	b:= 45;
	findMind(a,b,c);
	DBMS_OUTPUT.PUT_LINE('El minimo entre '||a||' y '||b||' es '||c);
END;
/
/*Raíz Cuadrada*/
DECLARE
	a NUMBER;
PROCEDURE cuadrado(x IN OUT NUMBER) IS
BEGIN 
	x := x * x;
END;
BEGIN
	 a:= 19;
	 cuadrado(a);
	 DBMS_OUTPUT.PUT_LINE('El número al cuadrado es '||a);
END;
/
/*FUNCIONES - Esqueleto*/
CREATE OR REPLACE FUNCTION [NombreFuncion]
RETURN [TIPO] IS
	[variable] [TIPO] := [valor];
BEGIN
	[Accion]
RETURN [variable];
END;
/
/*EJEMPLO*/
CREATE OR REPLACE FUNCTION totalEmpleados
RETURN NUMBER IS
	total NUMBER (2) := 0;
BEGIN
	SELECT 
		COUNT(id)
		INTO total
	FROM
		empleado;
RETURN total;
END;
/
/*Ejecución*/
--1
SELECT totalEmpleados FROM dual;
--2
DECLARE 
	total NUMBER(2);
BEGIN
	total := totalEmpleados();
	DBMS_OUTPUT.PUT_LINE('Número de empleados es '||total);
END;
/ 
/*Paquetes -- El pack*/
/*Esqueleto*/
CREATE PACKAGE [NombrePaquete] AS
	[Cuerpo del Paquete]
END [NombrePaquete];
/
/*Ejemplo*/
CREATE PACKAGE salario AS
	PROCEDURE salarioPro(c_id empleado.id%TYPE);
END salario;
/
/*Ejercicio*/
CREATE OR REPLACE PACKAGE BODY salario AS
	PROCEDURE salarioPro(c_id empleado.id%TYPE) IS
	c_salario empleado.salario%TYPE;
	BEGIN
		SELECT
			salario INTO c_salario
		FROM
			empleado
		WHERE 
			id = c_id;
		DBMS_OUTPUT.PUT_LINE('El salario es '||c_salario);
	END salarioPro;
END salario;
/
/*Ejecución*/
DECLARE
	codigo empleado.id%TYPE := &IngresaSalario;
BEGIN
	salario.salarioPro(codigo);
END;
/
/*Ejercicio */

CREATE OR REPLACE PACKAGE empleadoABC AS
	PROCEDURE agregarEmpleado(c_id empleado.id%TYPE,
		c_nombre empleado.nombre%TYPE,
		c_edad empleado.edad%TYPE,
		c_direccion empleado.direccion%TYPE,
		c_salario empleado.salario%TYPE);
	PROCEDURE eliminarEmpleado(c_id empleado.id%TYPE);

	PROCEDURE listarEmpleado;

END empleadoABC;
/
/*Cuerpo*/
CREATE OR REPLACE PACKAGE BODY empleadoABC AS
	PROCEDURE agregarEmpleado(c_id empleado.id%TYPE,
		c_nombre empleado.nombre%TYPE,
		c_edad empleado.edad%TYPE,
		c_direccion empleado.direccion%TYPE,
		c_salario empleado.salario%TYPE) IS
	BEGIN
		INSERT INTO empleado VALUES 
		(c_id,c_nombre,c_edad,c_direccion,c_salario);
		DBMS_OUTPUT.PUT_LINE('Empleado Agregado');
	END agregarEmpleado;
	/*Eliminar*/
	PROCEDURE eliminarEmpleado(c_id empleado.id%TYPE) IS
	BEGIN
		DELETE FROM empleado WHERE id = c_id;
	END eliminarEmpleado;
	/*Listar*/
	PROCEDURE listarEmpleado IS
	BEGIN
		FOR rec IN (
		SELECT * FROM empleado
		)
		LOOP
			DBMS_OUTPUT.PUT_LINE(rec.nombre);
		END LOOP;
	END listarEmpleado;
END empleadoABC;
/
/*Ejecución*/
DECLARE
	c_id empleado.id%TYPE := 7;
	c_nombre empleado.nombre%TYPE := 'Karen';
	c_edad empleado.edad%TYPE := 25;
	c_direccion empleado.direccion%TYPE := 'Sierra Mojada';
	c_salario empleado.salario%TYPE := 9000;
BEGIN
	empleadoABC.agregarEmpleado(c_id,c_nombre,c_edad,c_direccion,c_salario);
END;
/
DECLARE
	c_id empleado.id%TYPE := 7;
BEGIN
	empleadoABC.eliminarEmpleado(c_id);
END;
/
DECLARE
BEGIN
	empleadoABC.listarEmpleado;
END;
/