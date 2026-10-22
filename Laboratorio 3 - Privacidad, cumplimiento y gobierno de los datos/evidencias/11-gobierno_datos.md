# Actividad 11 

## 1. Objetivo

Diseñar una matriz de gobierno de datos para los principales campos de la tabla `clientes`, demostrando que el acceso a cada dato debe relacionarse con una necesidad funcional.

## 2. Procedimiento

1. Se tomaron los campos principales de la tabla: nombre, correo, telefono, rfc, edad, ciudad y codigo_postal.
2. Para cada campo se definió: finalidad, responsable, usuarios autorizados, protección, retención y acción al finalizar el periodo.
3. Se asignaron los roles (Atención al cliente, Facturación, Analítica, DBA y Dirección) únicamente cuando existe una necesidad funcional, sin asignar todos los roles a todos los datos.

## 3. Resultado

| Dato | Finalidad | Responsable | Usuarios autorizados | Protección | Retención | Acción al finalizar |
|---|---|---|---|---|---|---|
| nombre | Identificar al cliente y dirigirse a él | Atención al cliente | Atención al cliente, Facturación | Acceso por rol, cifrado en tránsito y en reposo | Mientras dure la relación con el cliente más plazo legal | Eliminar o anonimizar |
| correo | Comunicación, notificaciones y envío de comprobantes | Atención al cliente | Atención al cliente, Facturación | Acceso por rol, cifrado, auditoría de consultas | Mientras dure la relación con el cliente | Eliminar |
| telefono | Contacto alterno para atención | Atención al cliente | Atención al cliente | Acceso por rol, enmascarado parcial en consultas | Mientras dure la relación o hasta que el cliente lo retire | Eliminar |
| rfc | Facturación y obligaciones fiscales | Facturación | Facturación | Acceso restringido, cifrado a nivel de columna, auditoría de consultas | Plazo fiscal aplicable | Bloquear al terminar la relación y eliminar al vencer el plazo fiscal |
| edad | Estadísticas y validación de mayoría de edad | Analítica | Analítica, Dirección | Vista con rangos de edad, sin acceso a la tabla base | Mientras sea útil para la finalidad | Conservar solo el rango o eliminar |
| ciudad | Envíos y estadísticas | Analítica | Analítica, Dirección | Vista agregada, acceso por rol | Mientras dure la relación con el cliente | Anonimizar o eliminar |
| codigo_postal | Facturación y envíos | Facturación | Facturación, Analítica | Acceso por rol, generalización a región para analítica | Mientras dure la relación más plazo fiscal | Eliminar o generalizar a región |


## 4. Análisis

La matriz muestra que cada dato tiene un responsable y un grupo reducido de usuarios, definido por su función: el RFC solo es necesario para Facturación, el teléfono y el correo para Atención al cliente, y la edad y la ciudad para Analítica, que además los recibe generalizados. Ningún rol tiene acceso a todos los datos. Además, la protección aumenta según el riesgo del dato (por ejemplo, el RFC tiene controles más estrictos que la ciudad) y cada campo tiene definido su periodo de retención y qué se hará al terminar.

## 5. Conclusión

El acceso a los datos debe basarse en la necesidad funcional de cada área, no en que la organización los posea. Una matriz de gobierno de datos permite definir quién es responsable de cada dato, quién puede usarlo, cómo se protege, cuánto tiempo se conserva y qué se hace al finalizar, lo que facilita aplicar los principios de finalidad, minimización y mínimo privilegio.
