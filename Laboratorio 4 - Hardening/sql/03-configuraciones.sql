-- Actividad 2 y Actividad 4

SHOW config_file;

SHOW hba_file;

SHOW ident_file;

SHOW data_directory;

SHOW log_directory;

SHOW log_connections;

SHOW log_disconnections;

SELECT
    type,
    database,
    user_name,
    address,
    auth_method
FROM pg_hba_file_rules;
