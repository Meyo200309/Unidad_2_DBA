# Actividad 2 - Cifrado de información sensible

## Objetivo

Comprender cómo proteger información sensible mediante cifrado simétrico y analizar las diferencias entre un mecanismo de hash y un mecanismo de cifrado.

## Comando o procedimiento

### Crear tabla de demostración

```sql
CREATE TABLE clientes_protegidos (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    rfc_cifrado BYTEA NOT NULL
);
```

### Insertar registro utilizando cifrado simétrico

```sql
INSERT INTO clientes_protegidos (
    nombre,
    rfc_cifrado
)
VALUES (
    'Ana López',
    pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
);
```

### Consultar información almacenada

```sql
SELECT *
FROM clientes_protegidos;
```

### Recuperar el dato original

```sql
SELECT
    id,
    nombre,
    pgp_sym_decrypt(
        rfc_cifrado,
        'CLAVE-DE-PRUEBA'
    ) AS rfc
FROM clientes_protegidos;
```

## Resultado obtenido

### ¿Qué diferencia existe entre `crypt()` y `pgp_sym_encrypt()`?

`crypt()` genera un hash no reversible para proteger contraseñas, mientras que `pgp_sym_encrypt()` cifra información utilizando una clave y permite recuperar posteriormente el dato original.

### ¿Cuál de los dos mecanismos permite recuperar el dato original?

`pgp_sym_encrypt()` permite recuperar el dato original mediante la función `pgp_sym_decrypt()` y la clave correcta.

### ¿Qué ocurre si se utiliza una clave incorrecta?

El dato no puede descifrarse correctamente y PostgreSQL genera un error o impide recuperar la información original.

### ¿Qué problema de seguridad representa colocar la clave directamente en una consulta?

La clave queda expuesta en el código, consultas SQL, archivos o repositorios. Si un atacante obtiene acceso a esos archivos, también podrá utilizar la clave para descifrar la información protegida.

## Análisis

La actividad muestra que el cifrado es adecuado para proteger información sensible que necesita recuperarse posteriormente, como un RFC. A diferencia de los hashes utilizados en contraseñas, el cifrado requiere una clave para descifrar la información. Por este motivo, la protección de las claves es tan importante como la protección de los datos cifrados.

## Conclusión

El cifrado simétrico permite proteger datos sensibles almacenados en la base de datos y recuperar posteriormente su contenido cuando sea necesario. Sin embargo, la seguridad depende de una adecuada gestión de las claves criptográficas, ya que una clave expuesta compromete toda la protección proporcionada por el cifrado.
