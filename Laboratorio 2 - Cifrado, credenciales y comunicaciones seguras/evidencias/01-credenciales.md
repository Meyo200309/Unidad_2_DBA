# Actividad 1 - Protección de credenciales

## Objetivo

Comprender los riesgos de almacenar contraseñas en texto claro y aplicar mecanismos seguros para proteger las credenciales de los usuarios.

## Comando o procedimiento

### Crear tabla insegura

```sql
CREATE TABLE usuarios_insegura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);
```

### Insertar usuario de prueba

```sql
INSERT INTO usuarios_insegura (usuario, password)
VALUES ('juan', 'Password123');
```

### Consultar información almacenada

```sql
SELECT *
FROM usuarios_insegura;
```

### Generar una representación no reversible

```sql
SELECT crypt(
    'Password123',
    gen_salt('bf')
);
```

Ejecutar nuevamente:

```sql
SELECT crypt(
    'Password123',
    gen_salt('bf')
);
```

### Crear tabla segura

```sql
CREATE TABLE usuarios_segura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);
```

### Insertar usuario protegido

```sql
INSERT INTO usuarios_segura (usuario, password_hash)
VALUES (
    'juan',
    crypt('Password123', gen_salt('bf'))
);
```

### Consultar la tabla segura

```sql
SELECT *
FROM usuarios_segura;
```

### Verificar contraseña correcta

```sql
SELECT
    usuario,
    password_hash = crypt('Password123', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';
```

### Verificar contraseña incorrecta

```sql
SELECT
    usuario,
    password_hash = crypt('OtraPassword', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';
```

## Resultado obtenido

### ¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?

Si una persona obtiene acceso de lectura a la tabla, podrá visualizar directamente las contraseñas almacenadas y utilizarlas para acceder a las cuentas de los usuarios.

### ¿Son iguales?

No, los resultados obtenidos al ejecutar `crypt()` dos veces son diferentes.

### ¿Si no son iguales, por qué?

Porque en cada ejecución se genera una sal (*salt*) diferente, produciendo un hash distinto aunque la contraseña sea la misma.

### ¿Qué función cumple `gen_salt()`?

Genera una sal aleatoria que se incorpora al proceso de generación del hash para aumentar la seguridad.

### ¿Qué función cumple `crypt()`?

Genera el hash de la contraseña utilizando la sal especificada.

### ¿Esto es cifrado reversible?

No. El hash es un proceso unidireccional que no permite recuperar la contraseña original.

### ¿Qué resultado obtuviste con la contraseña correcta?

El resultado fue `true`, indicando que la contraseña coincide con el hash almacenado.

### ¿Qué resultado obtuviste con la contraseña incorrecta?

El resultado fue `false`, indicando que la contraseña no coincide con el hash almacenado.

### ¿Por qué no es necesario recuperar la contraseña original?

Porque únicamente es necesario verificar que la contraseña ingresada genere el mismo resultado que el hash almacenado.

### ¿Por qué un hash no debe confundirse con cifrado?

Porque un hash no permite recuperar el dato original, mientras que el cifrado sí permite recuperar la información mediante una clave.

## Análisis

La actividad demuestra que almacenar contraseñas en texto claro representa un riesgo importante para la seguridad. Cualquier persona con acceso a la base de datos podría conocer las credenciales de los usuarios. El uso de `crypt()` junto con `gen_salt()` permite generar hashes seguros y diferentes para una misma contraseña, reduciendo el impacto de una posible filtración. Además, la verificación de credenciales puede realizarse sin necesidad de almacenar ni recuperar la contraseña original.

## Conclusión

Las contraseñas nunca deben almacenarse en texto claro. La utilización de funciones como `crypt()` y `gen_salt()` permite proteger adecuadamente las credenciales de los usuarios, mejorando la seguridad del sistema y disminuyendo el riesgo asociado a accesos no autorizados o filtraciones de información.
    password VARCHAR(100) NOT NULL
);
