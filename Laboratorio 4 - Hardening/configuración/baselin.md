# Baseline 

## Información recopilada

### Puerto
5432

### Listen Addresses
(*)

### SSL
off

### Password Encryption
scram-sha-256

## Hallazgos Iniciales
### Configuraciones adecuadas

Uso de SCRAM-SHA-256 para almacenamiento de contraseñas.

### Riesgos identificados
PostgreSQL escucha en todas las interfaces de red.
SSL/TLS está deshabilitado.
Existen conexiones remotas activas.
El puerto utilizado es el estándar de PostgreSQL.

### Nivel de Riesgo

Medio-Alto
Debido a que las comunicaciones no están cifradas y el servidor acepta conexiones desde cualquier interfaz disponible.
