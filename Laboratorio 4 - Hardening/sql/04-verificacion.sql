-- Verificación final

SHOW port;
SHOW listen_addresses;
SHOW ssl;
SHOW password_encryption;

SHOW log_connections;
SHOW log_disconnections;

SELECT
    rolname,
    rolsuper,
    rolcreaterole,
    rolcreatedb,
    rolcanlogin
FROM pg_roles
ORDER BY rolname;

SELECT
    pid,
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
