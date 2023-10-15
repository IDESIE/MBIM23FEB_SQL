------------------------------------------------------------------------------------------------
-- SELECT con subcolsultas y JOINS
------------------------------------------------------------------------------------------------
/*1
Listar de la tabla facilities el id y nombre, 
además de la tabla floors el id, nombre y facilityid
*/
SELECT facilities.id "facility_id", floors.name "facility_name",
       floors.id "floor_id", floors.name "floor_name", floors.facilityid "floor_facilityid"
FROM facilities
JOIN floors ON facilities.id = floors.facilityid;
/*2
Lista de id de espacios que no están en la tabla de componentes (spaceid)
pero sí están en la tabla de espacios.
*/ 
select id
from spaces
where id not in (select spaceid
                    from components 
                    where spaceid is not null);
/*3
Lista de id de tipos de componentes que no están en la tabla de componentes (typeid)
pero sí están en la tabla de component_types
*/
select id
from component_types
where id not in (select typeid
                    from components
                    where typeid is not null);
/*4
Mostrar de la tabla floors los campos: name, id;
y de la tabla spaces los campos: floorid, id, name
de los espacios 109, 100, 111
*/
select 
        floors.name "floor_name", floors.id "floor_id",
        spaces.floorid "spaces_floorid", spaces.id "spaces_id", spaces.name "spaces_name"
from floors
    join spaces on floors.id = spaces.floorid
where spaces.id in (109, 100, 111);
/*5
Mostrar de component_types los campos: material, id;
y de la tabla components los campos: typeid, id, assetidentifier
de los componentes con id 10000, 20000, 300000
*/
select component_types.material, 
        component_types.id "TypeID",
        components.typeid, 
        components.id "componentID",
        components.assetidentifier
from components 
    join component_types on components.typeid = component_types.id
where components.id in (10000, 20000, 300000);
/*6
¿Cuál es el nombre de los espacios que tienen cinco componentes?
*/
select
    spaces.name
from components
    join spaces on spaces.id = components.spaceid
group by spaceid, spaces.name
having count (*) = 5;
/*having es el where cuando se usa condiciones de grupo*/
select name
from spaces
where id in (
    select spaceid
    from components
    group by spaceid
    having count(*)=5);
/*7
¿Cuál es el id y assetidentifier de los componentes
que están en el espacio llamado CAJERO?
*/
select components.id, components.assetidentifier
from components
    join spaces on spaces.id = components.spaceid
where spaces.name = 'CAJERO';
/*8
¿Cuántos componentes
hay en el espacio llamado CAJERO?
*/
select     
    spaces.name,
    count(*)
from components
    join spaces on spaces.id = components.spaceid
where   
    UPPER(spaces.name) LIKE '%CAJERO%'
group by spaceid, spaces.name;
/*9
Mostrar de la tabla spaces: name, id;
y de la tabla components: spaceid, id, assetidentifier
de los componentes con id 10000, 20000, 30000
aunque no tengan datos de espacio.
*/
select 
    spaces.name "spaces_name", spaces.id "spaces_id",
    components.spaceid "components_spaceid", components.id "components_id", components.assetidentifier "components_assetidentifier"
from spaces
    right join components on components.spaceid = spaces.id
where components.id in (10000, 20000, 30000);
/*
10
Listar el nombre de los espacios y su área del facility 1
*/
select 
    spaces.name, spaces.netarea
from spaces 
    join floors on spaces.floorid = floors.id
where floors.facilityid=1;
/*11
¿Cuál es el número de componentes por facility?
Mostrar nombre del facility y el número de componentes.
*/
select facilities.name, count(components.id) "NúmeroComponentes"
from facilities
    left join components on components.facilityid = facilities.id
group by facilities.name;
/*12
¿Cuál es la suma de áreas de los espacios por cada facility?
Mostrar nombre del facility y la suma de las áreas 
*/
select 
    facilities.name, sum(spaces.netarea) "SumaÁreas"
from spaces 
    right join floors on spaces.floorid = floors.id
    right join facilities on floors.facilityid = facilities.id
group by facilities.name;
/*13
¿Cuántas sillas hay de cada tipo?
Mostrar el nombre del facility, el nombre del tipo
y el número de componentes de cada tipo
ordernado por facility.
*/


--Ejemplo
--Alegra	Silla-Apilable_Silla-Apilable	319
--Alegra	Silla-Brazo escritorio_Silla-Brazo escritorio	24
--Alegra	Silla (3)_Silla (3)	24
--Alegra	Silla-Corbu_Silla-Corbu	20
--Alegra	Silla-Oficina (brazos)_Silla-Oficina (brazos)	17
--COSTCO	Silla-Apilable_Silla-Apilable	169
--COSTCO	Silla_Silla	40
--COSTCO	Silla-Corbu_Silla-Corbu	14
--COSTCO	Silla-Oficina (brazos)_Silla-Oficina (brazos)	188

select 
    facilities.name "NombreFacility", 
    component_types.name "NombreTipo",
    count(components.id) "NúmeroComponentes"
from facilities
    join components on components.facilityid = facilities.id
    join component_types on components.typeid = component_types.id
group by facilities.name, component_types.name;

/*
14
Listar nombre, código de asset, número de serie, el año de instalación, nombre del espacio,
de todos los componentes
del facility 1
que estén en un aula y no sean tuberias, muros, techos, suelos.
*/
select 
    components.name, components.assetidentifier, components.serialnumber, 
    TO_CHAR(TO_DATE(SUBSTR(components.installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY') "Año de Instalación", 
    spaces.name "SpaceName"
from components
    join floors on floors.facilityid = components.facilityid
    join spaces on spaces.floorid = floors.id
where components.facilityid=1
and spaces.name like 'Aula%'
and lower(components.name) not like '%tuber%'
and lower(components.name) not like '%muro%'
and lower(components.name) not like '%techo%'
and lower(components.name) not like '%suelo%';
/*
15
Nombre, área bruta y volumen de los espacios con mayor área que la media de áreas del facility 1.
*/
select name, grossarea, volume
 from spaces
 where 
 grossarea > (select avg(grossarea)
      from floors
    join spaces on floors.id =spaces.floorid
    join facilities on facilities.id=floors.facilityid  
where 
facilities.id=1);
/*
16
Nombre y fecha de instalación (yyyy-mm-dd) de los componentes del espacio con mayor área del facility 1
*/
Select 
    components.name, 
    TO_CHAR(TO_DATE(SUBSTR(components.installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'YYYY-MM-DD') "Fecha"
from components
    join spaces on components.spaceid = spaces.id
where components.facilityid=1
and spaces.netarea = (select max(spaces.netarea)
                        from spaces
                             join components on components.spaceid = spaces.id
                        where components.facilityid=1);
/*
17
Nombre y código de activo  de los componentes cuyo tipo de componente contenga la palabra 'mesa'
del facility 1
*/
select components.name, components.assetidentifier
from components
    join component_types on components.typeid = component_types.id
where components.facilityid=1
and lower(component_types.name) like '%mesa%';
/*
18
Nombre del componente, espacio y planta de los componentes
de los espacios que sean Aula del facility 1
*/
select 
    components.name "NombreComponente", 
    spaces.name "NombreEspacio",
    floors.name "NombrePlanta"
from components
    join floors on components.facilityid = floors.facilityid
    join spaces on spaces.floorid = floors.id
where components.facilityid=1
and spaces.name like 'Aula%';
/*
19
Número de componentes y número de espacios por planta (nombre) del facility 1. 
Todas las plantas.
*/
select 
    floors.name "NombrePlanta",
    count(components.id) "NúmeroComponentes", 
    count(spaces.id) "NúmeroEspacio"
from components
    join floors on components.facilityid = floors.facilityid
    join spaces on spaces.floorid = floors.id
where components.facilityid=1
group by floors.name;
/*
20
Número de componentes por tipo de componente en cada espacio
de los componentes que sean mesas del facility 1
ordenados de forma ascendente por el espacio y descentente por el número de componentes.
Ejmplo:
Componentes    Tipo   Espacio
--------------------------------
12  Mesa-cristal-redonda    Aula 2
23  Mesa-4x-reclinable      Aula 3
1   Mesa-profesor           Aula 3
21  Mesa-cristal-redonda    Aula 12
*/
select 
    count(components.id) "Componentes", 
    component_types.name "Tipo",
    spaces.name "Espacio"
from components
    join component_types on components.typeid = component_types.id
    join spaces on components.spaceid = spaces.id
where components.facilityid=1
and lower(component_types.name) like '%mesa%'
group by component_types.name, spaces.name
order by spaces.name asc, count(components.id) desc;
/*
21
Mostrar el nombre de las Aulas y una etiqueda «Sillas» que indique
'BAJO' si el número de sillas es menor a 6
'ALTO' si el número de sillas es mayor a 15
'MEDIO' si está entre 6 y 15 inclusive
del facility 1
ordenado ascendentemente por el espacio
Ejemplo:
Espacio Sillas
--------------
Aula 1  BAJO
Aula 2  BAJO
Aula 3  MEDIO
*/
SELECT
    spaces.name "Espacio",
    CASE
        WHEN COUNT(components.id) < 6 THEN 'BAJO'
        WHEN COUNT(components.id) > 15 THEN 'ALTO'
        ELSE 'MEDIO'
    END "Sillas"
FROM spaces
    JOIN components ON spaces.id = components.spaceid
WHERE components.facilityid = 1 
    AND spaces.name like 'Aula%'
GROUP BY spaces.name
ORDER BY spaces.name ASC;
/*
22
Tomando en cuenta los cuatro primeros caracteres del nombre de los espacios
del facility 1
listar los que se repiten e indicar el número.
En orden descendente por el número de ocurrencias.
Ejemplo:
Espacio Ocurrencias
Aula    18
Aseo    4
Hall    2
*/
SELECT
    SUBSTR(spaces.name, 1, 4) "Espacio",
    COUNT(*) "Ocurrencias"
FROM spaces
    JOIN components ON spaces.id = components.spaceid
WHERE components.facilityid = 1
GROUP BY SUBSTR(spaces.name, 1, 4)
HAVING COUNT(*) > 1
ORDER BY "Ocurrencias" DESC;
/*
23
Nombre y área del espacio que mayor área bruta tiene del facility 1.
*/
select spaces.name, spaces.netarea
from spaces
where spaces.netarea =  (select max(spaces.netarea)
                        from spaces
                             join components on components.spaceid = spaces.id
                        where components.facilityid=1);
/*
24
Número de componentes instalados entre el 1 de mayo de 2010 y 31 de agosto de 2010
y que sean grifos, lavabos del facility 1
*/
select count(*) "NúmeroComponentes"
from components
where facilityid=1
and (lower(name) like'%grifo%' or lower(name) like '%lavabo%');
and to_date(SUBSTR(installedon, 1, 10), 'DD/MM/RR')
    BETWEEN TO_DATE('01/05/2010', 'DD/MM/YYYY') AND TO_DATE('31/08/2010', 'DD/MM/YYYY');
/*
25
Un listado en el que se indique en líneas separadas
una etiqueta que describa el valor, y el valor:
el número de componentes en Aula 03 del facility 1, 
el número de sillas en Aula 03 del facility 1
el número de mesas o escritorios en Aula 03 del facility 1
Ejemplo:
Componentes 70
Sillas 16
Mesas 3
*/
SELECT
    'Componentes' "Etiqueta",
    COUNT(*) "Valor"
FROM components
    join spaces on spaces.id = components.spaceid
WHERE components.facilityid = 1
AND spaces.name = 'Aula 03'
UNION ALL
SELECT
    'Sillas' "Etiqueta",
    COUNT(*) "Valor"
FROM components
    join spaces on spaces.id = components.spaceid
WHERE components.facilityid = 1
AND spaces.name = 'Aula 03'
AND LOWER(components.name) like '%silla%'
UNION ALL
SELECT
    'Mesas' "Etiqueta",
    COUNT(*) "Valor"
FROM components
    join spaces on spaces.id = components.spaceid
WHERE components.facilityid = 1
AND spaces.name = 'Aula 03'
AND (LOWER(components.name) like '%mesa%' or LOWER(components.name) like '%escritorio%');
/*
26
Nombre del espacio, y número de grifos del espacio con más grifos del facility 1.
*/
select 
    spaces.name "Nombre del Espacio", 
    count(components.id) "Número de grifos"
from spaces
    join components on spaces.id = components.spaceid
where components.facilityid=1
and lower(components.name) like '%grifo%'
group by spaces.name
having count(components.id) = (select max("Número de componentes") from
                                    (select
                                        spaces.name,
                                        count(components.id)"Número de componentes"
                                    from spaces
                                        join components on spaces.id = components.spaceid
                                    where components.facilityid=1
                                    and lower(components.name) like '%grifo%'
                                    group by spaces.name
                                    ));
/*
27
Cuál es el mes en el que más componentes se instalaron del facility 1.
*/
SELECT
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Month') "Mes"
FROM components
WHERE facilityid = 1
GROUP BY TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Month')
HAVING COUNT(*) = (SELECT MAX ("Número de Componentes") FROM
                        (SELECT
                            TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Month') "Mes",
                            COUNT(*) "Número de Componentes"
                        FROM components
                        WHERE facilityid = 1
                        GROUP BY TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Month')
                        ));
/* 28
Nombre del día en el que más componentes se instalaron del facility 1.
Ejemplo: Jueves
*/
SELECT
        TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Day') "Día"
FROM components
WHERE FACILITYID=1
GROUP BY TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Day')
HAVING COUNT(*) = (SELECT MAX ("Número de Componentes") FROM
                        (SELECT
                            TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Day') "Día",
                            COUNT(*) "Número de Componentes"
                        FROM components
                        WHERE facilityid = 1
                        GROUP BY TO_CHAR(TO_DATE(SUBSTR(installatedon, 1, 11), 'DD/MM/RR HH24:MI:SS'), 'Day')
                        ));
/*29
Listar los nombres de componentes que están fuera de garantía del facility 1.
*/

--No se como determinar los componentes que están fuera de garantía porque 
--nada más tengo la fecha de inicio de garantía, pero no la fecha de finalización

/*
30
Listar el nombre de los tres espacios con mayor área del facility 1
*/
SELECT "Nombre del Espacio", "Área"
FROM (
    SELECT
        spaces.name AS "Nombre del Espacio",
        spaces.netarea AS "Área"
    FROM spaces
    JOIN floors ON spaces.floorid = floors.id
    WHERE floors.facilityid = 1
    AND spaces.netarea IN (
        SELECT spaces.netarea
        FROM spaces
        JOIN components ON components.spaceid = spaces.id
        WHERE components.facilityid = 1
    )
    ORDER BY spaces.netarea DESC
)
WHERE ROWNUM <= 3;
------------------------------------------------------------------------------------------------
