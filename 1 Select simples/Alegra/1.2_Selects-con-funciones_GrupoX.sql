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

SELECT TO_CHAR(SYSDATE, 'Day, DD "de" Month "de" YYYY. HH24:MI:SS') AS "Fecha actual" FROM dual;

/* 2
Día en palabras de cuando se instalaron los componentes
del facility 1
*/
select 
    to_char(installatedon, 'Day')
    from COMPONENTS
    WHERE FACILITYID=1;

/* 3
De los espacios, obtener la suma de áreas, cuál es el mínimo, el máximo y la media de áreas
del floorid 1. Redondeado a dos dígitos.
*/
select 
    round(avg(netarea),2),round(max(netarea),2),round(min(netarea),2), round(sum(netarea),2)
    from SPACES
    WHERE floorid=1;
/* 4
¿Cuántos componentes tienen espacio? ¿Cuántos componentes hay?
En el facility 1. Ej.
ConEspacio  Componentes
----------------------------
3500  4000
*/
select count (*), count(distinct spaceid)
from components
where spaceid is not null and facilityid= 1; 


/* 5
Mostrar tres medias que llamaremos:
-Media a la media del área bruta
-MediaBaja la media entre el área media y el área mínima
-MediaAlta la media entre el área media y el área máxima
de los espacios del floorid 1
Solo la parte entera, sin decimales ni redondeo.
*/
select 
    round((avg(netarea)+max(netarea))/2 ) "media alta",
    round((avg(netarea)+min(netarea))/2 ) "media baja", 
    round(avg(netarea)) "media"
    from SPACES
    WHERE floorid=1 ;
    /* 6
Cuántos componentes hay, cuántos tienen fecha inicio de garantia, cuántos tienen espacio, y en cuántos espacios hay componentes
en el facility 1.
*/
select count(*), count(spaceid), count(distinct spaceid), count(warrantystarton), count (distinct warrantystarton)
from components where facilityid=1;

/* 7
Mostrar cuántos espacios tienen el texto 'Aula' en el nombre
del facility 1.
*/
select name
from spaces
where
  lower(name) like '%aula%';
/* 8
Mostrar el porcentaje de componentes que tienen fecha de inicio de garantía
del facility 1.
*/

select  round((count(warrantystarton)/count(*))*100,2)
from components where facilityid=1;

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
select substr(name,1,4) as name
from spaces
order by substr(name,1,4) asc;
/* 10
Número de componentes por fecha de instalación del facility 1
ordenados descendentemente por la fecha de instalación
Ejemplo:
Fecha   Componentes
-------------------
2021-03-23 34
2021-03-03 232
*/
select count(*)as componente ,to_char( installatedon, 'dd-mm-yyyy') as fecha
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
select count(*)as componente ,to_char( installatedon, 'yyyy') as fecha
from components
where facilityid=1
group by installatedon
order by installatedon desc;

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
    
select
    count(*), to_char(installatedon, 'Day')
from components 
where facilityid=1
    group by  to_char(installatedon, 'Day'), to_char(installatedon, 'd')
    order by  to_char(installatedon, 'd');


/*13
Mostrar en base a los cuatro primeros caracteres del nombre cuántos espacios hay
del floorid 1 ordenados ascendentemente por el nombre.
Ejemplo.
Aula 23
Aseo 12
Pasi 4
*/
select count(*), substr(name,1,4) as name
from spaces
where floorid=1
    group by substr(name,1,4)
    order by substr(name,1,4) asc;


/*14
Cuántos componentes de instalaron un Jueves
en el facilityid 1
*/
select
    count(*), to_char(installatedon, 'Day' )
from components 
where facilityid=1 and lower ( to_char(installatedon, 'Day' ) )like '%jueves%'
    group by  to_char(installatedon, 'Day'), to_char(installatedon, 'd')
    order by  to_char(installatedon, 'd');
    
/*15
Listar el id de planta concatenado con un guión
seguido del id de espacio concatenado con un guión
y seguido del nombre del espacio.
el id del espacio debe tener una longitud de 3 caracteres
Ej. 3-004-Nombre
*/
SELECT CONCAT(CONCAT(CONCAT(name, ' | '), id), CONCAT(' | ', floorid)) AS "spaceName"
FROM spaces;
 
------------------------------------------------------------------------------------------------
