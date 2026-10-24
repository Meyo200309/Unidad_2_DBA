-- Actividad 1 - Inspección inicial

SELECT version();

SHOW port;
SHOW listen_addresses;
SHOW ssl;
SHOW password_encryption;

SELECT
    pid,
    usename,
    datname,
    client_addr,
    application_name
FROM pg_stat_activity;
