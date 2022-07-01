/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

filtrado = FOREACH Tabla GENERATE col3;
letras = FOREACH filtrado GENERATE FLATTEN(col3) AS letra;
Agrupado = GROUP letras BY $0;
salida = FOREACH Agrupado GENERATE group, COUNT($1);

STORE salida INTO 'output' USING PigStorage(',');
