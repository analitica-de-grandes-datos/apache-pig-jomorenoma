/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color 
   FROM 
       u 
   WHERE 
       color REGEXP '[aeiou]$';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
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

filtrado = FILTER Tabla BY Color matches '.*[aeiou]$';
salida = FOREACH filtrado generate Nombre,Color;

STORE salida INTO 'output' USING PigStorage(',');
