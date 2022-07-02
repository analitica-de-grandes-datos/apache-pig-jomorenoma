/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

base = FOREACH Tabla Generate Fecha, LOWER(ToString(ToDate(Fecha),'dd')),
         GetDay(ToDate(Fecha)), ToString(ToDate(Fecha),'EEEE');

base1 = FOREACH base Generate $0,$1,$2,REPLACE($3,'Thursday','jueves');
base2 = FOREACH base1 Generate $0,$1,$2,REPLACE($3,'Sunday','domingo');
base3 = FOREACH base2 Generate $0,$1,$2, REPLACE($3,'Wednesday','miercoles');
base4 = FOREACH base3 Generate $0,$1,$2, REPLACE($3,'Friday','viernes');
base5 = FOREACH base4 Generate $0,$1,$2, REPLACE($3,'Monday','lunes');
base6 = FOREACH base5 Generate $0,$1,$2, REPLACE($3,'Tuesday','martes');

salida = FOREACH base6 Generate $0,$1,$2, SUBSTRING($3,0,3), $3;

STORE salida INTO 'output' USING PigStorage(',');
