# Actividad 8 

## Pregunta 1
### ¿Cuáles son los principales riesgos?

- Las contraseñas almacenadas en texto claro pueden ser vistas y utilizadas por cualquier persona que obtenga acceso a la base de datos.
- El RFC almacenado en texto claro expone información personal de los usuarios.
- La falta de validación adecuada del servidor en las conexiones permite ataques de suplantación o interceptación de comunicaciones.
- Las claves criptográficas almacenadas en archivos SQL pueden ser robadas y utilizadas para descifrar información sensible.
- Los respaldos sin protección pueden exponer toda la información de la base de datos si son robados o filtrados.

## Pregunta 2
### ¿Qué mecanismo utilizarías para cada elemento?

| Elemento | Mecanismo recomendado |
|-----------|----------------------|
| Nombre | Control de acceso mediante usuarios y roles |
| Correo electrónico | Cifrado de datos sensibles (`pgp_sym_encrypt()`) |
| Contraseña | Hash con `crypt()` y `gen_salt()` |
| RFC | Cifrado de datos sensibles (`pgp_sym_encrypt()`) |
| Información financiera | Cifrado de datos y control estricto de acceso |
| Claves criptográficas | Gestión segura de claves mediante un gestor de secretos o HSM |

## Pregunta 3
### ¿Cuál de los problemas consideras más crítico y por qué?

Considero que el problema más crítico es la exposición de las claves criptográficas en archivos SQL. Si un atacante obtiene estas claves, podría descifrar toda la información que depende de ellas, anulando la protección proporcionada por el cifrado y comprometiendo datos sensibles de toda la organización.

## Pregunta 4
### ¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos? Justifica tu respuesta.

No. Aunque los usuarios y permisos correctamente configurados ayudan a limitar el acceso a la información, no eliminan otros riesgos de seguridad. Si las contraseñas están en texto claro, las claves criptográficas están expuestas, los respaldos no están protegidos o las comunicaciones son inseguras, un atacante podría obtener información sensible incluso existiendo controles de acceso adecuados. Por ello, la seguridad requiere una combinación de controles de acceso, cifrado, protección de claves y comunicaciones seguras.
``
