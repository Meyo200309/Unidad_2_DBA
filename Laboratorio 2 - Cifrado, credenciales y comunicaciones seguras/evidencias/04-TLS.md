# Actividad 5 

## Objetivo

Verificar si PostgreSQL tiene habilitado TLS y comprobar si la conexión actual entre el cliente y el servidor está protegida mediante este protocolo.

## Comando o procedimiento

### Verificar si SSL/TLS está habilitado

```sql
SHOW ssl;
```

### Verificar la versión mínima de protocolo permitida

```sql
SHOW ssl_min_protocol_version;
```

### Consultar el puerto utilizado por PostgreSQL

```sql
SHOW port;
```

### Consultar las direcciones de escucha

```sql
SHOW listen_addresses;
```

### Verificar información de la conexión actual

```sql
SELECT
    inet_client_addr(),
    inet_client_port();
```

### Verificar si la sesión utiliza TLS

```sql
SELECT
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
```

## Resultado obtenido

### ¿La conexión actual utiliza TLS?

No. La consulta mostró que `ssl = false`.

### ¿Qué versión de TLS se está utilizando?

No aplica, ya que la conexión actual no utiliza TLS. Por ello el campo `version` aparece como `NULL`.

### ¿Qué algoritmo de cifrado aparece?

No aparece ningún algoritmo de cifrado porque la conexión no está protegida mediante TLS. El campo `cipher` aparece como `NULL`.

### ¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?

Una conexión protegida con TLS cifra la información que viaja entre el cliente y el servidor, evitando que terceros puedan leerla o modificarla durante la transmisión. En cambio, una conexión sin TLS transmite los datos sin protección criptográfica, aumentando el riesgo de interceptación.

## Análisis

Las consultas realizadas permitieron comprobar el estado de la seguridad de la conexión utilizada por PostgreSQL. Aunque el servidor puede tener soporte para SSL/TLS, la sesión actual no estaba utilizando dicho mecanismo, como se observa en los valores `NULL` obtenidos para la versión y el algoritmo de cifrado. Esto significa que la información transmitida entre el cliente y el servidor no cuenta con protección durante su recorrido por la red.

## Conclusión

TLS es un mecanismo fundamental para proteger la confidencialidad e integridad de los datos en tránsito. En esta práctica se observó que la conexión actual no utilizaba TLS, por lo que sería recomendable habilitar y configurar correctamente este protocolo para asegurar las comunicaciones entre PostgreSQL y los clientes.
