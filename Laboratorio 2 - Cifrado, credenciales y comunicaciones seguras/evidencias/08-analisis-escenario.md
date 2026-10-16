# Actividad 8 

## Objetivo

Analizar un escenario de seguridad identificando vulnerabilidades, riesgos y mecanismos de protección aplicables a distintos tipos de información.

## Comando o procedimiento

Se revisó el escenario propuesto, identificando los riesgos existentes, los controles de seguridad faltantes y las medidas que podrían aplicarse para proteger la información almacenada por la organización.

## Resultado obtenido

### Pregunta 1
### ¿Cuáles son los principales riesgos?

- Exposición de contraseñas debido a su almacenamiento en texto claro.
- Exposición de información personal al almacenar el RFC sin protección.
- Posibilidad de interceptación o suplantación de comunicaciones por una configuración incorrecta de TLS.
- Compromiso de toda la información cifrada debido a la exposición de claves criptográficas en archivos SQL.
- Fuga de información sensible mediante respaldos almacenados sin protección.

### Pregunta 2
### ¿Qué mecanismo utilizarías para cada elemento?

| Elemento | Mecanismo recomendado |
|-----------|----------------------|
| Nombre | Control de acceso mediante usuarios y roles |
| Correo electrónico | Cifrado de datos sensibles |
| Contraseña | Hash mediante `crypt()` y `gen_salt()` |
| RFC | Cifrado mediante `pgp_sym_encrypt()` |
| Información financiera | Cifrado y control de acceso |
| Claves criptográficas | Gestor seguro de secretos o claves |

### Pregunta 3
### ¿Cuál de los problemas consideras más crítico y por qué?

Considero que el problema más crítico es la exposición de las claves criptográficas en archivos SQL, ya que una persona que obtenga dichas claves podría descifrar toda la información protegida por ellas, anulando la efectividad de los mecanismos de cifrado implementados.

### Pregunta 4
### ¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos? Justifica tu respuesta.

No. Aunque los usuarios y permisos ayudan a controlar el acceso a la información, no eliminan riesgos relacionados con el almacenamiento inseguro de contraseñas, la exposición de claves criptográficas, las comunicaciones sin protección adecuada o los respaldos sin cifrar. La seguridad requiere múltiples controles complementarios y no depende únicamente de la configuración de permisos.

## Análisis

El escenario muestra que la correcta configuración de usuarios y roles es importante, pero insuficiente por sí sola. Existen riesgos asociados al almacenamiento de información sensible, la gestión de claves criptográficas y la protección de los datos durante su transmisión y respaldo. La ausencia de controles adecuados en cualquiera de estas áreas puede comprometer la seguridad de toda la organización.

## Conclusión

La protección de la información requiere una estrategia integral que combine control de acceso, cifrado de datos, protección de credenciales, gestión segura de claves y comunicaciones seguras mediante TLS. La existencia de usuarios y permisos correctamente configurados no sustituye la necesidad de implementar estos mecanismos de protección.
