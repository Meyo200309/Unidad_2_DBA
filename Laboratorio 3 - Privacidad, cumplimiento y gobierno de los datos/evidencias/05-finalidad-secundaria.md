# Evidencia de Act.5,6,7

## 1. Objetivo

1. Analizar si una organización puede reutilizar los datos de sus clientes para una nueva finalidad(promociones personalizadas) y qué controles técnicos limitan la información entregada.
3. Identificar las implicaciones técnicas que tiene para un DBA una solicitud de **acceso** a datos personales.
4. Ejecutar y verificar una **rectificación** de datos, e identificar la importancia de la autorización y la trazabilidad del cambio.


## 2. Procedimiento

### Actividad 5 — Analizar una finalidad secundaria

```sql
ALTER TABLE clientes
    ADD COLUMN acepta_marketing BOOLEAN NOT NULL DEFAULT FALSE;

-- Rol y vista para marketing
CREATE ROLE marketing NOLOGIN;

CREATE VIEW v_marketing_clientes AS
SELECT
    id,
    correo,
    ciudad,
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad
FROM clientes
WHERE acepta_marketing = TRUE;

GRANT USAGE ON SCHEMA public TO marketing;
GRANT SELECT ON v_marketing_clientes TO marketing;
-- NO se ejecuta: GRANT SELECT ON clientes TO marketing;
```

### Actividad 6 — Derechos ARCO y la base de datos (derecho de acceso)

--consulta que localiza la información de un titular
```sql
SELECT
    id,
    nombre,
    correo,
    telefono,
    rfc,
    edad,
    ciudad,
    codigo_postal,
    fecha_alta
FROM clientes
WHERE correo = 'ana@example.com';
```
--el titular puede tener datos en otros lugares y se propuso buscar también en las copias derivadas:
```sql
-- Copia creada en la Actividad 2
SELECT id, nombre, correo, telefono
FROM clientes_soporte
WHERE correo = 'ana@example.com';
```

### Actividad 7 — Derecho de rectificación

```sql
-- Rectificar únicamente el dato solicitado
UPDATE clientes
SET correo = 'nuevo-correo@example.com'
WHERE id = 1;

-- Verificar
SELECT id, nombre, correo
FROM clientes
WHERE id = 1;
```

--Controles complementarios propuestos 
```sql
-- Bitácora de cambios
CREATE TABLE auditoria_clientes (
    id_auditoria  BIGSERIAL PRIMARY KEY,
    cliente_id    BIGINT NOT NULL,
    campo         VARCHAR(50) NOT NULL,
    valor_anterior TEXT,
    valor_nuevo   TEXT,
    usuario_bd    TEXT NOT NULL DEFAULT current_user,
    fecha_cambio  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_auditar_correo()
RETURNS trigger AS $$
BEGIN
    IF NEW.correo IS DISTINCT FROM OLD.correo THEN
        INSERT INTO auditoria_clientes (cliente_id, campo, valor_anterior, valor_nuevo)
        VALUES (OLD.id, 'correo', OLD.correo, NEW.correo);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_correo
AFTER UPDATE ON clientes
FOR EACH ROW EXECUTE FUNCTION fn_auditar_correo();

-- Mantener consistente la copia de soporte
UPDATE clientes_soporte
SET correo = 'nuevo-correo@example.com'
WHERE id = 1;
```


## 3. Resultado

### 3.1 Actividad 5 — Respuestas

**1. ¿El hecho de que la organización ya tenga los datos significa automáticamente que puede utilizarlos para cualquier finalidad?**
No. Los datos se recolectan para finalidades concretas que se informan al titular (aviso de privacidad). Usarlos para una finalidad nueva y distinta, como marketing personalizado, no está automáticamente permitido: hay que evaluar si es compatible con la finalidad original, si está informada en el aviso de privacidad y si requiere el consentimiento del titular. Aplica el principio de **limitación de la finalidad**.

**2. ¿Qué preguntas debería realizar la organización antes de implementar este tratamiento?**
- ¿Esta finalidad está en el aviso de privacidad?
- ¿Qué datos son estrictamente necesarios?
- ¿Se hará perfilamiento o decisiones automatizadas?
- ¿Quién tendrá acceso, durante cuánto tiempo y con qué controles?
- ¿Es necesaria una evaluación de riesgos o de impacto antes de iniciar?

**3. ¿Qué datos serían realmente necesarios?**
-id 
-correo 
-rango de edad 
-ciudad 
-nombre 


**4. ¿Necesitaría el área de marketing acceso directo a clientes?**
No. Tendría acceso a una vista (`v_marketing_clientes`) con solo los campos necesarios y únicamente de los clientes que aceptaron promociones. 

**5. ¿Qué controles técnicos podrían limitar la información entregada?**
- Vistas con solo las columnas necesarias y generalización de datos (rangos de edad).
- Roles específicos marketing con mínimo privilegio y sin acceso a la tabla base.
- Seudonimización del identificador para quien ejecuta la campaña.
- Seguridad a nivel de fila (RLS) y permisos por columna cuando aplique.
- Auditoría de consultas y extracciones, y restricción de exportaciones.
- Definición de plazos de conservación para las listas generadas.

### 3.2 Actividad 6 — Respuesta

**Pregunta: ¿qué información adicional debería proporcionar la organización además del resultado de la consulta?**
- Las finalidades para las que se tratan sus datos.
- El origen de los datos.
- Las categorías de datos tratados.
- A quién se comunican o transfieren los datos (encargados, proveedores, otras áreas, terceros).
- El plazo de conservación.
- Los derechos que puede ejercer (rectificación, cancelación, oposición) y cómo hacerlo.
- Una referencia al aviso de privacidad vigente.

### 3.3 Actividad 7 — Resultado

Tras el `UPDATE`, la consulta de verificación devuelve la fila con `id = 1` y el nuevo correo. Si se aplicó la bitácora, 
`SELECT * FROM auditoria_clientes;` muestra el valor anterior, el nuevo, el usuario y la fecha.

**1. ¿Cómo podría comprobarse que el cambio fue autorizado?**
- Verificando la identidad del titular antes del cambio.
- Con una solicitud documentada (folio o ticket) vinculada al cambio.
- Con la aprobación del área responsable de privacidad o atención.
- Con permisos de `UPDATE` otorgados solo a roles autorizados, y con la bitácora que muestra quién ejecutó el cambio.

**2. ¿Debería registrarse quién realizó el cambio?**
Sí: usuario, fecha y hora, dato modificado, valor anterior y valor nuevo, y el folio de la solicitud.

**3. ¿Por qué la trazabilidad será importante?**
- Permite demostrar que la rectificación se hizo a solicitud del titular y por personal autorizado (rendición de cuentas).
- Un cambio de correo puede ser un vector de fraude o toma de cuenta, la bitácora permite investigarlo.
- Facilita auditorías y detectar cambios indebidos o errores.
- Permite revertir el cambio si fue incorrecto.
- Ayuda a identificar las copias (`clientes_soporte`) que deben actualizarse y a quién se debe notificar.

## 4. Análisis

- **Finalidad secundaria:** tener los datos no equivale a poder usarlos para todo. La promoción personalizada es una finalidad distinta a la atención o la facturación, por lo que requiere evaluar compatibilidad, información al titular y, normalmente, consentimiento con posibilidad de oposición. Técnicamente, el DBA aplica los mismos principios de las actividades anteriores: minimización, vistas y mínimo privilegio. Un punto de atención es que el perfilamiento por edad y comportamiento puede ser más intrusivo que los datos por separado.
- **Derecho de acceso:** una consulta no basta. Para responder correctamente hay que localizar al titular en todos los sistemas, verificar su identidad y entregar, además de los datos, el contexto del tratamiento (finalidades, origen, destinatarios y conservación). Las copias como `clientes_soporte` aumentan el trabajo de localización, lo que confirma el valor de **minimizar copias**.
- **Rectificación:** el `UPDATE` es sencillo, pero lo importante es lo que lo rodea: autorización, registro y consistencia. Al corregir `clientes`, la copia `clientes_soporte` seguiría con el correo anterior, lo que generaría datos inexactos, contrario al principio de **calidad de los datos**. Además, la bitácora guarda correos anterior y nuevo, que también son datos personales, por lo que debe tener acceso restringido y plazo de conservación.
  
## 5. Conclusión

Un DBA no resuelve la parte jurídica de la privacidad, pero sí implementa sus consecuencias técnicas. 
ía facilita cumplir los derechos de las personas cuando estos se ejercen.
