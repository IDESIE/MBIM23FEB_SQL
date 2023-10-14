select TO_CHAR(TO_DATE('11/02/2027 16:06:06', 'DD-MM-YYYY HH24:MI:SS'), 
                'Day DD "de" month "de" YYYY. HH24:MI:SS') "Fecha actual"
from dual;

select TO_CHAR(installatedon, 'Day')
from components
where facilityid=1;

select count(spaceid) "ConEspacio",
        count(*)"Componentes"
from components
where facilityid=1;

select count(spaceid) "ConEspacio",
        count(*)"Componentes"
from components;

select count(*) "Componentes",
        count(warrantystarton) "ConFechaGarantía",
        count(spaceid) "ConEspacio",
        count(DISTINCT spaceid)
from components
where facilityid=1;

select spaces.name
from spaces
    join floors on spaces.floorid = floors.id
where floors.facilityid=1
and spaces.name like 'Aula%';

select DISTINCT SUBSTR(spaces.name,1,4)
from spaces
    join floors on spaces.floorid = floors.id
where floors.facilityid=1
order by SUBSTR(spaces.name,1,4) ASC;

select count(*)
from components;


/*Si las fechas incluyen un formato de milisegundos y nanosegundos (por ejemplo, '02:00:00,000000000 AM'). 
Oracle no puede reconocer este formato de manera estándar. Por eso usamos SUBSTR*/

select
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY-MM-DD') "Fecha",
        count(*)"Componentes"
from components
where facilityid=1
group by installatedon
order by installatedon desc;

select
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY') "Año",
        count (*)"Componentes"
from components
where facilityid=1
group by TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY')
order by TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY') desc;

select SUBSTR(name,1,4) "Nombre",
        count(*)
from spaces
where floorid=1
group by SUBSTR(name,1,4)
order by SUBSTR(spaces.name,1,4) ASC;

select concat(concat(concat(concat(floorid,'-'),id),'-'),name) "Resultado"
from spaces;
/*En esta consulta:

Utilizamos LPAD(id, 3, '0') para formatear el id de la siguiente manera:
id: es el valor que deseas formatear.
3: es la longitud deseada (en este caso, 3 caracteres).
'0': es el carácter de relleno (cero) que se agregará a la izquierda si es necesario.*/

select concat(concat(concat(concat(floorid,'-'),LPAD(id,3,'0')),'-'),name) "Resultado"
from spaces;
