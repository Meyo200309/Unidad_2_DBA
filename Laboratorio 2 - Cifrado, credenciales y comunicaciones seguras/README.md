# Informe Final - Cifrado, credenciales y comunicaciones seguras

## 1. Introducción

La seguridad de la información es un aspecto fundamental en cualquier sistema que almacene datos de usuarios. Durante este laboratorio se analizaron diferentes mecanismos para proteger credenciales, información sensible, comunicaciones y claves criptográficas. También se identificaron riesgos comunes derivados de malas prácticas de seguridad y se aplicaron controles para reducir su impacto.

## 2. Protección de credenciales

Las credenciales son uno de los elementos más sensibles dentro de una aplicación, ya que permiten autenticar usuarios y controlar el acceso a los recursos del sistema.

- **Texto claro:** la contraseña se almacena exactamente como fue creada por el usuario. Cualquier persona con acceso a la base de datos puede visualizarla.
- **Hash:** transforma la contraseña en una representación no reversible utilizando funciones como `crypt()` y `gen_salt()`. La contraseña original no puede recuperarse.
- **Cifrado:** protege la información mediante una clave y permite recuperar posteriormente el dato original. Este mecanismo es útil para datos que necesitan ser consultados posteriormente, pero no es la mejor opción para almacenar contraseñas.

Durante la práctica se comprobó que el hash es el mecanismo más adecuado para proteger credenciales de usuario.

## 3. Protección de datos sensibles

Se protegió el RFC de un cliente utilizando cifrado simétrico mediante `pgp_sym_encrypt()`.

El RFC fue seleccionado porque constituye información sensible que podría utilizarse para identificar a una persona. Al almacenarlo cifrado, se evita que usuarios no autorizados puedan visualizar directamente el dato dentro de la base de datos.

Posteriormente se utilizó `pgp_sym_decrypt()` para recuperar el valor original utilizando la clave correspondiente.

## 4. TLS

TLS (Transport Layer Security) es un protocolo diseñado para proteger la información durante su transmisión entre sistemas.

Su función principal es:

- Proteger la confidencialidad de los datos.
- Evitar la lectura de información por terceros.
- Reducir el riesgo de manipulación de datos durante la comunicación.
- Verificar la identidad del servidor.

Durante la práctica se verificó la configuración de PostgreSQL utilizando consultas como:

```sql
SHOW ssl;
SHOW ssl_min_protocol_version;
SELECT ssl, version, cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
```

Los resultados obtenidos mostraron que la sesión utilizada no estaba empleando TLS, por lo que la comunicación no contaba con protección criptográfica en tránsito.

## 5. Gestión de claves

Las claves criptográficas son el elemento que permite cifrar y descifrar información protegida.

Durante la práctica se observó que incluir claves directamente dentro de consultas SQL representa una mala práctica porque pueden quedar expuestas mediante:

- Scripts.
- Repositorios Git.
- Archivos de configuración.
- Capturas de pantalla.
- Registros de ejecución.
- Respaldos.

Si una clave queda expuesta, cualquier persona podría utilizarla para descifrar la información protegida.

Por esta razón, las claves deben almacenarse en sistemas especializados de gestión de secretos y nunca directamente dentro del código fuente o repositorios.

## 6. Resultados

Los principales resultados obtenidos fueron:

- Identificación de los riesgos asociados al almacenamiento de contraseñas en texto claro.
- Implementación de protección de credenciales mediante `crypt()` y `gen_salt()`.
- Uso de cifrado simétrico para proteger información sensible.
- Comprensión de las diferencias entre hash y cifrado.
- Verificación del estado de TLS en PostgreSQL.
- Identificación de riesgos relacionados con la exposición de claves criptográficas.
- Comparación entre protección en reposo y protección en tránsito.
- Análisis de un escenario de seguridad empresarial y propuesta de controles adecuados.

## 7. Problemas encontrados

Durante el desarrollo del laboratorio se presentaron algunas dificultades relacionadas con la interpretación de los resultados de TLS.

Al consultar:

```sql
SELECT ssl, version, cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
```

los campos `version` y `cipher` aparecieron como `NULL`, indicando que la conexión actual no se encontraba utilizando TLS.

Fuera de esta situación, las consultas y ejercicios propuestos pudieron realizarse correctamente.

## 8. Conclusiones

Este laboratorio permitió comprender la importancia de proteger adecuadamente las credenciales, los datos sensibles, las comunicaciones y las claves criptográficas.

Se aprendió que:

- Las contraseñas nunca deben almacenarse en texto claro.
- El hash y el cifrado tienen objetivos diferentes.
- Los datos sensibles deben protegerse mediante mecanismos criptográficos adecuados.
- TLS es necesario para proteger la información durante su transmisión.
- La seguridad del cifrado depende en gran medida de la protección de las claves.
- Los permisos y roles son importantes, pero no sustituyen otras medidas de seguridad.

En un entorno productivo aplicaría almacenamiento seguro de contraseñas mediante hash, cifrado de datos sensibles, uso obligatorio de TLS, gestión profesional de claves criptográficas y protección de respaldos para reducir los riesgos de acceso no autorizado y filtración de información.

# Preguntas de reflexión

## 1. ¿Por qué una contraseña no debe almacenarse como texto claro?

Porque cualquier persona que obtenga acceso a la base de datos podrá visualizarla directamente y utilizarla para acceder a las cuentas de los usuarios. Además, una filtración de la base de datos expondría todas las credenciales almacenadas.

## 2. ¿Por qué un hash no es equivalente a un cifrado?

Porque un hash es un proceso unidireccional que no permite recuperar el dato original, mientras que el cifrado transforma la información utilizando una clave y puede revertirse para obtener nuevamente el contenido original.

## 3. ¿Por qué el cifrado de una columna no sustituye al control de acceso?

Porque el cifrado protege los datos almacenados, pero no controla quién puede acceder a ellos. El control de acceso sigue siendo necesario para limitar qué usuarios pueden consultar o modificar la información.

## 4. ¿Por qué TLS no sustituye a los mecanismos de autorización de PostgreSQL?

Porque TLS protege la información durante la comunicación entre el cliente y el servidor, pero no determina qué acciones puede realizar un usuario. La autorización sigue dependiendo de usuarios, roles y permisos configurados en PostgreSQL.

## 5. ¿Qué ocurriría si una organización pierde una clave utilizada para cifrar información?

La información cifrada podría volverse irrecuperable, ya que sin la clave correcta no sería posible descifrar los datos protegidos.

## 6. ¿Qué ocurriría si una clave criptográfica se publica accidentalmente en GitLab?

Una persona con acceso al repositorio podría obtener la clave y utilizarla para descifrar la información protegida. En ese caso, la clave debería revocarse inmediatamente y reemplazarse por una nueva.

## 7. ¿Por qué un repositorio privado no debe considerarse un almacén de secretos?

Porque los repositorios están diseñados para almacenar código y documentación, no secretos. Una configuración incorrecta, una filtración o el acceso de personas no autorizadas podría exponer las credenciales o claves almacenadas.

## 8. ¿Qué diferencia existe entre proteger información almacenada y proteger información durante su transmisión?

La protección de información almacenada busca asegurar los datos que se encuentran guardados en discos o bases de datos mediante hash o cifrado. La protección durante la transmisión busca asegurar los datos que viajan por la red mediante protocolos como TLS.

## 9. ¿Por qué la gestión de claves es tan importante como el algoritmo criptográfico?

Porque un algoritmo seguro pierde efectividad si las claves son robadas o expuestas. La seguridad del cifrado depende tanto de la fortaleza del algoritmo como de la protección adecuada de las claves.

## 10. ¿Qué mecanismo adicional implementarías en una organización para proteger los respaldos de las bases de datos?

Implementaría el cifrado de los respaldos junto con controles de acceso, almacenamiento seguro y copias de respaldo protegidas en ubicaciones separadas para evitar accesos no autorizados y pérdidas de informaci
