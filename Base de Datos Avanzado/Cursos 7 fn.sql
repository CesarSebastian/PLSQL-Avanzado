/*Invocación de rutinas externas*/
/*Codigo class se le llama bitcode*/
/*Ejecución de archivos*/
--CMD Solo se ejecuta .class
loadJava -user sys/apps -v -f -r OracleJavaClass.class
/*Utilización de metodo con clase envultorio*/
CREATE OR REPLACE
FUNCTION saluda_wrap(nombre VARCHAR2)
RETURN VARCHAR2
AS 
LANGUAGE JAVA NAME
'OracleJavaClass.saludo(java.lang.String) return java.lang.String';
/
/*Mostrar*/
SELECT saluda_wrap('César')
FROM dual;
/*Borrar clase carada en base de datos*/
DROP JAVA CLASS "OracleJavaClass";
/*Invocar con PLSQL con codigo directo*/
CREATE OR REPLACE AND COMPILE
JAVA SOURCE
NAMED FuentesJava
AS 
public class OracleJava{
	public static String saludo(String nombre){
		return ("Saludos desde JAVA a "+nombre);
	}
}
;
/
CREATE OR REPLACE
FUNCTION saluda_wrap(nombre VARCHAR2)
RETURN VARCHAR2
AS 
LANGUAGE JAVA NAME
'OracleJava.saludo(java.lang.String) return java.lang.String';
/
/*ejecutar*/
SELECT saluda_wrap('César')
FROM dual;
/*
Ejecicio
T1 : usar el comando javaLoad
	-Generar Clase java llamada operacionesAritmeticas
		-suma
		-resta
		-multiplicacion
		-divicion
	-Compilar y subir con javaLoad
	-Crear funcion para invocar clase
	-Ejecutar funcion con resultados
*/
loadJava -user sys/apps -v -f -r Operaciones.class
/*suma*/
CREATE OR REPLACE
FUNCTION suma(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones.suma(int,int) return int';
/
/*resta*/
CREATE OR REPLACE
FUNCTION resta(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones.resta(int,int) return int';
/
/*multiplicacion*/
CREATE OR REPLACE
FUNCTION multiplicacion(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones.multiplicacion(int,int) return int';
/
/*division*/
CREATE OR REPLACE
FUNCTION division(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones.division(int,int) return double';
/
/*ejecucion*/
SELECT division(2,1)
FROM dual;
/**/
DROP JAVA CLASS "Operaciones";
/*
Ejecicio
T2 : usar el comando javaLoad
	-Generar Clase java llamada operacionesAritmeticas
		-suma
		-resta
		-multiplicacion
		-divicion
	-Compilar y subir con javaLoad
	-Crear funcion para invocar clase
	-Ejecutar funcion con resultados
*/
CREATE OR REPLACE AND COMPILE
JAVA SOURCE
NAMED Operaciones2
AS 
public class Operaciones2{
		public static int suma(int a, int b){
		return (a+b);
	}
	public static int resta(int c, int d){
		return (c-d);
	}
	public static int multiplicacion(int w, int x){
		return(w*x);
	}
	public static double division(int y, int z){
		return(y/z);
	}
}
;
/
/*suma*/
CREATE OR REPLACE
FUNCTION suma(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones2.suma(int,int) return int';
/
/*resta*/
CREATE OR REPLACE
FUNCTION resta(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones2.resta(int,int) return int';
/
/*multiplicacion*/
CREATE OR REPLACE
FUNCTION multiplicacion(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones2.multiplicacion(int,int) return int';
/
/*division*/
CREATE OR REPLACE
FUNCTION division(num1 NUMBER,num2 NUMBER)
RETURN NUMBER
AS 
LANGUAGE JAVA NAME
'Operaciones2.division(int,int) return double';
/