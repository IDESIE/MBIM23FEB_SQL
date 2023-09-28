/*el area media de los espacios del facility 1*/
select 
    round(avg(grossarea),2)
from spaces;

select 
    round(avg(spaces.grossarea),2)
from spaces 
    join floors on spaces.floorid = floors.id
where floors.facilityid=1;

/*nombre de los espacios y su área del facility 1*/
select 
    spaces.name, spaces.netarea
from spaces 
    join floors on spaces.floorid = floors.id
where floors.facilityid=1;

/*15 Nombre, área bruta y volumen de los espacios con mayor área que la media de áreas del facility 1*/
select 
    spaces.name,
    spaces.grossarea,
    spaces.volume
from spaces 
    join floors on spaces.floorid = floors.id
    join facilities on floors.facilityid = facilities.id
where floors.facilityid=1
    and spaces.netarea > (select 
                            round(avg(spaces.grossarea),2)
                        from spaces 
                             join floors on spaces.floorid = floors.id
                        where floors.facilityid=1);

/*En where no se calcula, solo se compara*/

/*Nombre de la planta, y del espacio en el que hay al menos un extintor*/
select distinct
        floors.name "FloorsName", 
        spaces.name "SpacesName"
    from components
        join spaces on components.spaceid = spaces.id
        join floors on spaces.floorid = floors.id
where (lower(components.name) like '%silla%');

select distinct
        count (components.name),
        floors.name "FloorsName", 
        spaces.name "SpacesName"
    from components
        join spaces on components.spaceid = spaces.id
        join floors on spaces.floorid = floors.id
where lower(components.name) like '%silla%'
group by spaces.name, floors.name
having count(components.name)>5;

/*nombre de los espacio que tienen un cubo*/

--Que espacios tienen un cubo?
select distinct
        spaces.name "SpacesName"
    from components
        join spaces on components.spaceid = spaces.id
        join component_types on components.typeid = component_types.id
where (lower(component_types.name) like '%cubo%');

--Que espacios no tienen un cubo? 
select
        spaces.name "SpacesName"
    from spaces
where spaces.name not in (select distinct
                     spaces.name "SpacesName"
                             from components
                    join spaces on components.spaceid = spaces.id
                    join component_types on components.typeid = component_types.id
                        where (lower(component_types.name) like '%cubo%'));

--Numero de espacios
select
    count(*)
from spaces;

--Numero de cubos
select
    count(components.name)
from components
    join component_types on components.typeid = component_types.id
where (lower(component_types.name) like '%cubo%');

--Cuantos espacios no tienen un cubo?
select
        count(spaces.name) "SpacesName"
    from spaces
where spaces.name not in (select distinct
                     spaces.name "SpacesName"
                             from components
                    join spaces on components.spaceid = spaces.id
                    join component_types on components.typeid = component_types.id
                        where (lower(component_types.name) like '%cubo%'));

--Cuales son los espacios con mas de un cubo?
select
        spaces.name "SpacesName",
        count(component_types.id)
    from components
        join spaces on components.spaceid = spaces.id
        join component_types on components.typeid = component_types.id
where (lower(component_types.name) like '%cubo%')
group by spaces.name
having count(component_types.id)>1;

--Cuales son los espacios con mas de un cubo y cual es su facility?
select
        spaces.name "SpacesName",
        count(component_types.id),
        component_types.facilityid
    from components
        join spaces on components.spaceid = spaces.id
        join component_types on components.typeid = component_types.id
where (lower(component_types.name) like '%cubo%')
group by spaces.name, component_types.facilityid
having count(component_types.id)>1;

insert into facilities (
    id, 
    name,
    createdat,
    updatedat,
    creatorid)
values(
    6, 
    'Montalban 3',
    to_date('2023-09-25','yyyy-mm-dd'),
    sysdate,
    1);

/*borrar por el primary key*/
delete from facilities
where id = 6;

update facilities
set description = concat(concat(id,' - '), name),
    updatorid=1,
    updatedat = to_date ('1834-02-12','yyyy-mm-dd')
where id in (1,3,5,7);

/*Sentencias DML (lenguaje de manipulación de datos) son insert, delete, update */

/*Para ue se guarde COMMIT, para que se deshaga ROLLBACK*/

/* Sentencias DDL (lenguaje de definición de datos) son create, drop (eliminar), alter (modificar), rename */

/*Crear una tabla, definir campos*/ /*constraint_nombre de la tabla_nombre del campo*/

create table 
    nombre(
         id number,
         nombre varchar2(2000),
         apellido varchar2(2000),
         nacido date,
         padre number,
         constraint pk_nombre_id primary key(id),
         constraint uq_nombre_nombre unique(nombre),
         constraint fk_nombre_padre foreign key(padre)
            references nombre(id)
         );

insert into nombre(id, nombre, padre)
values(10, 'pepe', 1);

