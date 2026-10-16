# Laboratorio 1 - Protección y privacidad de datos

# Preguntas de Reflexión

### 1. ¿Cuál es la diferencia entre enmascaramiento y seudonimización?

El enmascaramiento oculta parcialmente los datos sensibles para limitar su visualización, mientras que la seudonimización reemplaza los identificadores reales por valores alternativos o tokens. El enmascaramiento permite seguir viendo parte del dato original, mientras que la seudonimización sustituye completamente la identidad visible.

### 2. ¿Por qué la seudonimización no significa anonimización?

Porque los datos originales pueden recuperarse mediante la tabla o mecanismo que relaciona los tokens con las identidades reales. En la anonimización, la identificación de las personas no debe ser posible, mientras que en la seudonimización existe la posibilidad de revertir el proceso bajo condiciones controladas.

### 3. ¿Por qué eliminar `nombre` y `RFC` no garantiza que un conjunto de datos sea anónimo?

Porque pueden existir otros atributos que permitan identificar indirectamente a una persona. Datos como la edad, ciudad, código postal o fecha de alta pueden combinarse para reducir el anonimato y facilitar la reidentificación.

### 4. ¿Qué función tienen los cuasi-identificadores?

Los cuasi-identificadores son atributos que por sí solos no identifican directamente a una persona, pero que al combinarse con otros datos pueden utilizarse para identificarla o reducir significativamente su anonimato.

### 5. ¿Por qué es importante separar el mapa de seudonimización?

Porque el mapa contiene la relación entre los tokens y las identidades reales. Mantenerlo separado y con acceso restringido reduce el riesgo de que los datos seudonimizados puedan asociarse nuevamente con las personas a las que pertenecen.

### 6. ¿Qué principio de seguridad se aplica al impedir que el analista acceda al mapa?

Se aplica el principio de mínimo privilegio, el cual establece que cada usuario debe tener únicamente los permisos necesarios para realizar sus funciones y no más de los estrictamente requeridos.

### 7. ¿Por qué una vista puede ser preferible a entregar acceso directo a la tabla?

Porque una vista permite mostrar únicamente la información necesaria para cada usuario, ocultando o transformando los datos sensibles sin exponer directamente la estructura y el contenido completo de la tabla original.

### 8. ¿Qué diferencia existe entre proteger un dato para visualización y protegerlo contra acceso no autorizado?

Proteger un dato para visualización implica limitar o modificar la información que el usuario observa, por ejemplo mediante enmascaramiento. Protegerlo contra acceso no autorizado implica controlar quién puede acceder a los datos mediante permisos, roles y mecanismos de autenticación.

### 9. ¿Por qué la retención forma parte de la protección de datos?

Porque permite conservar la información únicamente durante el tiempo necesario para cumplir con fines operativos, legales o regulatorios. Al eliminar datos que ya no son necesarios, se reduce la superficie de exposición y el riesgo de incidentes de seguridad.

### 10. ¿Qué riesgo existe si una organización conserva información indefinidamente?

El principal riesgo es el aumento de la exposición de datos personales ante accesos no autorizados, fugas de información o incidentes de seguridad. Además, conservar información innecesaria puede generar incumplimientos normativos y mayores costos de almacenamiento y gestión.

