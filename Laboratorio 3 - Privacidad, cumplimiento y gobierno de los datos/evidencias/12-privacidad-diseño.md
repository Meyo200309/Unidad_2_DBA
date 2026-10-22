# Actividad 12 

## 1. Objetivo

Analizar el diseño de una tabla de clientes propuesta por un desarrollador, cuya justificación es guardar todos los datos "por si posteriormente se necesita alguno", e identificar cómo aplicar la privacidad desde el diseño y por defecto.

## 2. Procedimiento

1. Se revisó la estructura de la tabla clientes propuesta (con campos como rfc, direccion, fecha_nacimiento, ocupacion, salario y estado_civil).
2. Se evaluó cada campo frente a los principios de privacidad, la finalidad de registrar clientes y el riesgo que implica.

## 3. Resultado

### Pregunta 1. ¿Qué problemas identificas?

- Recolección excesiva: se piden datos sin una finalidad definida, solo "por si acaso".
- Datos innecesarios y de mayor riesgo: salario, estado_civil y ocupacion no tienen relación evidente con registrar a un cliente.
- Mayor impacto ante una filtración: mientras más datos y más sensibles, mayor es el daño.
- Diseño sin controles: sin llave primaria ni restricciones y con todos los campos como `TEXT` sin límites ni validación.

### Pregunta 2. ¿Qué principio de privacidad se está ignorando?

El principio de minimización de datos junto con el de finalidad y el de privacidad desde el diseño.

### Pregunta 3. ¿Qué preguntas realizarías antes de aprobar el diseño?

- ¿Para qué se registra al cliente y qué función requiere cada campo?
- ¿Existe alguna obligación legal o contractual de recolectarlo?
- ¿Quién lo usará y para qué finalidad?
- ¿Existe una alternativa menos invasiva?
- ¿Cuánto tiempo se conservará y qué se hará al terminar?
- ¿Está informado en el aviso de privacidad y se requiere consentimiento?
- ¿Cómo se protegerá, quién tendrá acceso y se compartirá con terceros?

### Pregunta 4. ¿Qué datos eliminarías?

- salario, estado_civil y ocupacion: no tienen finalidad en el registro de clientes.
- edad: es redundante y se desactualiza.
- fecha_nacimiento: se elimina si solo se usa para estadísticas o para saber la edad aproximada.

### Pregunta 5. ¿Qué datos requerirían una justificación adicional?

- rfc: solo si se emite factura.
- direccion, ciudad y codigo_postal: solo si hay envíos o facturación.
- fecha_nacimiento: si el servicio exige validar la mayoría de edad (bastaría un indicador de "mayor de edad").
- Cualquier dato como salario, estado_civil u ocupacion solo se conservaría si existe una finalidad y un fundamento claros.

### Pregunta 6. ¿Cómo aplicarías privacidad por defecto?

- Recolectar solo los campos mínimos obligatorios y dejar los demás como opcionales o no solicitarlos.
- Negar el acceso por defecto y otorgarlo solo por rol y finalidad, sin acceso a la tabla base para quien no lo necesite.
- Definir desde el inicio el periodo de retención y la acción al finalizar.
- Usar restricciones y tipos adecuados (llave primaria, `NOT NULL`, longitudes definidas) y proteger los datos más sensibles, como el RFC, con controles adicionales.

## 4. Análisis

Esto aumenta el riesgo sin un beneficio definido y contradice la minimización y la finalidad. Cuando la privacidad se considera desde el diseño, cada campo debe tener una razón de existir, y la configuración por defecto debe ser la que menos datos recolecta y menos accesos concede.

## 5. Conclusión

Guardar datos "por si acaso" no es un criterio válido de diseño, la privacidad por diseño exige decidir, antes de crear la tabla, qué datos son necesarios, para qué, quién accede a ellos y por cuánto tiempo. La privacidad por defecto exige que la configuración inicial sea la más protectora. Un diseño mínimo, justificado y con acceso restringido reduce riesgos y facilita cumplir con los derechos de los titulares.
