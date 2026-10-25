# LAB-04 

## Objetivo

Aplicar un proceso básico de hardening sobre una instancia PostgreSQL 16 para identificar configuraciones inseguras, analizar la superficie de ataque, revisar controles de acceso y documentar una línea base de seguridad que permita reducir riesgos de exposición.


## Entorno

- Motor de base de datos: PostgreSQL 16
- Herramienta de administración: pgAdmin 4
- Entorno académico controlado
- Acceso mediante usuario restringido
- Base de datos de laboratorio asignada por el entorno académico


## Superficie de Ataque Inicial

Durante la inspección inicial se identificó lo siguiente:

| Elemento | Estado Encontrado |
|-----------|-----------|
| Puerto PostgreSQL | 5432 |
| Listen Addresses | * |
| SSL/TLS | off |
| Password Encryption | scram-sha-256 |
| Log Connections | on |
| Log Disconnections | on |


## Hallazgos

### Configuraciones Adecuadas

- Uso de `scram-sha-256` para almacenamiento de contraseñas.
- Registro de conexiones habilitado.
- Registro de desconexiones habilitado.

### Riesgos Identificados

- PostgreSQL escucha en todas las interfaces de red mediante `listen_addresses='*'`.
- TLS se encuentra deshabilitado (`ssl = off`).
- Existen conexiones remotas activas.
- El puerto utilizado corresponde al valor estándar `5432`.
- No fue posible revisar directamente algunos parámetros administrativos debido a restricciones de permisos.

### Restricciones del Entorno

No fue posible consultar los siguientes parámetros:

```sql
SHOW config_file;
SHOW hba_file;
SHOW ident_file;
SHOW log_directory;
```

Debido al error:

```text
ERROR: must be superuser or have privileges of pg_read_all_settings
```

## Cambios Realizados

- Inspección de la superficie de ataque.
- Documentación de configuraciones relevantes.
- Revisión del método de autenticación utilizado.
- Revisión de roles y privilegios.
- Verificación del uso de TLS.
- Construcción de una línea base de seguridad.
- Elaboración de documentación de cambios y hallazgos.


## Justificación de los Cambios

Las actividades realizadas permiten comprender el estado de seguridad de la instancia PostgreSQL y detectar posibles áreas de mejora relacionadas con:

- Exposición de red.
- Configuración de autenticación.
- Uso de privilegios.
- Cifrado de comunicaciones.
- Monitoreo de conexiones.


## Verificación

Se verificaron los siguientes controles:

- Puerto PostgreSQL identificado.
- Interfaces de escucha revisadas.
- Configuración TLS revisada.
- Método de autenticación identificado.
- Conexiones activas revisadas.
- Roles y privilegios analizados.
- Registro de conexiones validado.
- Línea base documentada.

Las evidencias generadas se encuentran almacenadas en la carpeta `evidencias/`.


## Checklist de Hardening

| # | Control | Estado |
|---|----------|----------|
| 1 | Puerto documentado | ✅ |
| 2 | Interfaces de escucha identificadas | ✅ |
| 3 | Superficie de ataque analizada | ✅ |
| 4 | SSL/TLS revisado | ✅ |
| 5 | Método de autenticación identificado | ✅ |
| 6 | Roles revisados | ✅ |
| 7 | Usuarios con LOGIN identificados | ✅ |
| 8 | Privilegios administrativos revisados | ✅ |
| 9 | Conexiones activas verificadas | ✅ |
| 10 | Registro de conexiones validado | ✅ |
| 11 | Registro de desconexiones validado | ✅ |
| 12 | Archivos de configuración identificados conceptualmente | ✅ |
| 13 | Reglas de autenticación analizadas | ✅ |
| 14 | Línea base documentada | ✅ |
| 15 | Hallazgos de seguridad registrados | ✅ |


## Conclusiones

El laboratorio permitió identificar los principales componentes que forman parte de la superficie de ataque de un servidor PostgreSQL. Se observó que configuraciones como `listen_addresses='*'` y la ausencia de TLS incrementan la exposición del servicio y representan oportunidades de mejora desde la perspectiva del hardening.

Finalmente, la construcción de una línea base de seguridad y una checklist de hardening facilita la verificación periódica de controles y contribuye a mantener una configuración más segura y alineada con buenas prácticas de administración de bases de datos.
