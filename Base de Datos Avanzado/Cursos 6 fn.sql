/*PL/SQL Tracing - Ruta --C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin--*/
/*Tablas almacenadas (objetos)*/
SELECT owner, object_name, object_type
FROM dba_objects
WHERE object_name LIKE 'PLSQL%'
ORDER BY 2,1;
/*Dar privilegios a tablas*/
GRANT SELECT ON plsql_trace_events TO PUBLIC;
GRANT SELECT ON plsql_trace_runs TO PUBLIC;
GRANT EXECUTE ON dbms_trace TO oracleDev;
/*Ejercicio*/
CREATE OR REPLACE PROCEDURE trace_test (p_loops IN NUMBER) AS 
	l_dummy NUMBER := 0;
BEGIN
	FOR i IN 1 .. p_loops LOOP 
		SELECT l_dummy +1 
		INTO l_dummy
		FROm dual;
		l_dummy := TO_NUMBER(TO_CHAR(l_dummy - 1));
	END LOOP;
END;
/
SHOW ERRORS
/*Ejercicio*/
DECLARE
  --definiendo variable numerica
  l_result  BINARY_INTEGER;
BEGIN
  DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_calls);
  trace_test(p_loops => 100);
  --deteniendo rastreo
  DBMS_TRACE.clear_plsql_trace;
END;
/
/**/
SELECT r.runid,
       TO_CHAR(r.run_date, 'DD-MON-YYYY HH24:MI:SS') AS run_date,
       r.run_owner
FROM   sys.plsql_trace_runs r
ORDER BY r.runid;
/
/**/
SET LINESIZE 200
SET TRIMOUT ON

COLUMN runid FORMAT 99999
COLUMN event_seq FORMAT 99999
COLUMN event_unit_owner FORMAT A20
COLUMN event_unit FORMAT A20
COLUMN event_unit_kind FORMAT A20
COLUMN event_comment FORMAT A30

SELECT e.runid,
       e.event_seq,
       TO_CHAR(e.event_time, 'DD-MON-YYYY HH24:MI:SS') AS event_time,
       e.event_unit_owner,
       e.event_unit,
       e.event_unit_kind,
       e.proc_line,
       e.event_comment
FROM   sys.plsql_trace_events e
WHERE  e.runid = &1
ORDER BY e.runid, e.event_seq;
/**/
DECLARE
  --definiendo variable numerica
  l_result  BINARY_INTEGER;
BEGIN
--definiendo el nivel de rastreo a trace_all_sql
  DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_sql);
  --ejecutado stored procedure
  trace_test(p_loops => 100);
  --deteniendo rastreo
  DBMS_TRACE.clear_plsql_trace;
  END;
/
