/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

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

filtrado = FOREACH Tabla GENERATE col2;
letras = FOREACH filtrado GENERATE FLATTEN(col2) AS letra;
agrupado = GROUP letras BY letra;
salida = FOREACH agrupado GENERATE group, COUNT(letras);

STORE salida INTO 'output' USING PigStorage(',');
