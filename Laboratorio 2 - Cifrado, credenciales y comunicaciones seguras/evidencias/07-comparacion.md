# Actividad 7 

## Objetivo

Identificar los mecanismos de protección más adecuados para distintos tipos de información y comprender qué aspecto de la seguridad protege cada uno.

## Comando o procedimiento

Se analizaron diferentes escenarios de seguridad para determinar el mecanismo de protección más apropiado en cada caso, considerando la protección de datos almacenados y la protección de datos durante la transmisión.

## Resultado obtenido

| Situación | Mecanismo apropiado | ¿Qué protege? |
|-----------|---------------------|---------------|
| Contraseña de usuario | Hash (`crypt()` + `gen_salt()`) | Evita que la contraseña original pueda ser visualizada o recuperada. |
| RFC almacenado en una tabla | Cifrado simétrico (`pgp_sym_encrypt()`) | Protege la información sensible almacenada en la base de datos. |
| Consulta enviada desde un cliente al servidor | TLS/SSL | Protege los datos durante la transmisión por la red. |
| Respaldo de una base de datos | Cifrado del respaldo | Protege la información contenida en los archivos de respaldo. |
| Clave criptográfica | Gestor seguro de secretos o claves | Protege las claves utilizadas para cifrar y descifrar información. |

## Análisis

No existe un único mecanismo que proteja toda la información de un sistema. Las contraseñas requieren protección mediante hash, los datos sensibles almacenados necesitan cifrado, las comunicaciones deben protegerse mediante TLS y las claves criptográficas deben administrarse de forma segura. Cada mecanismo protege una parte específica de la infraestructura y todos son necesarios para mantener una estrategia de seguridad completa.

## Conclusión

La protección en reposo y la protección en tránsito son complementarias. Mientras que el hash y el cifrado protegen la información almacenada, TLS protege los datos durante su transmisión. Además, una correcta gestión de claves es fundamental para garantizar la efectividad de los mecanismos criptogr
