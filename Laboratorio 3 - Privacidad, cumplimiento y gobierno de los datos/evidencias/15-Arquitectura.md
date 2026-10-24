# Actividad 15 

## Objetivo

Diseñar una arquitectura conceptual que permita separar el uso de los datos según su finalidad, aplicando controles de privacidad, seguridad y gobierno de datos para reducir riesgos de acceso indebido, exposición de información sensible y conservación innecesaria de información.

## Procedimiento

Se identificaron las principales áreas que interactúan con los datos de los clientes y se definió una separación lógica de la información según la finalidad de cada proceso. Además, se incorporaron controles de protección para acceso, minimización, retención, trazabilidad y eliminación de datos.

## Propuesta de Arquitectura

```text
                           BASE DE DATOS
                                  │
        ┌─────────────────────────┼─────────────────────────┐
        │                         │                         │
        ▼                         ▼                         ▼
   OPERACIÓN                 ANALÍTICA                 AUDITORÍA
        │                         │                         │
        ▼                         ▼                         ▼
Datos necesarios         Datos agregados           Registros de
para la operación        o seudonimizados         actividad y acceso
        │                         │                         │
        ▼                         ▼                         ▼
 Atención a clientes      Estadísticas e         Evidencias de
 Ventas                   indicadores            cumplimiento
 Soporte                  Reportes               Auditorías
```

## Controles Propuestos

### 1. Control de Acceso

- Implementar acceso basado en roles (RBAC).
- Cada área accede únicamente a la información necesaria para sus funciones.
- Restringir el acceso a datos sensibles mediante permisos específicos.

### 2. Minimización de Datos

- Recopilar únicamente los datos necesarios para cada proceso.
- Evitar que áreas analíticas consulten identificadores directos.
- Limitar la información visible según la finalidad de uso.


### 3. Protección de Información Sensible

- Aplicar enmascaramiento de datos para usuarios operativos.
- Utilizar seudonimización para análisis internos.
- Aplicar cifrado a información sensible almacenada.
- Proteger especialmente identificadores personales.

### 4. Retención

- Definir tiempos máximos de conservación.
- Revisar periódicamente la información almacenada.
- Mantener únicamente los datos necesarios para cumplir fines operativos y legales.

### 5. Trazabilidad

- Registrar accesos a datos sensibles.
- Mantener bitácoras de consultas y modificaciones.
- Conservar evidencia de quién accedió, cuándo y qué información utilizó.

### 6. Eliminación

- Establecer procedimientos formales de eliminación.
- Realizar respaldos antes de procesos masivos.
- Documentar las eliminaciones ejecutadas.

### 7. Atención de Solicitudes

- Establecer un procedimiento para atender solicitudes relacionadas con datos personales.
- Permitir consulta, corrección o eliminación cuando corresponda.
- Mantener registro de las solicitudes recibidas y su atención.

## Resultado

La arquitectura propuesta separa la información según su finalidad y limita el acceso de cada área a los datos estrictamente necesarios. Esto reduce la exposición de información sensible y facilita la aplicación de controles de privacidad y seguridad.

## Análisis

La separación entre operación, analítica y auditoría permite aplicar el principio de mínimo privilegio. Los usuarios operativos pueden realizar sus funciones sin exponer información innecesaria, mientras que el área analítica trabaja sobre datos agregados o seudonimizados. 

## Conclusión

La arquitectura traduce los principios de privacidad en decisiones técnicas concretas mediante la segmentación de la información, la aplicación de controles de acceso, la minimización de datos y la protección de información sensible. 
