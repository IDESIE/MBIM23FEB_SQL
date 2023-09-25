select 
    components.name "componentName",
    components.spaceid,
    spaces.id,
    components.typeid, 
    spaces.name "spaceName",
    component_types.name "typeName"
from components, spaces, component_types
where 
    components.spaceid = spaces.id
    and components.typeid = component_types.id
    and components.facilityid=1
    and (lower(components.name) like '%silla%' or lower(components.name) like '%mesa%')
order by spaces.id;


select 
    components.name "componentName",
    components.spaceid,
    spaces.id,
    components.typeid, 
    spaces.name "spaceName",
    component_types.name "typeName"
from components 
    join spaces on components.spaceid = spaces.id
    join component_types on components.typeid = component_types.id
where 
    components.facilityid=1
    and (lower(components.name) like '%silla%' or lower(components.name) like '%mesa%')
order by spaces.id;

select 
    count(facilities.name) "facilityName",
    count(spaces.name) "spaceName"
from
    facilities
        join floors on facilities.id = floors.facilityid
        join spaces on floors.id = spaces.floorid
order by spaces.name;

select 
    facilities.name "facilityName",
    count(spaces.name) "spaceName"
from
    facilities
        left join floors on facilities.id = floors.facilityid
        left join spaces on floors.id = spaces.floorid
group by facilities.name;


select
    count(*)
from spaces;

select distinct
    spaces.name
from components
    join spaces on components.spaceid = spaces.id;
    
select spaceid
from components;
    
select id, name
from spaces
where (id, name) in (select spaceid, name from components);

select id
from spaces
where id not in (select spaceid
                    from components 
                    where spaceid is not null);
      component_types.material, component_types.id, 
        components.typeid, components.id, component.assetidentifier
                    
select component_types.material, 
        component_types.id "TypeID",
        components.typeid, 
        components.id "componentID",
        components.assetidentifier
from components 
    join component_types on components.typeid = component_types.id
where components.typeid in (10000, 20000, 300000)
order by components.id;

select component_types.material, 
        component_types.id "TypeID",
        components.typeid, 
        components.id "componentID",
        components.assetidentifier
from components 
    join component_types on components.typeid = component_types.id
where components.id in (10000, 20000, 300000);

//*componente en que espacio esta*//

select count(name), spaceid
from components
group by spaceid;

select
    count(spaceid),
    count(*),
    count(id),
    spaceid
from components
group by spaceid;

//*having es el where cuando se usa condiciones de grupo*//

select
    count(*),
    spaceid
from components
group by spaceid
having count (*)=5;

//*pero quiero el nombre de esos 5 componentes*//

select spaces.name
from components
    join spaces on spaces.id = components.spaceid
group by spaces.name
having count (*)=5;

//*De otra forma*//
select name
from spaces 
where id in (
        select spaceid
        from components
        group by spaceid
        having count(*) = 5);

//*el numero de espacios del espacio llamado cajero*//
select spaces.name,
    count(*)
from components
    join spaces on spaces.id = components.spaceid
where spaces.name = 'CAJERO'
group by spaces.name
having count (*)=5;