/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

Tabla = LOAD 'data.csv' USING PigStorage(',')
    AS (
        Id:int,
        Nombre:chararray,
        Apellido:chararray,
        Fecha:chararray,
        Color:chararray,
        Cantidad:int
    );

filtrado = FILTER Tabla BY NOT Color matches '[b].*';
salida = FOREACH filtrado generate Color;

STORE salida INTO 'output' USING PigStorage(',');
