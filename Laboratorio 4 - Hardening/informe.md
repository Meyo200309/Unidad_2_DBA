# Informe - LAB-04 Hardening 

## 1. ¿Cuál era la principal superficie de ataque?

La principal superficie de ataque identificada fue la exposición de la instancia PostgreSQL a través de la red. Se observó que el servidor estaba configurado con listen_addresses = '*', lo que significa que acepta conexiones desde todas las interfaces de red disponibles. Esta configuración incrementa la exposición del servicio y amplía las posibilidades de acceso no autorizado.


## 2. ¿Qué configuración representaba el mayor riesgo?

La configuración que representaba el mayor riesgo fue la combinación de dos factores:

- listen_addresses = '*'
- ssl = off

La primera permite que PostgreSQL escuche conexiones desde cualquier interfaz de red, mientras que la segunda implica que las comunicaciones no están protegidas mediante TLS. La combinación de ambas configuraciones aumenta la exposición y el riesgo de interceptación del tráfico.


## 3. ¿Qué cambio produjo la mayor reducción de exposición?

La mayor reducción de exposición se obtiene al restringir las interfaces de escucha únicamente a aquellas que son realmente necesarias para la operación del sistema.

Al limitar las direcciones desde las que PostgreSQL acepta conexiones, se reduce significativamente la superficie de ataque y se disminuye la probabilidad de accesos no autorizados.


## 4. ¿Qué diferencia existe entre firewall y pg_hba.conf?

El firewall es un mecanismo de seguridad que controla conexiones de red que pueden llegar al servidor. Filtra tráfico utilizando criterios como dirección IP, puerto o protocolo.

Por su parte, pg_hba.con es un mecanismo interno de PostgreSQL que determina qué usuarios pueden autenticarse.

El firewall controla el acceso a nivel de red, mientras que pg_hba.conf controla el acceso a nivel de base de datos.


## 5. ¿Qué diferencia existe entre autenticación y autorización?

La autenticación consiste en verificar la identidad de un usuario.

Ejemplo:

- Usuario
- Contraseña

La autorización determina qué acciones puede realizar ese usuario una vez autenticado.

Ejemplo:

- Consultar tablas.
- Insertar registros.
- Modificar datos.
- Eliminar información.

La autenticación responde a la pregunta "¿Quién eres?", mientras que la autorización responde a "¿Qué puedes hacer?".


## 6. ¿Por qué una cuenta de aplicación no debe ser SUPERUSER?

Una cuenta SUPERUSER posee control total sobre la instancia PostgreSQL.

Si una aplicación utiliza una cuenta SUPERUSER y la aplicación es comprometida, el atacante obtendría privilegios administrativos completos sobre la base de datos.
Por esta razón, las aplicaciones deben utilizar cuentas con los permisos mínimos necesarios para desempeñar sus funciones.


## 7. ¿Por qué cambiar el puerto de PostgreSQL no constituye hardening suficiente?

Cambiar el puerto puede reducir algunos intentos automatizados de exploración, pero no elimina vulnerabilidades ni sustituye controles de seguridad reales.

La seguridad de PostgreSQL debe basarse en controles como:

- Autenticación segura.
- Autorización adecuada.
- Firewall.
- TLS.
- Gestión de privilegios.

Cambiar el puerto únicamente proporciona una pequeña capa de ocultación y no representa una protección efectiva por sí misma.


## 8. ¿Por qué listen_addresses='*' puede ser innecesario?

Muchas aplicaciones solamente necesitan acceso desde una red específica o incluso desde el mismo servidor donde se encuentra PostgreSQL.

Por esta razón, una práctica recomendada de hardening consiste en habilitar únicamente las interfaces estrictamente necesarias.


## 9. ¿Qué papel tiene el sistema operativo en la seguridad de PostgreSQL?

El sistema operativo protege recursos fundamentales para el funcionamiento de PostgreSQL, entre ellos:

- Archivos de configuración.
- Directorio de datos.
- Certificados TLS.
- Registros de auditoría.
- Archivos de autenticación.


## 10. ¿Qué controles deberían revisarse periódicamente?

- Usuarios y roles.
- Privilegios asignados.
- Configuración de pg_hba.conf.
- Interfaces de escucha.
- Configuración TLS.
- Estado del firewall.
- Extensiones instaladas.
- Conexiones activas.
- Registro de eventos.
- Políticas de actualización.
- Permisos de archivos del sistema operativo.
- Configuración de autenticación.




