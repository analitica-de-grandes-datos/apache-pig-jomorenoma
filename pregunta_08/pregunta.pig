/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Tabla = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
        col1:chararray,
        col2:BAG{dict:TUPLE(letter:chararray)},
        col3:MAP[]
    );
filtrado = FOREACH Tabla GENERATE FLATTEN(col2), FLATTEN(col3);
agrupado = GROUP filtrado by ($0,$1);
salida = FOREACH agrupado GENERATE group, COUNT($1);

STORE salida INTO 'output' USING PigStorage(',');

