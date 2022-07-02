/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Tabla = LOAD './data.tsv' USING PigStorage('\t')
AS (
    letra:chararray,
    fecha:chararray,
    Cantidad:int
    );
Tabla_org = ORDER Tabla BY Cantidad;
limitada = LIMIT Tabla_org 5;
salida = FOREACH limitada GENERATE Cantidad;

STORE salida INTO 'output/' using PigStorage(',');
