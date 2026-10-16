--02 Enmascaramiento
create role soporte NOLOGIN;

--crea una tabla vista pero oculta los datos sensibles 
CREATE VIEW v_clientes_soporte AS
SELECT
    id,
    nombre,

    CONCAT(
        LEFT(correo, 2),
        '*****',
        SUBSTRING(correo FROM POSITION('@' IN correo))
    ) AS correo,

    CONCAT(
        '******',
        RIGHT(telefono, 4)
    ) AS telefono,

    CONCAT(
        '*********',
        RIGHT(rfc, 4)
    ) AS rfc

FROM clientes;
select * from v_clientes_soporte;

GRANT USAGE
ON SCHEMA public
TO soporte;

GRANT SELECT
ON v_clientes_soporte
TO soporte;

REVOKE ALL
ON clientes
FROM soporte;

SELECT * FROM v_clientes_soporte;
SELECT * FROM clientes;

GRANT soporte TO u_19405324_miguel_grosso;
SET ROLE soporte;
