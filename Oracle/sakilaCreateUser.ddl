DROP TABLESPACE "TABLESAKILA"
    INCLUDING CONTENTS AND DATAFILES
     CASCADE CONSTRAINTS;


CREATE TABLESPACE TABLESAKILA
    DATAFILE
        'DATAFILESAKILA1' SIZE 5M AUTOEXTEND ON NEXT 5M MAXSIZE 250M;

CREATE TEMPORARY TABLESPACE TABLESAKILATEMP
    TEMPFILE
        'DATAFILESAKILATEMP' SIZE 5M;


DROP USER "SAKILANOSQL" CASCADE;

CREATE USER sakilanosql IDENTIFIED BY nosql
    DEFAULT TABLESPACE TABLESAKILA
    TEMPORARY TABLESPACE TABLESAKILATEMP
    QUOTA UNLIMITED ON TABLESAKILA
    ACCOUNT UNLOCK;

GRANT connect,
    CREATE SESSION,
    CREATE ANY TABLE,
    CREATE ANY TRIGGER,
    CREATE ANY VIEW,
    CREATE ANY SEQUENCE,
    CREATE ANY PROCEDURE
TO sakilanosql;

COMMIT;