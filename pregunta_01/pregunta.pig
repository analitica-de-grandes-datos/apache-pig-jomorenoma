/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Tabla = LOAD './data.tsv' USING PigStorage('\t')
AS (
    letra:chararray, 
    fecha:datetime, 
    Cantidad:int
    );
Tabla_org = GROUP Tabla BY letra;
Resp = FOREACH Tabla_org GENERATE group, COUNT(Tabla);

STORE Resp INTO 'output/' using PigStorage(',');
