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