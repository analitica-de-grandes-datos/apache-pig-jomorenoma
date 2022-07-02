/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

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

Cont = FOREACH Tabla GENERATE col1, COUNT(col2) as cont2, SIZE(col3) as cont3;
salida = ORDER Cont BY col1, cont2, cont3;

STORE salida INTO 'output' USING PigStorage(',');
