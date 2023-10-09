------------------------------------------------------------------------------------------------
-- SELECT CON FUNCIONES
------------------------------------------------------------------------------------------------
/* 1
Mostrar la fecha actual de la siguiente forma:
Fecha actual
------------------------------
Sábado, 11 de febrero de 2027. 16:06:06

El día en palabras con la primera letra en mayúsculas, seguida de una coma, el día en números,
la palabra "de", el mes en minúscula en palabras, la palabra "de", el año en cuatro dígitos
finalizando con un punto. Luego la hora en formato 24h con minutos y segundos.
Y de etiqueta del campo "Fecha actual".
*/
select TO_CHAR(TO_DATE('11/02/2027 16:06:06', 'DD-MM-YYYY HH24:MI:SS'), 
                'Day DD "de" month "de" YYYY. HH24:MI:SS') "Feha actual"
from dual;
/* 2
Día en palabras de cuando se instalaron los componentes
del facility 1
*/
select TO_CHAR(installatedon, 'Day')
from components
where facilityid=1;
/* 3
De los espacios, obtener la suma de áreas, cuál es el mínimo, el máximo y la media de áreas
del floorid 1. Redondeado a dos dígitos.
*/
SELECT 
    ROUND(SUM(NETAREA),2),
    ROUND(MAX(NETAREA),2),
    ROUND(MIN(NETAREA),2),
    ROUND(AVG(NETAREA),2)
FROM SPACES
WHERE FLOORID=1;
/* 4
¿Cuántos componentes tienen espacio? ¿Cuántos componentes hay?
En el facility 1. Ej.
ConEspacio  Componentes
----------------------------
3500  4000
*/
select count(spaceid) "ConEspacio",
        count(*)"Componentes"
from components;
/*En facility 1*/
select count(spaceid) "ConEspacio",
        count(*)"Componentes"
from components
where facilityid=1;
/* 5
Mostrar tres medias que llamaremos:
-Media a la media del área bruta
-MediaBaja la media entre el área media y el área mínima
-MediaAlta la media entre el área media y el área máxima
de los espacios del floorid 1
Solo la parte entera, sin decimales ni redondeo.
*/
SELECT 
    round(AVG(NETAREA))"Media",
    round((AVG(NETAREA)+MIN(NETAREA))/2) "MediaBaja",
    round((AVG(NETAREA)+MAX(NETAREA))/2) "MediaAlta"
FROM SPACES
WHERE FLOORID=1;
/* 6
Cuántos componentes hay, cuántos tienen fecha inicio de garantia, cuántos tienen espacio, y en cuántos espacios hay componentes
en el facility 1.
*/
select count(*) "Componentes",
        count(warrantystarton) "ConFechaGarantía",
        count(spaceid) "ConEspacio",
        count(DISTINCT spaceid)
from components
where facilityid=1;
/* 7
Mostrar cuántos espacios tienen el texto 'Aula' en el nombre
del facility 1.
*/
select spaces.name
from spaces
    join floors on spaces.floorid = floors.id
where floors.facilityid=1
and spaces.name like 'Aula%'
/* 8
Mostrar el porcentaje de componentes que tienen fecha de inicio de garantía
del facility 1.
*/
SELECT 
    ROUND((COUNT(WARRANTYSTARTON)*100)/COUNT(*),2)
FROM COMPONENTS
WHERE FACILITYID=1;
/* 9
Listar las cuatro primeras letras del nombre de los espacios sin repetir
del facility 1. 
En orden ascendente.
Ejemplo:
Aula
Area
Aseo
Pasi
Pati
Serv
*/
select DISTINCT SUBSTR(spaces.name,1,4)
from spaces
    join floors on spaces.floorid = floors.id
where floors.facilityid=1
order by SUBSTR(spaces.name,1,4) ASC;
/* 10
Número de componentes por fecha de instalación del facility 1
ordenados descendentemente por la fecha de instalación
Ejemplo:
Fecha   Componentes
-------------------
2021-03-23 34
2021-03-03 232
*/
select
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY-MM-DD') "Fecha",
        count(*)"Componentes"
from components
where facilityid=1
group by installatedon
order by installatedon desc;
/* 11
Un listado por año del número de componentes instalados del facility 1
ordenados descendentemente por año.
Ejemplo
Año Componentes
---------------
2021 344
2020 2938
*/
select
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY') "Año",
        count (*)"Componentes"
from components
where facilityid=1
group by TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY')
order by TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY') desc;
/* 12
Nombre del día de instalación y número de componentes del facility 1.
ordenado de lunes a domingo
Ejemplo:
Día         Componentes
-----------------------
Lunes    	503
Martes   	471
Miércoles	478
Jueves   	478
Viernes  	468
Sábado   	404
Domingo  	431
*/
SELECT 
    TO_CHAR(installatedon,'Day'),
    Count(installatedon)
FROM COMPONENTS
WHERE FACILITYID=1
Group By TO_CHAR(installatedon,'Day'), TO_CHAR(installatedon,'d')
ORDER BY TO_CHAR(installatedon,'d');
/*13
Mostrar en base a los cuatro primeros caracteres del nombre cuántos espacios hay
del floorid 1 ordenados ascendentemente por el nombre.
Ejemplo.
Aula 23
Aseo 12
Pasi 4
*/
select SUBSTR(name,1,4) "Nombre",
        count(*)
from spaces
where floorid=1
group by SUBSTR(name,1,4)
order by SUBSTR(spaces.name,1,4) ASC;
/*14
Cuántos componentes de instalaron un Jueves
en el facilityid 1
*/

/*15
Listar el id de planta concatenado con un guión
seguido del id de espacio concatenado con un guión
y seguido del nombre del espacio.
el id del espacio debe tener una longitud de 3 caracteres
Ej. 3-004-Nombre
*/
 
------------------------------------------------------------------------------------------------
