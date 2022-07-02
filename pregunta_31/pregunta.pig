/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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

base = FOREACH Tabla Generate Nombre, GetYear(ToDate(Fecha)) as year;
agrupado = GROUP base by year;
salida = FOREACH agrupado Generate group, COUNT($1);

STORE salida INTO 'output' USING PigStorage(',');
