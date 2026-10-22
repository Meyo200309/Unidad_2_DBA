# Evidencias - Act.1,2,3,4 

## 1. Objetivo

Aplicar principios de privacidad y seguridad sobre la tabla `clientes` en PostgreSQL, para:

1. Identificar qué datos personales se almacenan, para qué se usan y cuánto tiempo deben conservarse.
2. Reducir los datos entregados a cada área al mínimo necesario.
3. Entregar a analítica solo información agregada y no identificable.
4. Restringir el acceso mediante un rol y una vista.


## 2. Procedimiento

### Actividad 1 — Inventario y finalidad de los datos
1. Se revisó la estructura de la tabla `clientes` (`\d clientes`).
2. Para cada campo se evaluó si es dato personal, su finalidad, si es necesario, quién debe acceder y su retención.
3. Se documentó una justificación por cada decisión (ver sección 3.1).

### Actividad 2 — Principio de minimización
1. Se analizó la solicitud de soporte para crear `clientes_soporte` con todos los campos (incluidos `rfc`, `edad` y `codigo_postal`).
2. Se diseñó una estructura mínima y se cargó desde `clientes`:

```sql
CREATE TABLE clientes_soporte (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20)
);

INSERT INTO clientes_soporte (id, nombre, correo, telefono)
SELECT id, nombre, correo, telefono
FROM clientes;

SELECT * FROM clientes_soporte;
```

### Actividad 3 — Separación por finalidad
Analítica necesita ciudad, rango de edad y región del código postal; no necesita nombre, correo, teléfono ni RFC.

```sql
-- Clientes por ciudad
SELECT ciudad, COUNT(*) AS cantidad_clientes
FROM clientes
GROUP BY ciudad
ORDER BY cantidad_clientes DESC;

-- Clientes por rango de edad
SELECT
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad,
    COUNT(*) AS cantidad
FROM clientes
GROUP BY
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END
ORDER BY rango_edad;

-- (Opcional) Región por código postal
SELECT LEFT(codigo_postal, 2) AS region_cp, COUNT(*) AS cantidad
FROM clientes
GROUP BY LEFT(codigo_postal, 2)
ORDER BY cantidad DESC;
```

### Actividad 4 — Control de acceso relacionado con la finalidad

```sql
CREATE ROLE analista NOLOGIN;

CREATE VIEW v_analitica_clientes AS
SELECT
    ciudad,
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad
FROM clientes;

GRANT USAGE ON SCHEMA public TO analista;
GRANT SELECT ON v_analitica_clientes TO analista;

-- Verificación de privilegios
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'analista';

-- Prueba de acceso 
SET ROLE analista;
SELECT * FROM v_analitica_clientes LIMIT 5;  -- debe funcionar
SELECT * FROM clientes LIMIT 5;              -- debe fallar: permission denied
RESET ROLE;
```

## 3. Resultado

### 3.1 Inventario de datos - Actividad 1

| Campo | ¿Es dato personal? | Finalidad | ¿Es necesario? | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| id | Si | Llave primaria; relacionar registros | Sí | Todos los roles operativos | Mientras exista la relación con el cliente |
| nombre | Sí | Identificar al cliente y dirigirse a él | Sí | Soporte, ventas, administración | Relación con el cliente mas plazo legal |
| correo | Sí | Notificaciones, comunicación y soporte | Sí | Soporte, administración | Relación con el cliente mas plazo legal |
| telefono | Sí | Contacto alterno para soporte | opcional | Soporte | Relación con el cliente; eliminar si el cliente lo retira |
| rfc | Sí | Facturación y obligaciones fiscales | Solo si se emite factura | Solo facturación/finanzas | Plazo fiscal |
| edad | Sí | Validar mayoría de edad y estadísticas | opcional | Analítica (solo en rangos); administración | Mientras sea útil; preferir conservar el rango |
| ciudad | Sí | Envíos, cobertura y estadísticas | Opcional | Analítica, logística, administración | Relación con el cliente |
| codigo_postal | Sí | Envíos, facturación y segmentación regional | Opcional | Logística, facturación; analítica solo como región | Relación con el cliente |
| fecha_alta | Sí | Antigüedad, auditoría y control | Sí | Administración, auditoría, analítica | Relación con el cliente mas periodo de auditoría |

**Justificaciones**
- **id:** por sí solo no identifica a nadie, pero enlaza todos los datos del cliente, por lo que no debe exponerse fuera de la organización.
- **nombre:** identificador básico de la persona.
- **correo:** canal principal de comunicación, sin él no hay notificaciones ni seguimiento.
- **telefono:** el servicio funciona sin él, por eso es opcional.
- **rfc:** el dato de mayor riesgo, permite vincular a la persona con su situación fiscal. Solo se justifica para facturar, por lo que soporte y analítica no deben verlo.
- **edad:** el valor exacto rara vez es necesario, para estadísticas basta un rango y para validar mayoría de edad basta un indicador sí/no.
- **ciudad:** riesgo individual bajo, pero combinada con edad o código postal facilita reidentificar personas.
- **codigo_postal:** más específico que la ciudad; para analítica basta una región.
- **fecha_alta:** necesaria para auditoría y control, riesgo bajo.

### 3.2 Minimización - Actividad 2

`SELECT * FROM clientes_soporte;` devuelve únicamente `id`, `nombre`, `correo` y `telefono`.


**Preguntas**
1. **¿Todos los campos son necesarios para atención al cliente?** No. Solo `id`, `nombre`, `correo` y, opcionalmente, `telefono`.
2. **¿Por qué soporte necesitaría conocer el RFC?** En general no lo necesita; es un dato fiscal que solo se justifica para facturación. Darlo a soporte aumenta el riesgo de fuga o uso indebido sin beneficio para resolver incidencias.
3. **¿Necesita conocer la edad?** No; resolver una solicitud de soporte no depende de ella.
4. **¿Necesita conocer el código postal?** No, salvo casos puntuales (por ejemplo, soporte de envíos), que deben atenderse con acceso específico y no con un campo permanente.
5. **¿Qué principio de privacidad está relacionado?** El principio de **minimización de datos**, junto con el de **finalidad**.

### 3.3 Separación por finalidad - Actividad 3

**Pregunta: ¿por qué esta información es más apropiada para analítica que la tabla completa de clientes?**
- Aplica **minimización**: analítica recibe solo lo necesario para su finalidad.
- Aplica **finalidad**: los datos de contacto y el RFC se recolectaron para otros fines (atención, facturación), no para estadística.
- Al ser **agregada**, no permite identificar directamente a una persona, lo que reduce el riesgo ante filtraciones o mal uso.
- Limita el daño si la cuenta o el reporte de analítica se compromete.

### 3.4 Control de acceso - Actividad 4

**Preguntas**
1. **¿Qué información puede consultar el rol?** Solo ciudad y rango_edad, a través de la vista v_analitica_clientes.
2. **¿Puede consultar directamente `clientes`?** No; no tiene SELECT sobre esa tabla y PostgreSQL responde permission denied for table clientes.
3. **¿Puede obtener nombre, correo y RFC?** No; no están en la vista y el rol no tiene permiso sobre la tabla base.
4. **¿Qué principio de privacidad se aplica?** Minimización y limitación por finalidad.
5. **¿Qué principio de seguridad se aplica?** Mínimo privilegio: mediante control de acceso basado en roles (RBAC) y separación de funciones.


## 4. Análisis

- **Inventario:** todos los campos son datos personales porque, combinados, identifican a una persona, pero no todos tienen el mismo riesgo ni son igual de necesarios. `rfc`, `telefono`, `edad` y `codigo_postal` dependen de la finalidad y no deben estar disponibles para todas las áreas.
- **Minimización:** la tabla original replicaba todos los datos "por si acaso", lo que amplía el impacto de una filtración o un acceso indebido. La versión de cuatro campos cubre la función de soporte sin exponer RFC, edad ni ubicación. Como `clientes_soporte` es una copia, debe mantenerse sincronizada con `clientes` o sustituirse por una vista, para evitar datos duplicados y desactualizados.
- **Separación por finalidad:** entregar datos agregados y generalizados (rangos y regiones) permite que analítica haga su trabajo sin datos personales directos. Limitación: si un grupo es muy pequeño (por ejemplo, una ciudad con 1 o 2 clientes), el agregado podría permitir reidentificar a alguien; una buena práctica es suprimir o agrupar conteos menores a un umbral (por ejemplo, menos de 5).
- **Control de acceso:** la vista funciona como capa de protección, ya que el rol accede a ella con los permisos del propietario de la vista y no necesita permiso sobre `clientes`. Si la cuenta del analista se comprometiera, solo se obtendría ciudad y rango de edad. `USAGE` sobre el esquema no da acceso a los datos de otras tablas y no aparece en `role_table_grants`. Además, la categoría `Menor de 18` merece atención especial por el tratamiento de datos de menores.
- **Visión de conjunto:** las cuatro actividades forman un flujo coherente: se inventarían los datos (qué y para qué), se minimizan (cuánto se entrega), se agregan (en qué forma) y se restringen (quién accede).


## 5. Conclusión

Proteger la privacidad no consiste solo en cifrar o poner contraseñas, 
sino en decidir desde el diseño qué datos se recolectan, para qué se usan, 
quién los ve y por cuánto tiempo.
