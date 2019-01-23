COLUMN run_date FORMAT A20

SELECT r.runid,
       TO_CHAR(r.run_date, 'DD-MON-YYYY HH24:MI:SS') AS run_date,
       r.run_owner
FROM   sys.plsql_trace_runs r
ORDER BY r.runid;
/
