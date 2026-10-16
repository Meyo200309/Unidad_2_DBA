# Actividad 3 

## Objetivo

Identificar los riesgos asociados a la exposición de claves criptográficas y comprender la importancia de una gestión segura de dichas claves.

### Crear archivo de ejemplo

Archivo: `sql/ejemplo-mala-practica.sql`

```sql
SELECT pgp_sym_decrypt(
    rfc_cifrado,
    'CLAVE-DE-PRUEBA'
)
FROM clientes_protegidos;
```

### Analizar la consulta

Se revisó el archivo para identificar la mala práctica de incluir una clave criptográfica directamente dentro del código SQL.

## Resultado obtenido

### ¿Qué ocurriría si esta clave fuera una clave utilizada realmente por una organización y el archivo se publicara en un repositorio Git?

Si la clave fuera real y el archivo se publicara en un repositorio Git, cualquier persona con acceso al repositorio podría obtener la clave y utilizarla para descifrar la información protegida. Esto comprometería la confidencialidad de los datos y podría provocar una fuga de información sensible de la organización.

## Análisis

Aunque el cifrado proteja correctamente los datos almacenados, la seguridad depende también de la protección de las claves utilizadas. Incluir claves directamente en scripts, consultas SQL o repositorios facilita su exposición accidental. Si un atacante obtiene la clave, podrá acceder a la información cifrada sin necesidad de vulnerar el algoritmo de cifrado.

## Conclusión

Las claves criptográficas nunca deben almacenarse dentro del código fuente, scripts SQL o repositorios. Deben gestionarse mediante mecanismos seguros de almacenamiento de secretos para evitar su exposición y garantizar la protección efectiva de la información cifrada.
