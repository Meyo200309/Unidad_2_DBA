¿Qué sucede con la información mientras viaja entre el cliente y PostgreSQL?
 La información se transmite a través de la red y, si la conexión no está protegida, podría ser observada o interceptada por personas no autorizadas.

1. ¿La conexión actual utiliza TLS?
 No, la conexión actual no utiliza TLS.

2. ¿Qué versión de TLS se está utilizando?
 No aplica, ya que la conexión no está utilizando TLS.

3. ¿Qué algoritmo de cifrado aparece?
 Ninguno, porque la conexión no está cifrada.

4. ¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?
 Una conexión con TLS cifra la información que se transmite entre el cliente y el servidor, mientras que una conexión sin TLS transmite los datos sin cifrar, por lo que podrían ser interceptados por terceros.
