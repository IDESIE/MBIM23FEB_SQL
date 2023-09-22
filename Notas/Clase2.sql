select id, name, serialnumber, externalidentifier, assetidentifier
from components
where
    spaceid between 10 and 37
order by spaceid desc;

select id, spaceid, name, serialnumber, externalidentifier, assetidentifier
from components
where
    spaceid >=10 and spaceid <= 37
order by spaceid desc;

SELECT NAME, ASSETIDENTIFIER, SERIALNUMBER, SPACEID, FACILITYID
    FROM COMPONENTS
    WHERE FACILITYID = 1
    AND SPACEID IS NULL
ORDER BY ASSETIDENTIFIER DESC;

SELECT COUNT (*), COUNT (SPACEID) 
FROM COMPONENTS 
WHERE FACILITYID=1;

SELECT NAME, FLOORID
FROM SPACES
WHERE NAME LIKE '_s%'
AND FLOORID=1;

SELECT NAME, FLOORID
FROM SPACES
WHERE FLOORID=1;

SELECT NAME, VOLUME,
    CASE
        WHEN VOLUME<10 THEN 'BAJO'
        WHEN VOLUME>=10 AND VOLUME <=1000 THEN 'MEDIO'
        ELSE 'ALTO'
    END "ALIAS"
FROM SPACES;

SELECT COUNT (NAME)
    FROM SPACES
    WHERE NAME not like 'Aula%' AND FLOORID=1;
    
SELECT COUNT(*), SUBSTR(NAME,1,4)
    FROM SPACES
    WHERE NAME not like 'Aula%' AND FLOORID=1
GROUP BY SUBSTR(NAME,1,4);    

SELECT COUNT(NAME)
    FROM COMPONENT_TYPES
    WHERE FACILITYID=1
    AND NAME LIKE '%a_%' escape 'a';

    SELECT 
    TO_CHAR(installatedon,'Day')
FROM COMPONENTS
WHERE FACILITYID=1;

SELECT
    ROUND(SUM(NETAREA),2),
    ROUND(MAX(NETAREA),2),
    ROUND(MIN(NETAREA),2),
    ROUND(AVG(NETAREA),2)
FROM SPACES
WHERE FLOORID=1;


SELECT 
    round(AVG(NETAREA))"Media",
    round((AVG(NETAREA)+MIN(NETAREA))/2) "MediaBaja",
    round((AVG(NETAREA)+MAX(NETAREA))/2) "MediaAlta"
FROM SPACES
WHERE FLOORID=1;


SELECT 
    ROUND((COUNT(WARRANTYSTARTON)*100)/COUNT(*),2)
FROM COMPONENTS
WHERE FACILITYID=1;

SELECT 
    TO_CHAR(installatedon,'Day'),
    Count(installatedon)
FROM COMPONENTS
WHERE FACILITYID=1
Group By TO_CHAR(installatedon,'Day'), TO_CHAR(installatedon,'d')
ORDER BY TO_CHAR(installatedon,'d');

SELECT Count(installatedon)
FROM COMPONENTS
WHERE FACILITYID=1;

SELECT 
    TO_CHAR(installatedon,'Day'),
    Count(*)
FROM COMPONENTS
WHERE FACILITYID=1
Group By TO_CHAR(installatedon,'Day'),TO_CHAR(installatedon,'d')
Having count(installatedon)>470
Order By TO_CHAR(installatedon,'d');