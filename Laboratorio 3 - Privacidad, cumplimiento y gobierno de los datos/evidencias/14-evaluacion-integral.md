# Actividad 14 

## Objetivo

Identificar los riesgos asociados al tratamiento de datos personales dentro de la organización, relacionarlos con los principios de privacidad afectados y proponer controles que permitan reducir el impacto de posibles incidentes de seguridad.

## Procedimiento

Se analizó el escenario proporcionado identificando los procesos que involucran información personal. Posteriormente se evaluó cada situación para determinar los principios afectados, los riesgos asociados y las medidas de control recomendadas para mitigarlos.



## Resultado

| Problema | Principio afectado | Riesgo | Control propuesto |
|-----------|-------------------|---------|------------------|
| Los analistas pueden consultar directamente la tabla clientes | Mínimo privilegio | Exposición innecesaria de datos personales | Crear vistas con información anonimizada para análisis |
| Los analistas tienen acceso a nombre, correo, teléfono y RFC | Minimización de datos | Acceso a información que no es necesaria para generar estadísticas | Limitar el acceso únicamente a datos agregados |
| El área de analítica genera únicamente estadísticas mensuales | Limitación de finalidad | Uso excesivo de datos personales para tareas estadísticas | Utilizar conjuntos de datos anonimizados |
| Los datos de clientes se conservan durante 12 años | Limitación de conservación | Incremento del impacto ante una brecha de seguridad | Establecer periodos de retención definidos |
| No existe una política documentada de retención | Responsabilidad | Conservación indefinida de información | Documentar políticas de retención y eliminación |
| Los desarrolladores reciben copias completas de la base de datos | Separación de funciones | Acceso no necesario a datos personales reales | Utilizar bases de datos anonimizadas para desarrollo |
| Las copias de desarrollo contienen información real | Privacidad desde el diseño | Fuga de información en ambientes no productivos | Aplicar anonimización o datos sintéticos |
| Marketing utiliza correos electrónicos para campañas promocionales | Limitación de finalidad | Uso de datos para fines no claramente documentados | Definir y documentar la finalidad de uso |
| No existe documentación sobre la finalidad de cada dato | Transparencia | Tratamiento incorrecto de información personal | Mantener un inventario y clasificación de datos |
| Nombre, correo, teléfono y RFC se encuentran expuestos en una sola tabla | Confidencialidad | Robo de identidad y filtración de información sensible | Aplicar control de acceso, cifrado y segmentación de datos |

## Análisis

El escenario presenta múltiples riesgos relacionados con la privacidad y protección de datos. El acceso directo de los analistas a información personal completa contradice el principio de mínimo privilegio, ya que únicamente requieren generar estadísticas mensuales.

La utilización de datos reales en ambientes de desarrollo incrementa significativamente la superficie de exposición y puede provocar filtraciones de información fuera del entorno productivo. Asimismo, la ausencia de una política de retención provoca que la organización conserve información por periodos excesivos, aumentando las consecuencias de un incidente de seguridad.

## Conclusión

Se identificaron diez problemas que afectan la privacidad, seguridad y gobierno de los datos personales de los clientes. Los principales riesgos están relacionados con accesos excesivos, conservación prolongada de información, utilización de datos reales en ambientes de desarrollo y ausencia de controles sobre la finalidad de uso de los datos.
