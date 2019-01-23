/*Conexion*/
Connect sys as sysdba;
/*CREACION DE USUARIO*/
CREATE TABLE Alumno(
id number(2) primary key, 
nombre varchar2 (10) not null,
apellidoParterno varchar2 (20) not null, 
apellidoMaterno varchar2 (20) not null,
edad number (2) not null
);
/*COMANDO DE CREACION DE PRIVILEGIOS*/
GRANT CREATE TABLE TO OracleDev;
/*COMANDO DE PRIVILEGIOS TRABLE ESPACE*/
ALTER USER OracleDev QUOTA 100M ON USERS;
/*ELIMINACION*/
DROP TABLE Alumno;
/*INSERT INTO*/
INSERT INTO Alumno(id,nombre,apellidoParterno,apellidoMaterno,edad) 
VALUES (1,'Cesar','Limon','Ruiz',21);
INSERT INTO OracleDev.Alumno(id,nombre,apellidoParterno,apellidoMaterno,edad) 
VALUES (2,'Adrian','Limon','Ruiz',16);
COMMIT;
/*creacion de usuario*/
create user OracleDev identified by 123 default tablespace users;
/*creacion de session*/
GRANT CREATE SESSION TO OracleDev;
/*privilegios de vistas*/
GRANT CREATE VIEW TO OracleDev;
/*privilegios de tipos*/
GRANT CREATE Procedure TO OracleDev;
/*privilegios de procedimientos*/
GRANT CREATE TYPE TO OracleDev;
/*consulta*/
SELECT * FROM OracleDev.Alumno;
/*Asignar permisos de visualizacion en una tabla a otro usuario*/
GRANT SELECT ON Alumno TO ProgramDev;
/*Quitar permisos*/
REVOKE SELECT ON Alumno FROM ProgramDev;
/*Privilegios de insert*/
GRANT INSERT ON Alumno TO ProgramDev;
GRANT UPDATE ON Alumno TO ProgramDev;
UPDATE OracleDev.Alumno SET edad = 17 WHERE id = 2;
/*View,Procedure,Index*/
CREATE OR REPLACE VIEW AlumnoView AS (SELECT * FROM Alumno WHERE id <> 0);
SELECT * FROM AlumnoView;
/*Asignar todos los privilegios*/
GRANT ALL ON FROM 'usuario';