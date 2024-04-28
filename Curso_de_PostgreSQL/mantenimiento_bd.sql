Vacuum: La más importante, con tres opciones, Vacuum, Freeze y Analyze.
Full: la tabla quedará limpia en su totalidad
Freeze: durante el proceso la tabla se congela y no permite modificaciones hasta que no termina la limpieza
Analyze: solo revisa la tabla

Analyze: No hace cambios en la tabla. Solo hace una revisión y la muestra.

Reindex: Aplica para tablas con numerosos registros con indices, como por ejemplo las llaves primarias.

Cluster: Especificamos al motor de base de datos que reorganice la información en el disco.

Postgres maneja una serie de funciones que trabajan en segundo plano mientras que trabajamos directamente en la base de datos, y esto es a lo que le llamamos mantenimiento.
El nombre más común de esto es Vaccum, ya que esto quita todas las filas y columnas e items del disco duro que no están funcionando, ya que postgres al percatarse de esto, las marca como “para borrar después”.
Tiene 2 niveles de limpieza.
Liviano, se ejecuta todo el tiempo en la DB en segundo plano.
Full o completo, que es capaz de bloquear las tablas para hacer la limpieza y luego la desbloquea.
Full es importante porque puede que una tabla tenga problemas de indexación y se demore mucho en hacer las consultas.
Hacer mantenimiento en DB no es lo mismo que hacerlo directamente en las tablas.
Para ejecutar el mantenimiento se da clic derecho sobre la DB o la tabla, y luego a la opción “Maintenance”.
En tablas, aparecen 3 opciones
full: Revisa toda la información de la tabla, si hay información que no es aplicable limpiará/eliminará la fila con la información del índice y demás. Activar o desactivar full puede tumbar totalmente la DB.
freeze: durante el proceso se va a congelar. Ningún usuario va a tener acceso a esta tabla hasta que no termine el proceso de limpieza.
analyze: El más suave, el programa ejecutará una revisión y mostrará qué tan bien o mal está la tabla.
Es importante siempre hacer el mantenimiento en el horario en donde menos es utilizada la DB, ¿por qué? porque si hay menos tráfico los usuarios no van a sentir tanto la ausencia del servicio. Igualmente, 
en la medida de las posibilidades se puede usar una DB de respaldo para que el servicio no se vea ofuscado durante el mantenimiento, luego, una vez hecho el mantenimiento se puede actualizar la DB con los datos 
generados en la DB de respaldo.