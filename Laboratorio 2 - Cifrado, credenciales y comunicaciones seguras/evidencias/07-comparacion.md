## Actividad 7 

| Situación | Mecanismo apropiado | ¿Qué protege? |
|-----------|---------------------|---------------|
| Contraseña de usuario | Hash (`crypt()` + `gen_salt()`) | Evita que la contraseña original pueda ser conocida si la base de datos es comprometida. |
| RFC almacenado en una tabla | Cifrado simétrico (`pgp_sym_encrypt()`) | Protege el contenido sensible almacenado en la base de datos. |
| Consulta enviada desde un cliente al servidor | TLS/SSL | Protege la información durante su transmisión por la red. |
| Respaldo de una base de datos | Cifrado del archivo de respaldo | Protege la información almacenada en el respaldo contra accesos no autorizados. |
| Clave criptográfica | Gestión segura de claves (Vault, HSM o gestor de secretos) | Protege las claves utilizadas para cifrar y descifrar información. |

