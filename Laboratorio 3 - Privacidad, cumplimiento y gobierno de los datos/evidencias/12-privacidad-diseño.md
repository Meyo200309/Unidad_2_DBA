# Actividad 12 

## 1. Objetivo

Analizar el diseño de una tabla de clientes propuesta por un desarrollador, cuya justificación es guardar todos los datos "por si posteriormente se necesita alguno", e identificar cómo aplicar la privacidad desde el diseño y por defecto.

## 2. Procedimiento

1. Se revisó la estructura de la tabla `clientes` propuesta (con campos como `rfc`, `direccion`, `fecha_nacimiento`, `ocupacion`, `salario` y `estado_civil`).
2. Se evaluó cada campo frente a los principios de privacidad, la finalidad de registrar clientes y el riesgo que implica.
3. Se respondieron las seis preguntas de la actividad.

## 3. Resultado

### Pregunta 1. ¿Qué problemas identificas?

- **Recolección excesiva:** se piden datos sin una finalidad definida, solo "por si acaso".
- **Datos innecesarios y de mayor riesgo:** `salario`, `estado_civil` y `ocupacion` no tienen relación evidente con registrar a un cliente.
- **Redundancia:** `edad` y `fecha_nacimiento` representan lo mismo; además `edad` se desactualiza con el tiempo.
- **Mayor impacto ante una filtración:** mientras más datos y más sensibles, mayor es el daño.
- **Diseño sin controles:** sin llave primaria ni restricciones, y con todos los campos como `TEXT` sin límites ni validación.
- **Dificultad para cumplir derechos y retención:** más datos implican más información que localizar, rectificar, cancelar y justificar.

### Pregunta 2. ¿Qué principio de privacidad se está ignorando?

El principio de **minimización de datos**, junto con el de **finalidad** (los datos deben recolectarse para un propósito definido) y el de **privacidad desde el diseño y por defecto**.

### Pregunta 3. ¿Qué preguntas realizarías antes de aprobar el diseño?

- ¿Para qué se registra al cliente y qué función requiere cada campo?
- ¿Qué ocurriría si no se recolecta este dato? ¿Es obligatorio u opcional?
- ¿Existe alguna obligación legal o contractual de recolectarlo?
- ¿Quién lo usará y para qué finalidad?
- ¿Existe una alternativa menos invasiva (por ejemplo, un rango de edad en lugar de la fecha de nacimiento)?
- ¿Cuánto tiempo se conservará y qué se hará al terminar?
- ¿Está informado en el aviso de privacidad y se requiere consentimiento?
- ¿Cómo se protegerá, quién tendrá acceso y se compartirá con terceros?

### Pregunta 4. ¿Qué datos eliminarías?

- `salario`, `estado_civil` y `ocupacion`: no tienen finalidad en el registro de clientes.
- `edad`: es redundante y se desactualiza; se puede derivar de la fecha de nacimiento o reemplazar por un rango.
- `fecha_nacimiento`: se elimina si solo se usa para estadísticas o para saber la edad aproximada.
- Los campos adicionales indicados con `...`, hasta que tengan una finalidad definida.

### Pregunta 5. ¿Qué datos requerirían una justificación adicional?

- `rfc`: solo si se emite factura.
- `direccion`, `ciudad` y `codigo_postal`: solo si hay envíos o facturación.
- `fecha_nacimiento` o `edad`: si el servicio exige validar la mayoría de edad (bastaría un indicador de "mayor de edad").
- `telefono`: opcional; justificar si es un canal necesario.
- Cualquier dato como `salario`, `estado_civil` u `ocupacion` solo se conservaría si existe una finalidad y un fundamento claros.

Los datos que no requieren mayor justificación son los indispensables para registrar y contactar al cliente: `id`, `nombre` y `correo`.

### Pregunta 6. ¿Cómo aplicarías privacidad por defecto?

- Recolectar **solo los campos mínimos obligatorios** y dejar los demás como opcionales o no solicitarlos.
- Dejar las finalidades secundarias (como promociones) **desactivadas por defecto**, sin casillas premarcadas.
- **Negar el acceso por defecto** y otorgarlo solo por rol y finalidad, sin acceso a la tabla base para quien no lo necesite (mínimo privilegio).
- Entregar a cada área **vistas** con solo los datos que necesita, generalizados cuando sea posible (por ejemplo, rangos de edad).
- Definir desde el inicio el **periodo de retención** y la acción al finalizar.
- Usar **restricciones y tipos adecuados** (llave primaria, `NOT NULL`, longitudes definidas) y proteger los datos más sensibles, como el RFC, con controles adicionales.

## 4. Análisis

La propuesta del desarrollador invierte el criterio correcto: en lugar de justificar cada dato que se recolecta, justifica recolectarlos todos mientras nadie demuestre que no son necesarios. Esto aumenta el riesgo sin un beneficio definido y contradice la minimización y la finalidad. Cuando la privacidad se considera desde el diseño, cada campo debe tener una razón de existir, y la configuración por defecto debe ser la que menos datos recolecta y menos accesos concede.

## 5. Conclusión

Guardar datos "por si acaso" no es un criterio válido de diseño. La privacidad por diseño exige decidir, antes de crear la tabla, qué datos son necesarios, para qué, quién accede a ellos y por cuánto tiempo; y la privacidad por defecto exige que la configuración inicial sea la más protectora. Un diseño mínimo, justificado y con acceso restringido reduce riesgos y facilita cumplir con los derechos de los titulares.
