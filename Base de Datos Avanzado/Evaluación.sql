/*
Examen Base de datos avanzado

1. Ejercicio: Diseñe un diagrama E-R que represente lo siguiente:

A) Se desea almacenar la información que se maneja en una escuela. Un maestro puede impartir al menos una 
materia en dicha escuela. Las materias permitidas son: Oracle basico, PLSQL, Oracle Admin. Los alumnos pueden 
estar inscritos en al menos un curso para este ciclo escolar.

2. Cree las sentencias DDL para el diagrama E-R anterior.*/

CREATE TABLE Alumnos(
    id_alumn          VARCHAR2 (10) NOT NULL ,
    nombre_alumn      VARCHAR2 (100) NOT NULL ,
    apellidoPat_alumn VARCHAR2 (100) NOT NULL ,
    apellidoMat_alumn VARCHAR2 (100) NOT NULL ,
    fechaNac_alumn    VARCHAR2 (10)
  ) ;
ALTER TABLE Alumnos ADD CONSTRAINT Alumnos_PK PRIMARY KEY ( id_alumn ) ;


CREATE TABLE Cursos(
    id_curso     NUMBER NOT NULL ,
    nombre_curso VARCHAR2 (999) NOT NULL ,
    inicio_curso VARCHAR2 (10) NOT NULL ,
    fin_curso    VARCHAR2 (10) ,
    precio_curso NUMERIC (9) ,
    detalle_MaestroMateriaVARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE Cursos ADD CONSTRAINT Detalle_MaestroMateria_PK PRIMARY KEY (
id_curso ) ;


CREATE TABLE Detalle_CursosAlumnos
  (
    id_dca           NUMBER (3) NOT NULL ,
    Alumnos_id_alumn VARCHAR2 (10) NOT NULL ,
    Cursos_id_curso  NUMBER NOT NULL
  ) ;
ALTER TABLE Detalle_CursosAlumnos ADD CONSTRAINT Detalle_CursosAlumnos_PK
PRIMARY KEY ( id_dca ) ;


CREATE TABLE Maestros_cet(
    id_maes          VARCHAR2 (10) NOT NULL ,
    nombre_maes      VARCHAR2 (50) NOT NULL ,
    apellidoPat_maes VARCHAR2 (50) NOT NULL ,
    apellidoMat_maes VARCHAR2 (50) NOT NULL ,
    fechaNac_maes    VARCHAR2 (10)
  ) ;

ALTER TABLE Maestros_cet ADD CONSTRAINT Maestros_cet_PK PRIMARY KEY ( id_maes );


CREATE TABLE Materias(
    id_mate    NUMBER (3) NOT NULL ,
    nombre_mat VARCHAR2 (999) NOT NULL
  ) ;
ALTER TABLE Materias ADD CONSTRAINT Materias_PK PRIMARY KEY ( id_mate ) ;


CREATE TABLE detalle_MaestroMateria(
    Maestros_cet_id_maes VARCHAR2 (10) NOT NULL ,
    Materias_id_mate     NUMBER (3) NOT NULL
  ) ;
ALTER TABLE detalle_MaestroMateria ADD CONSTRAINT MaestroMateria_PK
PRIMARY KEY ( Maestros_cet_id_maes ) ;


ALTER TABLE Cursos ADD CONSTRAINT detalle_MaestroMateria_FK FOREIGN KEY
( detalle_MaestroMateria ) REFERENCES
detalle_MaestroMateria ( Maestros_cet_id_maes ) ;

ALTER TABLE Detalle_CursosAlumnos ADD CONSTRAINT
CursosAlumnos_Alumnos_FK FOREIGN KEY ( Alumnos_id_alumn ) REFERENCES
Alumnos ( id_alumn ) ;

ALTER TABLE Detalle_CursosAlumnos ADD CONSTRAINT
CursosAlumnos_Cursos_FK FOREIGN KEY ( Cursos_id_curso ) REFERENCES
Cursos ( id_curso ) ;

ALTER TABLE detalle_MaestroMateria ADD CONSTRAINT
MaestroMateria_Maestros_cet_FK FOREIGN KEY ( Maestros_cet_id_maes )
REFERENCES Maestros_cet ( id_maes ) ;

ALTER TABLE detalle_MaestroMateria ADD CONSTRAINT
MaestroMateria_Materias_FK FOREIGN KEY ( Materias_id_mate ) REFERENCES
Materias ( id_mate ) ;
/*3. Cree un paquete que permita controlar las operaciones alta, baja, consulta por ID 
y actualización para Alumnos,Materias y Maestros.*/
/*Alumnos*/
CREATE OR REPLACE PACKAGE alumnosABC AS
	PROCEDURE agregarAlumno(a_id Alumnos.id_alumn%TYPE,       
							a_nom Alumnos.nombre_alumn%TYPE,      
							a_app Alumnos.apellidoPat_alumn%TYPE, 
							a_apm Alumnos.apellidoMat_alumn%TYPE, 
							a_fec Alumnos.fechaNac_alumn%TYPE);

	PROCEDURE eliminaAlumno(a_id Alumnos.id_alumn%TYPE);

	PROCEDURE consultaAlumno(a_id Alumnos.id_alumn%TYPE);

	PROCEDURE actualizarAlumno(a_id Alumnos.id_alumn%TYPE,a_fec Alumnos.fechaNac_alumn%TYPE);
END alumnosABC;
/

CREATE OR REPLACE PACKAGE BODY alumnosABC AS
	PROCEDURE agregarAlumno(a_id Alumnos.id_alumn%TYPE,       
							a_nom Alumnos.nombre_alumn%TYPE,      
							a_app Alumnos.apellidoPat_alumn%TYPE, 
							a_apm Alumnos.apellidoMat_alumn%TYPE, 
							a_fec Alumnos.fechaNac_alumn%TYPE) IS 
	BEGIN 
		INSERT INTO Alumnos VALUES (a_id,a_nom,a_app,a_apm,a_fec);
		DBMS_OUTPUT.PUT_LINE('Alumno agregado');
	END agregarAlumno;

	PROCEDURE eliminaAlumno (a_id alumnos.id_alumn%TYPE) IS
	BEGIN
		DELETE FROM alumnos WHERE id_alumn = a_id;
		DBMS_OUTPUT.PUT_LINE('Alumno eliminado');
	END eliminaAlumno;

	PROCEDURE consultaAlumno (a_id alumnos.id_alumn%TYPE) IS 
		a_nom Alumnos.nombre_alumn%TYPE;      
		a_app Alumnos.apellidoPat_alumn%TYPE; 
		a_apm Alumnos.apellidoMat_alumn%TYPE; 
		a_fec Alumnos.fechaNac_alumn%TYPE;
	BEGIN 
		SELECT nombre_alumn,apellidoPat_alumn,apellidoMat_alumn,fechaNac_alumn INTO a_nom,a_app,a_apm,a_fec
		FROM alumnos
		WHERE id_alumn = a_id;
		DBMS_OUTPUT.PUT_LINE(a_nom||' '||a_app||' '||a_apm||' '||a_fec);
	END consultaAlumno;

	PROCEDURE actualizarAlumno(a_id Alumnos.id_alumn%TYPE,a_fec Alumnos.fechaNac_alumn%TYPE) IS 
	BEGIN
		UPDATE alumnos SET fechaNac_alumn = a_fec WHERE id_alumn = a_id;
		DBMS_OUTPUT.PUT_LINE('Alumno modificado');
	END actualizarAlumno;
END alumnosABC;
/
/*Materias*/
CREATE OR REPLACE PACKAGE materiasABC AS
	PROCEDURE agregarMateria(m_id materias.id_mate%TYPE,  
							 m_nom materias.nombre_mat%TYPE);

	PROCEDURE eliminaMateria(m_id materias.id_mate%TYPE);

	PROCEDURE consultaMateria(m_id materias.id_mate%TYPE);

	PROCEDURE actualizarMateria(m_id materias.id_mate%TYPE,m_nom materias.nombre_mat%TYPE);
END materiasABC;
/

CREATE OR REPLACE PACKAGE BODY materiasABC AS

	PROCEDURE agregarMateria(m_id materias.id_mate%TYPE,    
							 m_nom materias.nombre_mat%TYPE ) IS 
	BEGIN 
		INSERT INTO materias VALUES (m_id,m_nom);
		DBMS_OUTPUT.PUT_LINE('Materia agregada');
	END agregarMateria;
	
	PROCEDURE eliminaMateria (m_id materias.id_mate%TYPE) IS
	BEGIN
		DELETE FROM materias WHERE id_mate = m_id;
		DBMS_OUTPUT.PUT_LINE('Materia eliminado');
	END eliminaMateria;
	
	PROCEDURE consultaMateria (m_id materias.id_mate%TYPE) IS 
		m_nom materias.nombre_mat%TYPE;
	BEGIN 
		SELECT nombre_mat INTO m_nom
		FROM materias
		WHERE id_mate = m_id;
		DBMS_OUTPUT.PUT_LINE(m_id||' '||m_nom);
	END consultaMateria;

	PROCEDURE actualizarMateria(m_id materias.id_mate%TYPE, m_nom materias.nombre_mat%TYPE) IS 
	BEGIN
		UPDATE Materias SET nombre_mat = m_nom WHERE id_mate = m_id;
		DBMS_OUTPUT.PUT_LINE('Materia modificado');
	END actualizarMateria;
END materiasABC;
/

/*Maestros*/
CREATE OR REPLACE PACKAGE maestrosABC AS
	PROCEDURE agregarMaestro(ma_id Maestros_cet.id_maes%TYPE,          
							ma_nom Maestros_cet.nombre_maes%TYPE,      
							ma_app Maestros_cet.apellidoPat_maes%TYPE, 
							ma_apm Maestros_cet.apellidoMat_maes%TYPE, 
							ma_fec Maestros_cet.fechaNac_maes%TYPE);

	PROCEDURE eliminaMaestro(ma_id Maestros_cet.id_maes%TYPE);

	PROCEDURE consultaMaestro(ma_id Maestros_cet.id_maes%TYPE);

	PROCEDURE actualizarMaestro(ma_id Maestros_cet.id_maes%TYPE,ma_fec Maestros_cet.fechaNac_maes%TYPE);
END maestrosABC;
/

CREATE OR REPLACE PACKAGE BODY maestrosABC AS
	PROCEDURE agregarMaestro(ma_id Maestros_cet.id_maes%TYPE,          
							ma_nom Maestros_cet.nombre_maes%TYPE,      
							ma_app Maestros_cet.apellidoPat_maes%TYPE, 
							ma_apm Maestros_cet.apellidoMat_maes%TYPE, 
							ma_fec Maestros_cet.fechaNac_maes%TYPE) IS 
	BEGIN 
		INSERT INTO Maestros_cet VALUES (ma_id,ma_nom,ma_app,ma_apm,ma_fec);
		DBMS_OUTPUT.PUT_LINE('Maestro agregado');
	END agregarMaestro;

	PROCEDURE eliminaMaestro (ma_id Maestros_cet.id_maes%TYPE) IS
	BEGIN
		DELETE FROM Maestros_cet WHERE id_maes = ma_id;
		DBMS_OUTPUT.PUT_LINE('Maestro eliminado');
	END eliminaMaestro;
	
	PROCEDURE consultaMaestro (ma_id Maestros_cet.id_maes%TYPE) IS 
			ma_nom Maestros_cet.nombre_maes%TYPE;      
			ma_app Maestros_cet.apellidoPat_maes%TYPE;
			ma_apm Maestros_cet.apellidoMat_maes%TYPE; 
			ma_fec Maestros_cet.fechaNac_maes%TYPE;
		BEGIN 
			SELECT nombre_maes,apellidoPat_maes,apellidoMat_maes,fechaNac_maes INTO ma_nom,ma_app,ma_apm,ma_fec
			FROM Maestros_cet
			WHERE id_maes = ma_id;
			DBMS_OUTPUT.PUT_LINE(ma_nom||' '||ma_app||' '||ma_apm||' '||ma_fec);
		END consultaMaestro;

		PROCEDURE actualizarMaestro(ma_id Maestros_cet.id_maes%TYPE,ma_fec Maestros_cet.fechaNac_maes%TYPE) IS 
			BEGIN
				UPDATE Maestros_cet SET fechaNac_maes = ma_fec WHERE  fechaNac_maes = ma_id;
				DBMS_OUTPUT.PUT_LINE('Maestro modificado');
			END actualizarMaestro;

END maestrosABC;
/
/*4. Cree un store procedure que permita relacionar a los Maestros con las materias que imparte y 
los alumnos inscritos en esas materias por ciclo escolar.*/
CREATE OR REPLACE PROCEDURE inscripAlumno (
	rfcAlumno OUT VARCHAR2, c_nom OUT VARCHAR2
) IS 
	c_id VARCHAR2(30);
	a_id VARCHAR2(200);
	cont NUMBER;
	sql_stmt VARCHAR2(200);
BEGIN

	SELECT id_curso INTO c_id 
	FROM Cursos
	WHERE nombre_curso = c_nom;

	SELECT COUNT(id_dca) INTO cont
	FROM Detalle_CursosAlumnos;

	sql_stmt := 'INSERT INTO Detalle_CursosAlumnos VALUES ('||cont||',:1,:2)';
	EXECUTE IMMEDIATE sql_stmt USING a_id, c_id;
	IF SQL%ROWCOUNT > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Alumno inscrito');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('No se inserto correctamente');
	END IF;
	
	EXCEPTION WHEN no_data_found THEN
			DBMS_OUTPUT.PUT_LINE('Error con datos, inserte nuevamente');
			
END inscripAlumno;
/
/**/
INSERT INTO Alumnos VALUES('LRC042295','César','Limón','Ruíz','220495');
INSERT INTO Maestros_cet VALUES('LIPJ030171','Julio','Limón','Ruíz','030171');
INSERT INTO Materias VALUES (1,'Base de datos');
INSERT INTO detalle_MaestroMateria VALUES ('LIPJ030171',1);
INSERT INTO Cursos VALUES (1,'Base de datos avanzado','250617',null,null,'LIPJ030171');
/*5. Ejecute un bloque PLSQL para probar los puntos anteriores.*/
DECLARE 
	a_id alumnos.id_alumn%TYPE:='LIRA190500';
	a_nom alumnos.nombre_alumn%TYPE:='Adrian';
	a_app alumnos.apellidoPat_alumn%TYPE:='Limon';
	a_apm alumnos.apellidoMat_alumn%TYPE:='Ruiz';
	a_fec alumnos.fechaNac_alumn%TYPE:='190500';
BEGIN
	--alumnosABC.agregarAlumno(a_id,a_nom,a_app,a_apm,a_fec);
	--alumnosABC.eliminaAlumno(a_id);
	--alumnosABC.consultaAlumno(a_id);
	--alumnosABC.actualizarAlumno(a_id,'190500');
END;
	/
/**/
DECLARE 
	m_id materias.id_mate%TYPE:=2;
	m_nom materias.nombre_mat%TYPE:='POO';
BEGIN
	--materiasABC.agregarMateria(m_id,m_nom);
	--materiasABC.eliminaMateria(m_id);
	--materiasABC.consultaMateria(m_id);
	--materiasABC.actualizarMateria(m_id,'POO2');
END;
	/
/**/
DECLARE 
	ma_id Maestros_cet.id_maes%TYPE:='RUSB210673';
	ma_nom Maestros_cet.nombre_maes%TYPE:='Belinda';
	ma_app Maestros_cet.apellidoPat_maes%TYPE:='Ruiz';
	ma_apm Maestros_cet.apellidoMat_maes%TYPE:='Salas';
	ma_fec Maestros_cet.fechaNac_maes%TYPE:='210673';
BEGIN
	maestrosABC.agregarMaestro(ma_id,ma_nom,ma_app,ma_apm,ma_fec);
	--maestrosABC.eliminaMaestro(ma_id);
	--maestrosABC.consultaMaestro(ma_id);
	--maestrosABC.actualizarMaestro(ma_id,'210673');
END;
	/
/**/
DECLARE 
	rfcAlumno Alumnos.id_alumn%TYPE:='LRC042295';
	c_nom materias.nombre_mat%TYPE:='Base de datos avanzado';
BEGIN
	EXECUTE inscripAlumno(rfcAlumno,c_nom);
END;
	/