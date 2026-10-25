# Cambios de Hardening

## Estado Inicial Identificado

Durante la inspección inicial se detectó la siguiente configuración:

| Control | Estado Inicial |
|----------|----------|
| Puerto PostgreSQL | 5432 |
| listen_addresses | * |
| SSL/TLS | off |
| password_encryption | scram-sha-256 |

---

## Riesgos Identificados

### listen_addresses = '*'

PostgreSQL se encuentra escuchando en todas las interfaces de red disponibles.

**Riesgo**

- Incrementa la superficie de ataque.
- Permite intentos de conexión desde más ubicaciones de las estrictamente necesarias.
- Aumenta la exposición del servicio.

---

### SSL deshabilitado

El parámetro SSL reporta:

```text
off
```

**Riesgo**

- Las comunicaciones no están protegidas mediante TLS.
- Existe riesgo de interceptación de tráfico si la comunicación atraviesa redes inseguras.

---

### Puerto estándar 5432

El servidor utiliza el puerto por defecto de PostgreSQL.

**Riesgo**

- Es ampliamente conocido.
- Puede ser identificado fácilmente mediante herramientas automatizadas de exploración.

---

## Configuraciones Adecuadas Detectadas

### Password Encryption

Configuración encontrada:

```text
scram-sha-256
```

**Beneficio**

- Utiliza un mecanismo moderno para el almacenamiento de contraseñas.
- Ofrece mayor protección que métodos heredados como MD5.

---

## Restricciones del Entorno Académico

No fue posible consultar determinadas configuraciones debido a restricciones de permisos de la instancia utilizada para el laboratorio.

Consultas afectadas:

```sql
SHOW config_file;

SHOW hba_file;

SHOW ident_file;
```

Error obtenido:

```text
ERROR: must be superuser or have privileges of pg_read_all_settings
```

Este comportamiento evidencia la aplicación del principio de mínimo privilegio dentro del entorno académico.

---

## Revisión de pg_hba.conf

No fue posible acceder directamente al contenido de las reglas de autenticación mediante:

```sql
SELECT
    type,
    database,
    user_name,
    address,
    auth_method
FROM pg_hba_file_rules;
```

Debido a restricciones de permisos establecidas en el entorno.

Como consecuencia, no fue posible validar directamente:

- Reglas IPv4.
- Reglas IPv6.
- Redes permitidas.
- Métodos de autenticación configurados.
- Existencia de reglas amplias como:

```text
0.0.0.0/0
```

o

```text
::/0
```

---

## Recomendaciones de Hardening

### Red

- Restringir las interfaces de escucha únicamente a las necesarias.
- Limitar conexiones remotas a redes autorizadas.
- Mantener reglas de firewall basadas en allowlist.

### Autenticación

- Mantener SCRAM-SHA-256.
- Evitar mecanismos heredados.
- Utilizar contraseñas robustas.

### Cifrado

- Habilitar TLS cuando el entorno lo permita.
- Verificar versiones y algoritmos utilizados.

### Acceso

- Aplicar el principio de mínimo privilegio.
- Separar cuentas administrativas de cuentas de aplicación.
- Revisar periódicamente los privilegios asignados.

## Revisión de Roles

Se realizó una revisión de los roles existentes mediante la vista `pg_roles`.

### Hallazgos

- No se identificaron superusuarios en los registros visibles.
- No se identificaron roles con privilegios `CREATEROLE`.
- No se identificaron roles con privilegios `CREATEDB`.
- Existen roles con capacidad de inicio de sesión (`LOGIN`).
- Existen roles utilizados únicamente para asignación de privilegios y que no pueden iniciar sesión.

### Análisis

La ausencia de privilegios administrativos en los roles visibles reduce el riesgo de modificaciones no autorizadas sobre la instancia PostgreSQL. La separación entre roles con capacidad de inicio de sesión y roles utilizados para administración de permisos constituye una práctica alineada con el principio de mínimo privilegio.

## Resultado Esperado Después del Hardening

| Control | Estado Esperado |
|----------|----------|
| listen_addresses | Interfaces justificadas |
| SSL/TLS | Habilitado |
| Cuentas administrativas | Controladas |
| Cuentas de aplicación | Separadas |
| Reglas de acceso | Específicas |
| Contraseñas | SCRAM-SHA-256 |
| Firewall | Basado en allowlist |
| Documentación | Actualizada |
