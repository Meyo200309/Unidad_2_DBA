# Actividad 10 

## Objetivo

Definir una política básica para la gestión segura de claves criptográficas dentro de una organización.

## Comando o procedimiento

Analizar los riesgos asociados al manejo de claves criptográficas y redactar reglas que consideren su generación, almacenamiento, acceso, rotación, respaldo, revocación y eliminación.

### Política de gestión de claves criptográficas

1. Las claves criptográficas deben generarse utilizando mecanismos seguros que garanticen suficiente aleatoriedad.
2. Las claves no deben almacenarse en el código fuente, scripts SQL ni repositorios de control de versiones.
3. El acceso a las claves debe estar restringido únicamente a usuarios y servicios autorizados.
4. Las claves deben rotarse periódicamente o inmediatamente después de sospechar una posible filtración.
5. Los respaldos de las claves deben almacenarse cifrados y en una ubicación segura diferente a la de los datos protegidos.
6. Si una clave se expone accidentalmente, debe revocarse de inmediato y reemplazarse por una nueva.
7. Las claves que ya no sean necesarias deben eliminarse de forma segura para impedir su recuperación o reutilización.

## Análisis

Las claves criptográficas son uno de los elementos más sensibles de un sistema de seguridad. Aunque los datos estén cifrados correctamente, una clave expuesta puede comprometer toda la protección implementada. Por ello es necesario establecer reglas que controlen su ciclo de vida completo.

## Conclusión

Una gestión adecuada de claves criptográficas reduce significativamente el riesgo de accesos no autorizados y fortalece la protección de la información sensible de una organización.

