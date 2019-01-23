/*Areglos PL SQL*/
CREATE OR REPLACE TYPE [nombreAreglo] IS VARRAY(n) OF VARCHAR2(20);
/*Ejemplo*/
CREATE OR REPLACE TYPE arregloPrueba IS VARRAY(10) OF VARCHAR2(20);
/
/*Ejercicio*/
DECLARE
	TYPE nombres IS VARRAY(9) OF VARCHAR2(20);
	TYPE calificaciones IS VARRAY(9) OF NUMBER;
	nombre nombres;
	marcador calificaciones ;
	total NUMBER; 
BEGIN			/*Constructor*/
	nombre := nombres('Cesar','Boué','Oscar','Yasmin','Karen','Emmanuel','Omar','Dona','Saul');
	marcador := calificaciones(10,5,6,8,7,9,8,5,6);
	total := nombre.COUNT;
	DBMS_OUTPUT.PUT_LINE('Total de alumnos es '||total);
	FOR i IN 1 .. total LOOP
		DBMS_OUTPUT.PUT_LINE('Estudiante '||nombre(i)||' calificación '||marcador(i));
	END LOOP;
END;
/
/*Arreglo, listado*/
DECLARE
	cursor c_empleados IS SELECT nombre FROM Empleado; 
	TYPE e_lista IS VARRAY(9) OF Empleado.nombre%TYPE;
	listaNombres e_lista := e_lista();
	contador INTEGER := 0;
BEGIN			
	FOR i IN c_empleados LOOP
		contador :=contador+1;
		listaNombres.EXTEND;
		listaNombres(contador) := i.nombre;
		DBMS_OUTPUT.PUT_LINE('Empleado ('||contador||') '||listaNombres(contador));
	END LOOP;
END;
/
/*Colecciones - Collections PL SQL*/
/*Ejemplo*/
DECLARE
	TYPE salario IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
	salarioLista salario;
	nombre VARCHAR2(20);
BEGIN			
	--Agregación de elementos
	salarioLista('César') := 9000;
	salarioLista('Karen') := 9000;
	salarioLista('Samanta') := 9000;
	salarioLista('Yasmin') := 9000;
	salarioLista('Oscar') := 9000;
	nombre := salarioLista.FIRST;
	WHILE nombre IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('El empleado '||nombre||' gana '||TO_CHAR(salarioLista(nombre)));
		nombre := salarioLista.NEXT(nombre);
	END LOOP;
END;
/
/*Array asocitivo*/
DECLARE
	cursor c_empleados IS SELECT nombre FROM empleado;
	TYPE c_lista IS TABLE OF empleado.nombre%TYPE INDEX BY BINARY_INTEGER;
	listaNombres c_lista;
	contador INTEGER := 0;
BEGIN			
	FOR n IN c_empleados LOOP 
	contador := contador + 1;
	listaNombres(contador) := n.nombre;
	DBMS_OUTPUT.PUT_LINE('Empleado ('||contador||'): '||listaNombres(contador));
	END LOOP;
END;
/
/*ejemplo*/
/*Array asocitivo*/
DECLARE
	TYPE c_lista IS TABLE OF empleado.nombre%TYPE INDEX BY BINARY_INTEGER;
	listaNombres c_lista;
BEGIN			
	listaNombres(1):= 'Yasmin';
	listaNombres(2):= 'Karen';
	listaNombres(3):= 'César';
	listaNombres(4):= 'Oscar';
	DBMS_OUTPUT.PUT_LINE('nombre: '||listaNombres(1));
END;
/
/*Tabla anidada*/
DECLARE
	TYPE nombre IS TABLE OF VARCHAR2(20);
	TYPE calificaciones IS TABLE OF INTEGER;
	nombres nombre;
	marcador calificaciones;
	total INTEGER;
BEGIN			
	nombres := nombre('Cesar','Boué','Oscar','Yasmin','Karen','Emmanuel','Omar','Dona','Saul');
 	marcador := calificaciones(10,5,6,8,7,9,8,5,6);
 	total := nombres.COUNT;
 	DBMS_OUTPUT.PUT_LINE('Total de alumnos es '||total);
 	FOR i IN 1 .. total LOOP
		DBMS_OUTPUT.PUT_LINE('Estudiante '||nombres(i)||' calificación '||marcador(i));
	END LOOP;
END;
/
/*Tabla anidada %ROWTYPE*/
DECLARE
	cursor c_empleados IS SELECT nombre FROM empleado;
	TYPE c_lista IS TABLE OF empleado.nombre%TYPE;
	nombre c_lista := c_lista();
	contador INTEGER := 0;
BEGIN			
	FOR n IN c_empleados LOOP
		contador := contador + 1;
		nombre.EXTEND;
		nombre(contador) := n.nombre;
		DBMS_OUTPUT.PUT_LINE('Empleado ('||contador||') '||nombre(contador));
	END LOOP;
END;
/