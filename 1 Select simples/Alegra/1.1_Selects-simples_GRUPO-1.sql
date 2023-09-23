------------------------------------------------------------------------------------------------
--SELECTS SIMPLES
------------------------------------------------------------------------------------------------
/* 1
Describir la tabla floors
*/
SELECT *
FROM FLOORS
/* 2
Describir la tabla spaces
*/
SELECT *
FROM SPACES;
/* 3
Datos de la tabla components
*/
SELECT *
FROM COMPONENTS;
/* 4
Datos de la tabla component_types
*/
SELECT *
FROM COMPONENT_TYPES;
/* 5
Id, nombre de los facilities
*/
SELECT ID, NAME
FROM FACILITIES;
/* 6
Nombre, elevación e id del facility de las plantas
*/
SELECT NAME, ELEVATION, FACILITYID
FROM FLOORS;
/* 7
Nombre, area bruta, volumen de los espacios
*/
SELECT NAME, NETAREA, VOLUME
FROM SPACES;
/* 8
Nombre, vida útil de los tipos de componentes del facility 1
*/
SELECT NAME, EXPECTEDLIFE
FROM COMPONENT_TYPES
WHERE FACILITYID=1
/* 9
Nombre de los espacios de la Planta 1 del facility 1
*/
/*Previamente se consulta cuál es el floorid
listando los */
SELECT SPACES.NAME
FROM FLOORS, SPACES
WHERE FLOORS.ID = SPACES.FLOORID
AND FLOORID=1
AND FACILITYID=1; 
SELECT NAME, FLOORID
FROM SPACES;
/* 10
Nombre, número de modelo del tipo de componente con id = 60
*/
SELECT NAME, MODELNUMBER
FROM COMPONENT_TYPES
WHERE ID=60;
/* 11
Nombre y fecha de instalación de los componentes del espacio 60 ordenados descendentemente por la fecha de instalación
*/
SELECT NAME, INSTALLATEDON
FROM COMPONENTS
WHERE SPACEID=60
ORDER BY INSTALLATEDON DESC;
/* 12
Listar las distintas fechas de instalación de los componentes del facility 1 ordenados descendentemente.
*/
SELECT INSTALLATEDON
FROM COMPONENTS
WHERE FACILITYID=1
ORDER BY INSTALLATEDON DESC;
/* 13
Listar los distintos GUIDs de los componentes del facility 1 ordenados ascendentemente por fecha de garantía.
*/
SELECT externalidentifier
FROM COMPONENTS
WHERE FACILITYID=1
ORDER BY WARRANTYSTARTON ASC;
SELECT externalidentifier
FROM COMPONENTS
WHERE FACILITYID=1
AND WARRANTYSTARTON IS NOT NULL
ORDER BY WARRANTYSTARTON ASC;
/* 14
Id, código de activo, GUID, número de serie y nombre de los componentes cuyo spaceid está entre 10 y 27 inclusive
ordenados por id de espacio descendentemente.
*/
SELECT id, assetidentifier, externalidentifier, serialnumber, name
FROM COMPONENTS
WHERE spaceid between 10 and 27
ORDER BY spaceid desc;
SELECT id, assetidentifier, externalidentifier, serialnumber, name
FROM COMPONENTS
WHERE spaceid >= 10 and spaceid <= 27
ORDER BY spaceid desc;
/* 15
Id, código de activo, GUID, número de serie y nombre de los componentes del facility 1 
ordenados por código de activo descendentemente.
*/
SELECT id, assetidentifier, externalidentifier, serialnumber, name
FROM COMPONENTS
WHERE facilityid=1
ORDER BY assetidentifier desc;
/* 16
Códigos de activo de los componentes del espacio con id 21
ordenados por código de activo descendentemente.
*/
SELECT assetidentifier
FROM COMPONENTS
WHERE spaceid = 21
ORDER BY assetidentifier desc;
/* 17
Las distintas fechas de instalación de los componentes 
de los espacios con id 10, 12, 16, 19 
ordenadas descendentemente.
*/
SELECT installatedon, spaceid
FROM COMPONENTS
WHERE spaceid in (10,12,16,19)
ORDER BY installatedon desc;
/* 18
Nombre, volumen, de los espacios
cuyo volumen es mayor a 90 de floorid = 1
ordenados por volumen descendentemente
*/
select name, volume
from spaces
where volume > 90
and floorid=1
order by volume desc;
/* 19
Nombre, volumen de los espacios
cuyo volumen es mayor a 6 y menor a 9 de la planta con id = 1
*/
select name, volume
from spaces
where volume between 6 and 9
and floorid=1;
/* 20
Nombre, código de activo, número de serie de los componentes
que no tengan espacio del facility 1
ordenados descendentemente por código de activo
*/
SELECT NAME, ASSETIDENTIFIER, SERIALNUMBER, SPACE ID, FACILITY ID
FROM COMPONENTS
WHERE FACILITYID=1
AND SPACEID IS NULL
/*
Para comprobar
*/
SELECT COUNT (*), COUNT (SPACEID)
FROM COMPONENTS
WHERE FACILITYID=1
/* 21
Nombre, código de activo, número de serie de los componentes
que tengan número de serie del facility 1
*/
SELECT NAME, ASSETIDENTIFIER, SERIALNUMBER
FROM COMPONENTS
WHERE FACILITYID=1
AND SERIALNUMBER IS NOT NULL;
/* 22
Nombre de los espacios que empiezan por la letra A donde floorid = 1
*/
SELECT NAME
FROM SPACES
WHERE NAME LIKE 'A%' 
AND FLOORID=1;
/* 23
Lista de espacios que su segunda letra es una 's' donde floorid = 1
*/
SELECT NAME, FLOORID
FROM SPACES
WHERE NAME LIKE '_s%'
AND FLOORID=1;
/* 24
Lista de tipos de componente del facility 1 
donde el nombre contiene el texto 'con'
y no tienen vida útil indicada o fecha de garantia 
*/
SELECT NAME
FROM component_types
WHERE facilityid=1
AND name like '%con%'
and (expectedlife is null
or  warrantydescription is null);
/* 25
Nombres de espacios y volumen
pero como volumen una etiqueta que indique 
'BAJO' si es menor a 10, 'ALTO' si es mayor a 1000
y 'MEDIO' si está entre medias
*/
SELECT NAME, VOLUME,
    CASE
        WHEN VOLUME<10 THEN 'BAJO'
        WHEN VOLUME>=10 AND VOLUME <=1000 THEN 'MEDIO'
        ELSE 'ALTO'
    END "ALIAS"
FROM SPACES;
/* 26
Nombre, fecha de instalación, fecha de garantia
de los componentes del facility 1
que tienen fecha de garantia
*/

/* 27
Lista de nombres de espacio que su id no es 4, 9, ni 19
del floorid 1
*/
SELECT NAME, INSTALLATEDON, WARRANTYSTARTON
FROM COMPONENTS
WHERE FACILITYID=1
AND WARRANTYSTARTON IS NOT NULL;
/* 28
Lista de espacios que no son Aula del floorid = 1
*/
SELECT COUNT (NAME)
    FROM SPACES
    WHERE NAME not like 'Aula%' AND FLOORID=1;
/* 29
Lista de los tipos de componentes que tienen duracion de la garantia de las partes
del facility 1
*/
SELECT NAME
FROM component_types
WHERE warrantydurationparts IS NOT NULL
AND FACILITYID=1;
/* 30
Lista de los tipos de componentes que no tiene el coste de repuesto
del facility 1
*/
SELECT NAME
FROM component_types
WHERE replacementcost IS NULL
AND FACILITYID=1;
/* 31
Lista de los tipos de componentes que tienen en el nombre un guión bajo
del facility 1
*/
SELECT NAME
    FROM COMPONENT_TYPES
    WHERE FACILITYID=1
    AND NAME LIKE '%a_%' escape 'a';
--
------------------------------------------------------------------------------------------------
