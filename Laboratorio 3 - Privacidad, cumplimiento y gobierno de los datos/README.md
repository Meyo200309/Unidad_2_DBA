# LAB-03: Informe Final

**Alumno:** Miguel Guillermo Grosso Velarde

# 1. Introducción

La protección de datos personales constituye un desafío fundamental para las organizaciones que almacenan y procesan información de clientes. Durante el desarrollo de las actividades se analizaron mecanismos de clasificación de información, control de acceso, seudonimización, anonimización, retención de datos y atención de solicitudes relacionadas con derechos de los titulares, con el objetivo de diseñar una gestión responsable y segura de la información.

# 2. Inventario de Datos

| Campo | Clasificación |
|---------|---------|
| id | Identificador interno |
| nombre | Dato personal identificable |
| correo | Dato personal identificable |
| telefono | Dato personal identificable |
| rfc | Dato personal identificable |
| edad | Cuasi-identificador |
| ciudad | Cuasi-identificador |
| codigo_postal | Cuasi-identificador |
| fecha_alta | Dato administrativo |

## Identificadores directos

- nombre
- correo
- telefono
- rfc

## Cuasi-identificadores

- edad
- ciudad
- codigo_postal
- fecha_alta

# 3. Finalidades

| Dato | Finalidad |
|----------|----------|
| nombre | Identificación del cliente |
| correo | Comunicación y notificaciones |
| telefono | Contacto con el cliente |
| rfc | Facturación y cumplimiento fiscal |
| edad | Estadísticas y segmentación |
| ciudad | Análisis geográfico |
| codigo_postal | Segmentación regional |
| fecha_alta | Gestión administrativa y retención |

# 4. Minimización

El principio de minimización establece que solo deben recopilarse y procesarse los datos estrictamente necesarios para cumplir una finalidad específica.

## Datos que pueden limitarse para análisis

- nombre
- correo
- telefono
- rfc

Estos datos no son necesarios para generar reportes estadísticos o métricas de negocio.

## Medidas aplicadas

- Seudonimización.
- Anonimización.
- Agregación de información.
- Generalización de atributos.

## Beneficio

Reducir la exposición de información personal innecesaria y disminuir el riesgo de reidentificación.

# 5. Control de Acceso

Los permisos deben relacionarse directamente con las responsabilidades de cada área.

| Área | Acceso permitido |
|---------|---------|
| Operación | Información necesaria para la atención de clientes |
| Soporte | Datos parcialmente enmascarados |
| Analítica | Información agregada o seudonimizada |
| Desarrollo | Datos anonimizados o sintéticos |
| Auditoría | Registros y evidencias de actividad |

## Principio aplicado

**Mínimo privilegio**

Cada usuario accede únicamente a los datos necesarios para realizar su trabajo.

# 6. Derechos ARCO

Los derechos ARCO permiten a los titulares ejercer control sobre sus datos personales.

## Acceso

Permite conocer qué información posee la organización.

## Rectificación

Permite corregir datos incorrectos o desactualizados.

## Cancelación

Permite solicitar la eliminación de información cuando proceda.

## Oposición

Permite limitar determinados usos de los datos personales.


## Implicaciones Técnicas

- Identificación de registros asociados al titular.
- Localización de la información en distintas tablas.
- Procedimientos de eliminación controlada.
- Gestión de respaldos.

# 7. Retención

La información no debe conservarse indefinidamente.

La definición del periodo de conservación debe considerar:

- Requisitos legales.
- Obligaciones regulatorias.
- Necesidades operativas.
- Riesgos de privacidad.
- Costos de almacenamiento.

# 8. Gobierno de Datos

## Matriz de Responsabilidades

| Rol | Responsabilidad |
|---------|---------|
| Dirección | Aprobar políticas de privacidad |
| Responsable de Privacidad | Supervisar cumplimiento y gestión de riesgos |
| Área Jurídica | Interpretar requisitos normativos |
| DBA | Implementar controles técnicos y administrar accesos |
| Desarrollo | Utilizar datos anonimizados para pruebas |
| Analítica | Utilizar información mínima necesaria |
| Marketing | Usar datos conforme a la finalidad autorizada |
| Auditoría | Verificar cumplimiento y controles |

## Objetivos del Gobierno de Datos

- Proteger la información personal.
- Garantizar cumplimiento normativo.
- Reducir riesgos operativos.
- Definir responsabilidades claras.
- Mejorar la calidad y trazabilidad de los datos.

# 9. Evaluación Integral

## Principales riesgos identificados

1. Acceso directo de analistas a datos personales.
2. Exposición innecesaria de nombre, correo, teléfono y RFC.
3. Falta de aplicación del principio de minimización.
4. Conservación de datos durante 12 años.
5. Ausencia de una política documentada de retención.
6. Uso de datos reales en ambientes de desarrollo.
7. Entrega de copias completas de bases productivas a desarrolladores.
8. Utilización de correos electrónicos para finalidades no documentadas.
9. Falta de documentación sobre la finalidad de cada dato.
10. Riesgo de reidentificación mediante cuasi-identificadores.

# 10. Conclusiones

Durante el desarrollo de este laboratorio se comprendió que la privacidad, la seguridad y la administración de bases de datos están estrechamente relacionadas. Una base de datos puede ser técnicamente segura, pero aun así presentar problemas de privacidad si los datos se utilizan para finalidades inadecuadas o se conservan más tiempo del necesario.
Finalmente, se concluyó que el gobierno de datos, la definición clara de responsabilidades y el establecimiento de políticas de retención son elementos fundamentales para garantizar una gestión segura, responsable y conforme a los principios de protección de datos.

# 11. Preguntas de Reflexión

## 1. ¿Una base de datos técnicamente segura necesariamente cumple con todos los requisitos de privacidad?

No. Una base de datos puede implementar controles de seguridad adecuados y aun así incumplir principios de privacidad si los datos se utilizan para finalidades no autorizadas, se conservan más tiempo del necesario o se recopila información excesiva.

## 2. ¿Por qué el principio de mínimo privilegio también contribuye a la privacidad?

Porque limita el acceso a la información únicamente a los usuarios que necesitan utilizarla para desempeñar sus funciones, reduciendo la exposición de datos personales.

## 3. ¿Por qué el DBA no debería decidir por sí solo la finalidad del tratamiento de los datos?

Porque la finalidad del tratamiento es una decisión organizacional y legal que debe involucrar a los responsables del negocio, privacidad y cumplimiento normativo. El DBA es responsable de implementar los controles técnicos necesarios.

## 4. ¿Por qué los desarrolladores no deberían recibir automáticamente copias completas de bases de datos productivas?

Porque normalmente no necesitan información real para desarrollar o probar aplicaciones. El acceso a datos reales incrementa el riesgo de exposición y fuga de información personal.

## 5. ¿Por qué una copia utilizada para desarrollo también puede representar un riesgo de privacidad?

Porque contiene información personal que podría ser consultada, copiada o expuesta en entornos con menores controles de seguridad que el ambiente productivo.

## 6. ¿Por qué la retención debe formar parte del ciclo de vida de los datos?

Porque permite eliminar información que ya no tiene una finalidad válida, reduciendo riesgos de seguridad, costos de almacenamiento y posibles incumplimientos normativos.

## 7. ¿Qué relación existe entre privacidad por diseño y diseño de bases de datos?

La privacidad por diseño implica incorporar controles de protección desde la planificación del sistema. En bases de datos esto incluye minimización de datos, control de acceso, cifrado, anonimización y segregación de información.

## 8. ¿Qué controles técnicos implementarías para reducir el riesgo de exposición de datos personales?

- Control de acceso basado en roles.
- Cifrado de datos sensibles.
- Enmascaramiento de datos.
- Seudonimización.
- Anonimización.
- Auditoría de accesos.
- Monitoreo de actividades.
- Separación de ambientes productivos y de desarrollo.

## 9. ¿Qué información debería conocer un DBA para responder técnicamente a una solicitud ARCO?

- Ubicación de los datos del titular.
- Relaciones entre tablas.
- Sistemas que almacenan la información.
- Procedimientos de actualización o eliminación.
- Respaldos existentes.
- Mecanismos de trazabilidad y auditoría.

## 10. ¿Qué responsabilidades deberían corresponder al DBA, al responsable de privacidad, al área jurídica y al propietario de los datos?

### DBA

- Administrar la infraestructura de bases de datos.
- Implementar controles de seguridad.
- Administrar accesos y respaldos.

### Responsable de Privacidad

- Supervisar el cumplimiento de políticas de protección de datos.
- Gestionar riesgos de privacidad.
- Coordinar solicitudes ARCO.

### Área Jurídica

- Interpretar requisitos legales.
- Validar políticas y procedimientos.
- Asesorar en temas regulatorios.

### Propietario de los Datos

- Definir la finalidad del tratamiento.
- Autorizar el uso de la información.
- Determinar necesidades operativas y periodos de conservación.
