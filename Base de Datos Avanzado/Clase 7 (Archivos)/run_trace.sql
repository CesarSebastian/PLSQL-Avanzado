DECLARE
  --definiendo variable numerica
  l_result  BINARY_INTEGER;
BEGIN
  --definiendo el nivel de rastreo a trace_all_calls
  DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_calls);
  --ejecutado stored procedure
  trace_test(p_loops => 100);
  --deteniendo rastreo
  DBMS_TRACE.clear_plsql_trace;

  --definiendo el nivel de rastreo a trace_all_sql
  DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_sql);
  --ejecutado stored procedure
  trace_test(p_loops => 100);
  --deteniendo rastreo
  DBMS_TRACE.clear_plsql_trace;

  --definiendo el nivel de rastreo a trace_all_lines
  DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_lines);
  --ejecutado stored procedure
  trace_test(p_loops => 100);
  --deteniendo rastreo
  DBMS_TRACE.clear_plsql_trace;
END;
/
