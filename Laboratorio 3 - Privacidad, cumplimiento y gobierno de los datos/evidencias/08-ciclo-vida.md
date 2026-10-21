# Actividades 8 y 9 

## 1. Objetivo

Comprender porqué una solicitud de cancelación no se limita a ejecutar un `DELETE`
sobre la tabla principal, y analizar cómo debe tratarse una solicitud de oposición a una finalidad secundaria, 
identificando el papel del DBA en ambos casos.

## 2. Procedimiento

**Actividad 8.** Se supuso una solicitud de cancelación ya autorizada y no se ejecutó ningún DELETE. 
Primero se analizó si existen: otras tablas relacionadas, respaldos, réplicas, registros de auditoría, c
opias para analítica, archivos exportados y sistemas externos. Con ese análisis se construyó un mapa a partir de `clientes`.

**Actividad 9.** Se supuso que un cliente solicita que sus datos no se usen para una finalidad secundaria. 
Se analizó si es necesario eliminar todos sus datos y se explicaron los cuatro puntos solicitados.

## 3. Resultado

### Actividad 8 — Análisis previo

| Pregunta | Análisis |
|---|---|
| ¿Existen otras tablas relacionadas? | Sí. Pueden existir tablas que referencian al cliente por `id` o `cliente_id`, además de copias como `clientes_soporte`. |
| ¿Existen respaldos? | Sí. Conservan el dato tal como estaba al momento de la copia. |
| ¿Existen réplicas? | Sí. Las réplicas y los entornos de prueba pueden conservar el registro. |
| ¿Existen registros de auditoría? | Sí. Las bitácoras pueden contener datos personales. |
| ¿Existen copias para analítica? | Sí. Pueden existir tablas o reportes derivados de `clientes`. |
| ¿Existen archivos exportados? | Sí. Archivos CSV o Excel y adjuntos en correos, fuera del control de la base. |
| ¿Existen sistemas externos? | Sí. Plataformas de correo, facturación o proveedores con sus propias copias. |

### Mapa

```
clientes
│
├── respaldos (copias lógicas y físicas, WAL, snapshots)
├── réplicas (lectura, alta disponibilidad, pruebas)
├── reportes (analítica y tableros)
├── exportaciones (CSV, Excel, adjuntos)
└── sistemas externos (correo/marketing, facturación, proveedores)
```
### Pregunta: 
¿por qué eliminar un registro de una tabla no significa que toda la información haya desaparecido de la organización?

Porque la información de una persona no vive solo en `clientes`. 
Existen copias en otras tablas, respaldos, réplicas, reportes, archivos exportados y sistemas externos que el `DELETE` no alcanza.
Los respaldos conservan el dato hasta que expiran, y los sistemas externos tienen sus propias copias. 

### Actividad 9 — Derecho de oposición

**¿Es necesario eliminar inmediatamente todos sus datos de la base?**
No. La oposición se refiere a una finalidad concreta, no a todo el tratamiento,
eliminar todo sería desproporcionado, ya que se seguirían necesitando datos para la relación principal con el cliente.

**1. Qué información podría necesitar mantenerse.** Los datos necesarios para la relación con el cliente (por ejemplo, `id`, `nombre`, `correo`, `fecha_alta`), los datos exigidos por obligaciones legales o fiscales (como el `rfc` si hay facturación) y un registro de la oposición para poder respetarla.

**2. Qué información podría dejar de utilizarse para determinada finalidad.** Por ejemplo, la edad, la ciudad, el correo y el comportamiento de compra dejarían de usarse para promociones y perfilamiento de marketing; el cliente queda excluido de esas campañas.

**3. Qué mecanismos técnicos podrían separar finalidades.**
- Una columna o tabla de preferencias por finalidad (por ejemplo, `acepta_marketing`).
- Vistas por finalidad que filtran a quienes no aceptan.
- Roles separados por área, sin acceso a la tabla base.
- Auditoría de los cambios de preferencia.

**4. Por qué la decisión final no debe ser tomada únicamente por el DBA.** El DBA es responsable de la parte técnica, pero no de determinar si procede la oposición, qué excepciones aplican ni qué datos deben conservarse por ley; eso corresponde a las áreas de privacidad, jurídico y cumplimiento. Además, la decisión afecta al negocio y algunas acciones, como borrar, son irreversibles, por lo que deben ser autorizadas y quedar documentadas.

## 4. Análisis

En la cancelación si no se sabe dónde está el dato, 
no se puede cancelar por completo. En la oposición, la solución es dejar de usar los datos para la finalidad indicada, 
sin destruir los que aún son necesarios. En ambos casos el DBA ejecuta y documenta, 
pero la decisión corresponde al área responsable.

## 5. Conclusión

Eliminar un registro no equivale a eliminar la información de una persona de toda la organización,
por lo que la cancelación exige mapear primero dónde se encuentra el dato. La oposición no implica borrar todos los datos, 
sino separar las finalidades para que el dato deje de usarse en la que el titular rechazó. En ambos derechos,
la decisión es compartida entre el DBA y las áreas de privacidad y cumplimiento.
