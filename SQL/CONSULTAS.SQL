CREATE TABLE departaments ( 
  codiDepartament NUMERIC(3) PRIMARY KEY, 
  nom VARCHAR(20)
);

INSERT INTO departaments VALUES ('31', 'Vendes');
INSERT INTO departaments VALUES ('33', 'Enginyeria');
INSERT INTO departaments VALUES ('34', 'Producció');
INSERT INTO departaments VALUES ('35', 'Màrqueting');

CREATE TABLE empleats ( 
  codiEmpleat VARCHAR(5) PRIMARY KEY, 
  cognom VARCHAR(25),
  codiDepartament NUMERIC(3),
  FOREIGN KEY (codiDepartament) REFERENCES departaments(codiDepartament)
);

-- 1. Empleados cuyo apellido empiece por R
SELECT cognom FROM empleats WHERE UPPER(cognom) LIKE 'R%';

-- 2. Nombres de departamentos que no tengan A
SELECT nom FROM departaments WHEREUPPR(nom) NOT LIKE '%A%'; 

-- 3. Departamentos y empleados
SELECT * FROM departaments, empleats WHERE empleats.codiDepartament = departaments.codiDepartament;

-- 4. Departamentos y cantidad de empleados, para los departamentos que sí tienen empleados
SELECT nom.departaments, COUNT(codiDepartament) FROM departaments, empleats WHERE empleats.codiDepartament = departaments.codiDepartament
GROUP BY nom.departaments;

-- 5. Departamentos con más de un empleado
SELECT nom.departaments, COUNT(codiDepartament) FROM departaments, empleats WHERE empleats.codiDepartament = departaments.codiDepartament
GROUP BY nom.departaments HAVING COUNT(*) > 1;

-- 6. Departamentos y empleados, incluyendo los departamentos que no tienen empleados
SELECT nom.departaments, COUNT(*) FROM departaments, empleats WHERE empleats.codiDepartament = departaments.codiDepartament
GROUP BY nom.departaments;

-- 7. Departamentos que empiezan por M y empleados, incluyendo los departamentos que no tienen empleados
SELECT nom.departaments, empleats.cognom FROM departaments, empleats WHERE empleats.codiDepartament = departaments.codiDepartament
AND UPPER(nom.departaments) LIKE 'M%';
-------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE professors (
    codi VARCHAR(3) PRIMARY KEY,
    nom VARCHAR(30)
);

CREATE TABLE cursos (
    codi NUMERIC(3) PRIMARY KEY,
    nom VARCHAR(30),
    hores NUMERIC(4),
    codiProfessor VARCHAR(5),
    FOREIGN KEY (codiProfessor) REFERENCES Professors(codi)
);

CREATE TABLE alumnes (
    codi VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(30),
    codiCurso NUMERIC(3),
    FOREIGN KEY (codiCurso) REFERENCES Cursos(codi)
);

-- 1. Nombres de los profesores, junto con el nombre de los cursos que imparten 
--(sólo para los profesores y cursos que realmente están relacionados).
SELECT professors.nom, cursos.nom FROM professors, cursos 
WHERE professors.codi = cursos.codiProfessor;

SELECT professors.nom, cursos.nom FROM professors
INNER JOIN cursos ON professors.codi = cursos.codiProfessor;

-- 2. Nombres de todos los profesores, junto con el nombre de los cursos que imparten
--(quizá ninguno).
SELECT professors.nom, cursos.nom FROM professors LEFT OUTER JOIN cursos
ON professors.codi = cursos.codiProfessor;

-- 3. Nombres de todos los profesores y todos los cursos, con las relaciones entre 
--ellos que existan.SELECT professors.nom, cursos.nom FROM professors, cursos 
SELECT professors.nom, cursos.nom FROM professors, cursos 
WHERE professors.codi = cursos.codiProfessor;
 
-- 4. Nombre de cada profesor, junto con el nombre del curso que imparte (si existe), 
--junto con el nombre de cada alumno que  asiste a ese curso (si existe).


-- 5. Duración media de los cursos.
-- 
-- 6. Nombre del curso más largo.
-- 
-- 7. Cursos cuyo nombre contiene un 1.
-- 
-- 8. Alumnos que asisten al curso más largo.
-- 
-- 9. Alumnos que no asisten al curso 2.
-- 
-- 10. Profesores que imparten más de un curso.
----------------------------------------------

-- Crea una taula Revistes, per a anotar dades d'antigues revistes en paper que tenim guardes:

-- 

-- - Codi, de 5 lletres

-- - Nom, de fins a 20 lletres, no nul, únic

-- - Categoria, de fins a 30 lletres,

-- - Any, número de 4 xifres, entre 1940 i 2040.

-- - Mes, número de 2 xifres, entre 1 i 12

CREATE TABLE Revisates(
  codi CHAR(5) PRIMARY kEY,

)

-- Crea també una taula Articles, amb camps:

-- 

-- - Codi, de fins a 15 lletres

-- - Títol, de fins a 30 lletres

-- - Descripció, de fins a 1000 lletres

-- - Subcategoria, de fins a 20 lletres

-- - Valoració, d'1 a 10, amb un decimal.

-- - Codi de revista, clau aliena a la taula anterior.

-- 

-- Usa la sintaxi de Oracle.

CREATE TABLE Revistes (
    codi CHAR(5) PRIMARY KEY,
    nom VARCHAR2(20) NOT NULL UNIQUE,
    categoria VARCHAR2(30),
    any NUMBER(4) CHECK (any BETWEEN 1940 AND 2040), /
    mes NUMBER(2) CHECK (mes BETWEEN 1 AND 12),      /
    PRIMARY KEY (codi)
);

CREATE TABLE Articles (
    codi CHAR(15) PRIMARY KEY,
    titol VARCHAR2(30),
    descripcio VARCHAR2(1000),
    subcategoria VARCHAR2(20),
    valoracio NUMBER(2, 1) CHECK (valoracio BETWEEN 1 AND 10), /
    codi_revista VARCHAR2(5) NOT NULL,
    PRIMARY KEY (codi),
    FOREIGN KEY (codi_revista) REFERENCES Revistes(codi)
);

CREATE TABLE revistes(
    codi CHAR(5), 
    nom VARCHAR2(20) NOT NULL,
    categ VARCHAR2(30),
    anyPubli NUMBER(4),
    mesPubli NUMBER(2),
    CONSTRAINT pk_revistes PRIMARY KEY (codi),
    CONSTRAINT uk_revistes_num UNIQUE (nom),
    CONSTRAINT ck_revistes_any CHECK(anyPubli BETWEEN 1940 AND 2040),
    CONSTRAINT ck_revistes_mes CHECK(mesPubli BETWEEN 1 AND 12)
);

CREATE TABLE articles(
    codi VARCHAR2(15), 
    titol VARCHAR2(50),
    descripcio VARCHAR2(1000),
    subCateg VARCHAR2(20),
    valoracio NUMBER(3,1), 
    codiRevista CHAR(5), 
    CONSTRAINT pk_articles PRIMARY KEY (codi),
    CONSTRAINT fk_articles 
        FOREIGN KEY (codiRevista) REFERENCES revistes(codi)
); 


-- ---------------

-- A partir de la tabla de revistas y la tabla de artículos que tienes detalladas más abajo, y de sus datos de ejemplo, halla:
-- 
-- 1. Nombre de las revistas del año 1988.
SELECT nom FROM revistes WHERE anyPubli = 1988;

-- 2. Título de los artículos cuya valoración no sea 10.
SELECT titol FROM articles WHERE valoracio <> 10;

-- 3. Nombre, año y mes de las revistas cuyo nombre contenga la palabra "Amstrad".
SELECT nom, anyPubli, mesPubli FROM revistes WHERE UPPER(nom) LIKE 'AMSTRAD';

-- 4. Título de los artículos para los cuales aún no tenemos una descripción.
SELECT titol FROM articles WHERE valoracio IS NULL;

-- 5. Nombre de las revistas que tenemos de los años 1987 a 1989, ambos inclusive, ordenadas alfabéticamente.
SELECT revistes.nom FROM revistes WHERE revistes.codi = articles.codi_revista
 AND revistes.anyPubli BETWEEN 1987 AND 1989
ORDER BY revistes.nom;

-- 6. Título de los artículos junto al nombre, mes y año de la revista en que aparecen, 
--ordenado de más reciente a más antiguo (por año y por mes, descendente).
SELECT articles.titol, articles.nom, articles.mesPubli FROM articles, revistes 
WHERE revistes.codi = articles.codi_revista 
ORDER BY revistes.anyPubli DESC;

-- 7. Valoración media de los artículos que tenemos (con el alias valoracMedia).
SELECT AVG(valoracio) AS 'valoracMedia' FROM articles;

-- 8. Cantidad de revistas de cada categoría.
SELECT nom, COUNT(*) FROM revistes GROUP BY nom;

-- 9. Cantidad de artículos en cada revista, para las que tienen 2 o más, ordenado de 
--mayor a menor cantidad de artículo.
SELECT revistes.nom, COUNT(*) FROM revistes, articles 
WHERE revistes.codi = articles.codi_revista GROUP BY revistes.nom HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC;

-- 10. Nombre, mes y año de la revista que tiene el artículo mejor valorado.
SELECT nom, mesPubli, anyPubli FROM revistes WHERE codi_revista IN (
  SELECT codi_revista FROM articles WHERE valoracio IN (
    SELECT MAX(valoracio) FROM articles)
);
----------------------------------------------------------------------------------------
--Hazme una consulta en sqllit que ordene las 10 primeras ciudades
SELECT * FROM city
ORDER BY name
LIMIT 10;

--Hazme una consulta en sqllit que ordene las 10 siguintes ciudades
SELECT * FROM city
ORDER BY name
LIMIT 10 OFFSET 20;
--------------------------------------------------------------------------------------------
SELECT ID, Name FROM city WHERE CountryCode IN (
  SELECT CountryCode FROM city WHERE NAME IN(
    SELECT Name FROM city WHERE Population IN (
      SELECT MAX(Population) FROM city
   )
  )
);

SELECT Name
FROM city WHERE population < (
	SELECT population
	FROM city WHERE CountryCode = "ESP"
	AND Population = (
		SELECT MIN (population) FROM city WHERE CountryCode = 'ESP'
	)
);

SELECT Name FROM city WHERE UPPER(Name) LIKE '%Z%X%';
---------------------------------------------------------------------------------

-- 1. Nombre (name) de los países cuyo continente (continent) es "Africa", 
--ordenado alfabéticamente.
SELECT Name FROM country WHERE UPPER(Continent) = 'AFRICA' ORDER BY Name;

-- 2. Países cuya región (region) contiene la palabra "Europe" y 
--cuya población (population) es superior a 35 millones (35000000).
SELECT *  FROM country WHERE UPPER(Region) LIKE '%EUROPE%' AND
Population > 35000000;

-- 3. Esperanza de vida (LifeExpectancy) media de los países cuyo 
--continente (continent) es "Asia".
SELECT AVG(LifeExpectancy) FROM country WHERE UPPER(Continent) = 'ASIA';

-- 4. Nombre (name) y producto nacional bruto (GNP) de los paises 
--cuya región sea 'Nordic Countries' o 'Baltic Countries', de 2 formas 
--distintas.
SELECT Name, GNP FROM country WHERE UPPER(Region) IN ('NORDIC COUNTRIES','BALTIC COUNTRIES');/

-- 5. Cantidad de países en cada continente (continent).
SELECT Continent, COUNT(*) FROM country GROUP BY Continent;

-- 6. Diferencia entre el país con mayor esperanza de vida 
--(LifeExpectancy) y el país con menor esperanza de vida de cada continente.
SELECT MAX(LifeExpectancy) - (
  SELECT MIN(LifeExpectancy) FROM country
) FROM country;

-- 7. Paises del continente "Asia" cuyo producto nacional bruto 
--(GNP) está por debajo de menor GNP existente en "Europe".
SELECT * FROM country WHERE UPPER(Continent) = 'ASIA' AND GNP < (
  SELECT MIN(SELECT Continent, COUNT(*) FROM country
              WHERE UPPER(Continent) = 'EUROPE' GROUP BY Continent) 
  FROM country;
);

--- 8. Continentes en los que existe la forma de gobierno (GovernmentForm) 
--llamada "Constitutional Monarchy" pero no la llamada "Monarchy".
SELECT DISTINCT continent
FROM country
WHERE GovernmentForm = 'Constitutional Monarchy'
AND NOT EXISTS (
  SELECT *
  FROM country
  WHERE GovernmentForm = 'Monarchy'
  AND country.continent = country.continent
);


-- 9. Paises, que teniendo distinto nombre (name), tienen aparentemente al 
--mismo gobernante (HeadOfState). 
SELECT HeadOfState, COUNT(*)
FROM country
GROUP BY HeadOfState
HAVING COUNT(*) > 1; //


-- 10. Paises cuya renta per cápita (GNP / population) o cuya esperanza 
--de vida (LifeExpectancy) sean superiores a los de Estados Unidos ("United States"), 
--ordenados alfabéticamente.
SELECT Name
FROM country
WHERE (GNP / Population > (SELECT GNP / Population FROM country WHERE Name = 'United States'))
OR (LifeExpectancy > (SELECT LifeExpectancy FROM country WHERE Name = 'United States'))
ORDER BY Name;

------------------------------------------------------------------------------------------------------------------------
--Obtener todos los países en el continente de Europa.
SELECT nom FROM country WHERE Continent = "Europa";
--Obtener el promedio de la expectativa de vida para todos los países.
SELECT AVG(LifeExpectancy) FROM country;
-- Obtener los países con una expectativa de vida mayor a 75 años.
SELECT Name, LifeExpectancy FROM country 
WHERE LifeExpectancy >= 75;
-- Obtener el nombre del país con la población más grande.
SELECT Name FROM country WHERE Population IN (
  SELECT MAX(Population) FROM country
);
-- Obtener el nombre de los países con una superficie total de más de 1 millón
-- de km^2.
SELECT Name FROM country WHERE SurfaceArea > 1000000; 
-- Obtener el promedio del GNP para todos los países en América.
SELECT AVG(GNP) FROM country WHERE UPPER(Continent) 
IN ('NORTH AMERICA');



--Obtener el nombre de los países con la expectativa de vida más alta en cada región.
SELECT Region, LifeExpectancy, COUNT(*) FROM country
GROUP BY Region ORDER BY DESC; 
--SELECT Name, Region, LifeExpectancy
--FROM country c1
--WHERE LifeExpectancy = (SELECT MAX(LifeExpectancy) FROM country c2 WHERE c2.Region = c1.Region);

-----------------------------------------------------------------------------------

--Obtener el nombre de los países con una población mayor al promedio de la 
--población en su región.

------------------------------------------------------------------------------------
-- Obtenga los nombres de los países cuyo PIB per cápita (GNP / Population) 
--es mayor que la media del PIB per cápita para todos los países:

SELECT Name FROM country WHERE GNP / Population >(
  SELECT AVG((GNP / Population)) AS 'Pib per Capita' FROM country
);

--Obtenga los nombres de los países que tienen una esperanza de vida 
--(LifeExpectancy) mayor que la media para todos los países en el mismo
--continente

SELECT Name FROM country WHERE LifeExpectancy >(
  SELECT AVG(LifeExpectancy) FROM country WHERE continent = country.Continent
);

--Obtenga el nombre de los países que tienen una población mayor que el país 
--con la capital más grande:

SELECT Name FROM country WHERE Population > (
  SELECT MAX(capital) FROM country 
);

--Obtenga el nombre de los países que tienen una superficie total mayor que 
--la suma de las superficies de todos los países en el mismo continente
SELECT MAX(SurfaceArea) FROM country WHERE Continent = country.Continent;
--------------------------------------------------------------------------------------------------------
CREATE TABLE plataformes(
    codi CHAR(4), 
    nom VARCHAR2(30),
    CONSTRAINT pk_plataformes PRIMARY KEY (codi),
    CONSTRAINT uk_plataformes UNIQUE (nom)
);

CREATE TABLE jocs(
    codi CHAR(5), 
    nom VARCHAR2(50),
    descripcio VARCHAR2(1000),
    dataLlancament DATE,
    espaiOcupat NUMBER(7,3), 
    codiPlataforma CHAR(4), 
    CONSTRAINT pk_jocs PRIMARY KEY (codi),
    CONSTRAINT uk_jocs UNIQUE (nom),
    CONSTRAINT ck_jocs_nom CHECK (nom = UPPER(nom)),
    CONSTRAINT ck_jocs_espai CHECK (espaiOcupat <= 2000)
    CONSTRAINT fk_plataformes 
        FOREIGN KEY (codiPlataforma) REFERENCES plataformes(codi)
); 

ALTER TABLE jocs ADD (COLUMN horesJugades NUMBER(6,2));


--1. Nom de cada ciutat i nom del país al qual pertany, ordenat per ciutat i , en cas que dues 
--ciutats tinguen el mateix nom, per nom del país.
SELECT c1.Name as City_Name, c2.Name as Country_Name
FROM city c1
JOIN country c2
ON c1.CountryCode = c2.Code
ORDER BY c1.Name, c2.Name;


-- 2. Països dels quals no tenim cap ciutat, ordenats de manera descendent.
SELECT c2.Name as Country_Name
FROM country c2
LEFT JOIN city c1
ON c2.Code = c1.CountryCode
WHERE c1.ID IS NULL
ORDER BY c2.Name DESC;
 

-- 3. Països el nom dels quals coincideix amb el d'una ciutat.
SELECT city.Name,  country.Name FROM city, country WHERE city.CountryCode = country.Code AND
UPPER(country.Name) = UPPER(city.Name);
-- 4. Nom de cada país al costat del nom de la seua capital, si existeix.
SELECT Name, Capital FROM country WHERE Capital IS NOT NULL; MAL

-- 5. País, capital i governant, per als països el governant dels quals tinga 3 o 
--més paraules, ordenat per país.
SELECT Name, Capital, HeadOfState FROM country WHERE LENGTH(HeadOfState) > 2 ORDER BY NAME; MAL

-- 6. Capitals i noms de països el producte interior brut dels quals 
--siga inferior a tots els d'Europa.
SELECT Capital, Name FROM country WHERE GNP < (
  SELECT MIN(GNP) FROM country WHERE UPPER(Continent) = "EUROPE";
);

-- 7. Per a cada país: nom, població i suma de les poblacions de les ciutats que ens apareixen 
--d'aqueix país.
SELECT Name, Population, SUM(Population) FROM country GROUP BY Name, Population;

-- 8. Països la població dels quals és menys de la meitat de la ciutat més poblada de tota 
--la base de dades.
SELECT Name FROM country WHERE Population < (
  SELECT MAX(Population) FROM city
) / 2;

-- 9. Capitals que tinguen la meitat (o més) de la població del seu país.
SELECT c1.Name as City_Name, c2.Name as Country_Name, c1.Population as 
City_Population, c2.Population as Country_Population
FROM city c1
JOIN country c2
ON c1.CountryCode = c2.Code
WHERE c1.ID = c2.Capital AND c1.Population >= (c2.Population / 2);



-- 10. Ciutats el nom de les quals està repetit, i nom dels països en els quals estan aqueixes 
--ciutats.
SELECT c1.Name as City_Name, c2.Name as Country_Name
FROM city c1
JOIN country c2
ON c1.CountryCode = c2.Code
GROUP BY c1.Name, c2.Name
HAVING count(c1.Name) > 1;

--------------------------------------------------------------------------------------------------------------------

DECLARE 
    espaiMax NUMBER(9,3);
BEGIN 
    SELECT AVG(espaiOcupatMb)
    INTO espaiMax
    FROM jocs

    dbms_output.put_line(espaiMitja);
END;
------------------------------------------------------------------------------------------------------------------------
DECLARE 
    espaiMax NUMBER
---------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE plataformes(
    codi CHAR(4), 
    nom VARCHAR2(30),
    CONSTRAINT pk_plataformes 
    PRIMARY KEY (codi)
);

CREATE TABLE jocs(
    codi CHAR(5), 
    nom VARCHAR2(50),
    descripcio VARCHAR2(1000),
    anyLlancament NUMBER(4),
    espaiOcupatMb NUMBER(9,3), 
    codiPlataforma CHAR(4), 
    CONSTRAINT pk_jocs PRIMARY KEY (codi),
    CONSTRAINT fk_plataformes 
        FOREIGN KEY (codiPlataforma) 
        REFERENCES plataformes(codi)
); 
-- 01 - Muestra el nombre de los juegos que ocupan menos de 1 MB.
SELECT nombre FROM jocs WHERE espaiOcupatMb < 1;
-- 02 - Datos de las plataformas que comienzan por "PC".
SELECT * FROM plataformes WHERE nom LIKE 'PC%'
-- 03 - Nombre de los juegos cuya plataforma se llama "Nintendo WII" 
--y que no son del año 2010.
SELECT jocs.nom FROM jocs, plataformes 
WHERE plataformes.codi = jocs.codiPlataforma AND plataformes.nom = 'Nintendo WII'
AND anyLlancament <> 2010;

-- 04 - Nombre de los juegos para los que no sabemos el espacio ocupado, 
--ordenados alfabéticamente.
SELECT nom FROM jocs WHERE espaiOcupatMb IS NULL ORDER BY nom ASC;

-- 05 - Nombres de las plataformas que contienen la palabra 
--"STATION" (quizá con mayúsculas distintas).
SELECT nom FROM plataformes WHERE UPPER(nom) LIKE '%STATION%';

-- 06 - Nombres de los juegos que son de las plataformas 
--"Amstrad CPC" o "MSX", usando IN.
SELECT jocs.nom FROM plataformes INNER JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma WHERE plataformes.nom 
IN ('Amstrad CPC' , 'MSX');

-- 07 - Nombres de los juegos que son de las plataformas 
--"Amstrad CPC" o "MSX", sin usar IN.
SELECT jocs.nom FROM plataformes INNER JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma WHERE (plataformes.nom  = 'Amstrad CPC' OR
plataformes.nom  = 'MSX');

-- 08 - Nombre de cada juego y nombre de la plataforma a la que pertenece, 
--ordenado por juego y (si coincide el nombre del juego) por plataforma.
SELECT jocs.nom, plataformes.nom FROM plataformes INNER JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma 
ORDER BY jocs.nom, plataformes.nom;

-- 09 - Nombre de cada plataforma y cantidad de juegos que tenemos 
--para esa plataforma, incluso si de alguna plataforma no tenemos ningún juego.
SELECT plataformes.nom, COUNT(*) FROM plataformes LEFT OUTER JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma GROUP BY plataformes.nom;

-- 10 - Nombre de cada plataforma y cantidad de juegos que tenemos 
--para esa plataforma, para las plataformas en las que tenemos más de un juego.
SELECT plataformes.nom, COUNT(*) FROM plataformes LEFT OUTER JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma GROUP BY plataformes.nom 
HAVING COUNT(*) > 1;

-- 11 - Nombre de las plataformas para las que no tenemos ningún 
--juego, ordenadas alfabéticamente.
SELECT plataformes.nom FROM plataformes LEFT JOIN jocs 
ON plataformes.codi = jocs.codiPlataforma GROUP BY plataformes.nom
HAVING COUNT(jocs.nom) = 0 ORDER BY plataformes.nom;

SELECT nom FROM plataformes WHERE codi NOT IN (
  SELECT codiPlataforma FROM jocs;
)

-- 12 - Nombre y descripción de los juegos que son para la misma plataforma que el juego más grande que tenemos en nuestra base de datos.

-- 13 - Nombre de los juegos que tenemos para más de una plataforma.

-- 14 - Espacio ocupado por el juego que menos ocupa en cada plataforma.

-- 15 - Nombre del juego (o juegos) que menos ocupaNo en cada una de las plataformas.

-- 16 - Nombre de todos los juegos que tenemos, sin duplicados, ordenados alfabéticamente.

-- 17 - Nombre de cada plataforma y año medio de los juegos que tenemos para esa plataforma.

-- 18 - Nombre de la plataforma más antigua (aquella cuyos juegos son, como media, más antiguos).

-- 19 - Nombre de los juegos y espacio que ocupan, redondeado sin decimales, para aquellos que ocupan menos de 50 MB.

-- 20 - Nombre de las plataformas cuyo código coincida con las 3 primeras letras de su nombre.

-- 21 - Añade un campo "Categoría" a la tabla de juegos, que podrá contener hasta 20 letras.

-- 22 - Añade a la tabla de juegos una restricción de que el año de lanzamiento deba ser superior a 1979.

-- 23 - Crea una tabla Valoraciones, con un código de valoración (número, de 5 cifras), que actuará como clave primaria, un código de juego (clave ajena a la tabla de juegos), un texto (hasta 100 letras) y una valoración numérica (hasta 2 cifras antes de la coma decimal, y una cifra después de la coma). Usa sintaxis de Oracle.

-- 24 - Añade dos datos de ejemplo a la tabla de Valoraciones, indicando valores para todos los datos a excepción del texto, y haciéndolo de 2 formas distintas (una vez empleando los nombres de los campos y otra vez sin detallarlos).

-- 25 - Crea una tabla Usuarios, con un código de exactamente 5 letras para cada usuario, un nombre y una fecha de alta. El nombre debe ser único y no nulo. Usa sintaxis de Oracle.

-- 26 - Introduce 3 usuarios de ejemplo: en uno no indicarás los nombres de los campos, en otro indicarás todos los nombres de los campos e introducirás todos los datos, en otro indicarás los nombres de algunos campos e introducirás datos sólo en algunos campos.

-- 27 - Modifica el juego cuyo nombre es 'Batman: A.O.' para que pase a ser 'Batman: Arkham Origins'.

-- 28 - Modifica los datos de juegos: si alguno tiene espacio ocupado 0, cámbialo por un valor nulo.

-- 29 - Borra los juegos que sean (a la vez) anteriores a 1982 y para plataformas cuyo nombre comience por "Play".

-- 30 - Muestra los nombres de las plataformas cuyas 4 primeras letras no coinciden con ninguna otra plataforma.

-- 31 - Nombres de todos los usuarios y nombres de todas las plataformas.

-- 32 - Nombres de los usuarios que coincidan con el nombre de alguna plataforma.

-- 33 - Nombre del juego, nombre de la plataforma y espacio ocupado, para los juegos que ocupen menos que cualquier juego de la plataforma "Amstrad CPC".

-- 34 - Nombres de las plataformas para las que el conjunto de todos los juegos que tenemos ocupa menos de 10 MB.

-- 35 - Crea una tabla "JuegosPS3", con parte de los datos (código, nombre y año) de los juegos que tenemos para PS3.

-- 36 - Borra la tabla de Valoraciones, que hemos decidido que no vamos a utilizar.

-- 37 - Añade a la tabla de Juegos un nuevo campo, valoracion, con hasta 2 cifras antes de la coma decimal, y una cifra después de la coma, y que sólo debe aceptar valores entre 0 y 10.

-- 38 - Asegúrate de que todos los juegos tengan valoración nula y, posteriormente, de que "The Last of Us" para la plataforma "ps3" tiene una valoración de 9.5.

-- 39 - Muestra nombre y espacio ocupado por los juegos que ocupan más que la media de los juegos de su misma plataforma.

-- 40 - Muestra el nombre de cada juego, su descripción y el espacio ocupado, para los juegos que ocupen más del doble de la media de su plataforma.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
  nomMesGran VARCHAR2(50);
BEGIN
  SELECT nom FROM jocs WHERE espaiOcupatMb IN (
    SELECT espaiOcupatMb FROM jocs 
  )
  dbms_output.put_line(nomMesGran);
END;



DECLARE 
  v_primerjoc jocs%ROWTYPE;
BEGIN
  SELECT nom FROM jocs ORDER BY ASC FETCH NEXT 1 ROWS ONLY
  dbms_output.put_line(('EL codi es ' || v_primerjoc.codi
                         || ', el nom es ' || v_primerjoc.nom
                         || ', Todos los datos son:  ' || v_primerjoc.*
                         );
END;

DECLARE
   num NUMBER := 10;
BEGIN
   LOOP
      EXIT WHEN num > 100;
      dbms_output.put_line(num);
      num := num + 10;
   END LOOP;
END;