# LAB-01: Protección y Privacidad de Datos

## Alumno
Miguel Guillermo Grosso Velarde

## Objetivo

Aplicar técnicas de protección y privacidad de datos en PostgreSQL mediante la identificación de información sensible, el uso de mecanismos de enmascaramiento, control de acceso, seudonimización, anonimización y políticas de retención de datos. El propósito es reducir el riesgo de exposición y reidentificación de información personal.

# Actividad 1. Clasificación de Datos

## Identificación de datos

Se analizó la tabla `clientes` para clasificar los atributos según su capacidad para identificar directa o indirectamente a una persona.

### Identificadores directos

- nombre
- correo
- telefono
- rfc

Estos campos permiten identificar a una persona de manera inmediata.

### Cuasi-identificadores

- id
- edad
- ciudad
- codigo_postal
- fecha_alta

Aunque no identifican directamente a una persona, pueden combinarse para reducir el anonimato y facilitar procesos de reidentificación.

### Riesgo identificado

Combinaciones como:

```text
edad + ciudad + codigo_postal
```

o

```text
edad + ciudad + fecha_alta
```

pueden utilizarse para reconocer individuos específicos cuando existe información adicional disponible.

### Conclusión

La clasificación de datos permite identificar qué información requiere medidas de protección especiales y constituye el primer paso para implementar controles de privacidad.

# Actividad 2. Enmascaramiento de Datos

## Objetivo

Restringir la visualización de información sensible para determinados usuarios sin modificar los datos originales almacenados en la base de datos.

## Implementación

Se creó una vista con información parcialmente ocultada para proteger:

- Correo electrónico
- Teléfono
- RFC

Ejemplo:

```text
correo: an*****@example.test
telefono: ******4567
rfc: *********3ABC
```

## Resultado

Los usuarios pueden realizar sus tareas operativas sin acceder a la información completa del cliente.

### Conclusión

El enmascaramiento reduce la exposición de datos personales y limita el acceso únicamente a la información necesaria.

# Actividad 3. Control de Acceso

## Objetivo

Aplicar el principio de mínimo privilegio mediante la asignación de permisos específicos para cada usuario.

## Implementación

Se configuraron permisos diferenciados sobre tablas y vistas para restringir el acceso a información sensible.

## Beneficios

- Menor exposición de datos.
- Mayor control sobre la información.
- Reducción de accesos indebidos.

### Conclusión

El control de acceso permite asegurar que cada usuario visualice únicamente la información requerida para desempeñar sus funciones.

# Actividad 4. Seudonimización

## Objetivo

Sustituir identificadores reales por valores alternativos para disminuir la exposición de datos personales durante procesos de análisis.

## Implementación

Los datos identificables fueron reemplazados por tokens.

Ejemplo:

```text
Cliente A → TOKEN_001
Cliente B → TOKEN_002
Cliente C → TOKEN_003
```

## Resultado

La identidad de los usuarios se mantiene protegida durante las consultas y análisis.

## Riesgo residual

La seudonimización no equivale a anonimización porque existe una tabla de correspondencia que permite relacionar nuevamente los tokens con los datos reales.

### Conclusión

La protección depende del control de acceso sobre la tabla que almacena la relación entre tokens e identidades reales.


# Actividad 5. Anonimización

## Objetivo

Generar información estadística sin exponer datos individuales de los clientes.

## Consulta utilizada

```sql
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY *;
```

## Beneficios

- Eliminación d* información individual.
- Present*ción exclusiva de datos agregados.*- Reducción del riesgo de identifi*ación directa.

### Conclusión

La*anonimización permite obtener info*mación útil para análisis sin reve*ar datos personales específicos.

*--

# Actividad 6. Análisis del Ri*sgo de Reidentificación

## Objeti*o

Evaluar si los datos anonimizad*s pueden utilizarse para identificar indirectamente a una persona.

## Riesgos detectados

Aun después de eliminar identificadores directos, permanecen atributos capaces de facilitar la reidentificación:

- edad
- ciudad
- codigo_postal
- fecha_alta

## Cambio realizado

Se modificó la consulta para agrupar edades y excluir grupos con pocos registros:

```sql
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY 1
HAVING COUNT(*) >= 2;
```

## Motivo

Reducir la*posibilidad de identificar persona* pertenecientes a grupos pequeños * disminuir el nivel de detalle exp*esto.

## Resultado obtenido

Los *atos se muestran únicamente de for*a agregada y se excluyen agrupacio*es con muy pocos registros.

## Ri*sgos que se pretende reducir

### *eidentificación individual

Evitar*que una persona pueda ser reconoci*a mediante la combinación de vario* atributos.

### Correlación con i*formación externa

Reducir la posi*ilidad de asociar los datos con in*ormación obtenida de fuentes exter*as.

### Exposición de grupos pequ*ños

Impedir que grupos con pocos *egistros faciliten inferencias sob*e individuos específicos.

### Div*lgación indirecta de información

*imitar la información disponible p*ra la reconstrucción de perfiles p*rsonales.

### Conclusión

La gene*alización y agregación de datos fo*talecen significativamente el nive* de anonimización y disminuyen el *iesgo de reidentificación.

---

#*Actividad 7. Retención de Datos

#* Objetivo

Definir criterios para *onservar únicamente la información*necesaria durante un periodo deter*inado.

## Consulta utilizada

```*ql
SELECT *
FROM clientes
WHERE fe*ha_alta < CURRENT_DATE - INTERVAL *5 years';
```

## Registros afecta*os

Todos aquellos cuya fecha de a*ta exceda el periodo de retención *stablecido.

## Justificación del *eriodo de retención

- Cumplimient* de requisitos legales.
- Necesida*es operativas del negocio.
- Aplic*ción del principio de minimización*de datos.
- Reducción de riesgos a*ociados al almacenamiento prolonga*o.

## Aprobaciones necesarias

An*es de eliminar datos debe existir *utorización de:

- Responsable del*área de negocio.
- Área jurídica o*de cumplimiento.
- Responsable de *ases de datos.

## Respaldo requer*do

Debe generarse y validarse un *espaldo de la base de datos antes *e cualquier proceso de eliminación*

## Evidencias que deben conserva*se

- Fecha de ejecución.
- Respon*able de la actividad.
- Cantidad d* registros afectados.
- Motivo de *a eliminación.
- Evidencia de apro*ación.

## Recuperación ante error*s

La recuperación puede realizars* mediante la restauración de respa*dos previamente generados y valida*os.


# Conclusiones 

**¿Qué técnica utilizarías para un área de soporte?**

Utilizaría el **enmascaramiento de datos**, ya que permite a los usuarios visualizar únicamente la información necesaria para realizar sus actividades sin exponer completamente datos sensibles como correos electrónicos, teléfonos o RFC.

**¿Qué técnica utilizarías para un área de analítica?**

Utilizaría la **seudonimización**, porque permite trabajar con los datos mediante identificadores sustitutos o tokens, facilitando el análisis de la información sin revelar directamente la identidad de las personas.

**¿Qué técnica utilizarías para publicar estadísticas?**

Utilizaría la **anonimización**, ya que transforma la información en datos agregados o generales que impiden identificar a los individuos, siendo la opción más adecuada para compartir resultados estadísticos.

**¿Por qué ninguna de estas técnicas sustituye al control de acceso?**

Porque el control de acceso es la primera capa de seguridad y determina quién puede consultar, modificar o administrar la información. Aunque el enmascaramiento, la seudonimización y la anonimización reducen la exposición de los datos, ninguna evita por sí 
sola que usuarios no autorizados accedan a los recursos si los permisos no están correctamente configurados.

