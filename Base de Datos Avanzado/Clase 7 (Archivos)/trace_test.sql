CREATE OR REPLACE PROCEDURE trace_test (p_loops  IN  NUMBER) AS
  l_dummy  NUMBER := 0;
BEGIN
  FOR i IN 1 .. p_loops LOOP
    SELECT l_dummy + 1
    INTO   l_dummy
    FROM   dual;   

    l_dummy := TO_NUMBER(TO_CHAR(l_dummy -1));
  END LOOP;
END;
/
SHOW ERRORS