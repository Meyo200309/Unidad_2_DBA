¿Qué sucede con la información mientras viaja entre el cliente y PostgreSQL?
 La información se transmite a través de la red y, si la conexión no está protegida, podría ser observada o interceptada por personas no autorizadas.

¿Qué riesgo existe si la conexión no está protegida?
 Una persona con acceso al tráfico de red podría intentar obtener información sensible que se está intercambiando entre el cliente y el servidor, como consultas, resultados o credenciales.

¿Qué mecanismo se utiliza para proteger la comunicación?
 Se utiliza TLS (Transport Layer Security) para proteger los datos durante su transmisión entre el cliente y PostgreSQL.

¿Qué protege TLS?
 TLS proporciona:

Confidencialidad: evita que terceros lean la información transmitida.
Integridad: permite detectar modificaciones no autorizadas.
Autenticación: ayuda a verificar la identidad del servidor.
