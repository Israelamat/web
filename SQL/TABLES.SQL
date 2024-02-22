CREATE TABLE city (
  ID NUMBER(5),
  Name VARCHAR2(35) NOT NULL,
  CountryCode VARCHAR2(3) NOT NULL DEFAULT '',
  District VARCHAR2(20) NOT NULL DEFAULT '',
  Population NUMBER(12) NOT NULL DEFAULT '0',
  PRIMARY KEY (ID),
  CONSTRAINT city_ibfk_1 FOREIGN KEY (CountryCode) 
  REFERENCES country (Code)
);

CREATE TABLE country (
  Code VARCHAR2(3),
  Name VARCHAR2(52) NOT NULL,
  Continent VARCHAR2(20) NOT NULL,
  Region VARCHAR2(26) NOT NULL DEFAULT '',
  SurfaceArea NUMBER(10,2) NOT NULL DEFAULT '0.00',
  IndepYear NUMBER(5),
  Population NUMBER(12) NOT NULL,
  LifeExpectancy NUMBER(3,1),
  GNP NUMBER(10,2),
  GNPOld NUMBER(10,2),
  LocalName VARCHAR2(45) NOT NULL DEFAULT '',
  GovernmentForm VARCHAR2(45) NOT NULL DEFAULT '',
  HeadOfState VARCHAR2(60) DEFAULT NULL,
  Capital NUMBER(12),
  Code2 CHAR2(2) NOT NULL,
  PRIMARY KEY (Code)
);

CREATE TABLE articles (
    codi CHAR (5) PRIMARY KEY, 
    nombre VARCHAR2 (60),
    CONSTRAINT pk_codi PRIMARY KEY (codi)
); 
CREATE TABLE peces (
    codi CHAR (5) PRIMARY KEY, 
    nombre VARCHAR2 (60),
    CONSTRAINT pk_codi PRIMARY KEY (codi)
);

CREATE TABLE contiene (
    codigo_articles VARCHAR (5), 
    codigo_peces VARCHAR (5),
    PRIMARY KEY (codigo_articles, codigo_peces),
    FOREIGN KEY (codigo_articles) REFERENCES articulos(codigo),
    FOREIGN KEY (codigo_pieza) REFERENCES piezas(codigo),
    CONSTRAINT pk_contiene PRIMARY KEY (codigo_articulo, codigo_articles),
    CONSTRAINT fk_codigo_articulo PRIMARY KEY (codigo_articles),
    CONSTRAINT fk_codigo_pieza PRIMARY KEY (codigo_peces),
);

INSERT INTO articles VALUES ("HP","Portatil HP");
INSERT INTO articles VALUES ("LEN","Portatil Lenovo");
INSERT INTO articles VALUES ("ASU","Portatil ASUS");

INSERT INTO peces VALUES ("1","Procesador AMD");
INSERT INTO peces VALUES ("2","Procesador INTEL");
INSERT INTO peces VALUES ("3","Grafica NVIDIA");

INSERT INTO contiene VALUES ("HP","1");
INSERT INTO contiene VALUES ("HP","3");
INSERT INTO contiene VALUES ("LEN","2");
INSERT INTO contiene VALUES ("Asu","2");
INSERT INTO contiene VALUES ("Asu","1");

CREATE TABLE fabricantes (
  id number PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE productos (
  id number PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL,
  precio number NOT NULL,
  id_fabricante number NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id)
);

------------------------------------------------------
CREATE TABLE plataformes(

    codi CHAR(4), 

    nom VARCHAR2(30),

    CONSTRAINT pk_plataformes PRIMARY KEY (codi)

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

        FOREIGN KEY (codiPlataforma) REFERENCES plataformes(codi)

); 

NSERT INTO plataformes VALUES('cpc', 'Amstrad CPC');

INSERT INTO plataformes VALUES('pcw', 'Amstrad PCW');

INSERT INTO plataformes VALUES('msx', 'MSX');

INSERT INTO plataformes VALUES('spec', 'Sinclair ZX Spectrum');

INSERT INTO plataformes VALUES('psx', 'Playstation');

INSERT INTO plataformes VALUES('ps2', 'Playstation 2');

INSERT INTO plataformes VALUES('ps3', 'Playstation 3');

INSERT INTO plataformes VALUES('ps4', 'Playstation 4');

INSERT INTO plataformes VALUES('ps5', 'Playstation 5');

INSERT INTO plataformes VALUES('wii', 'Nintendo WII');

INSERT INTO plataformes VALUES('stea', 'PC + Steam');

INSERT INTO plataformes VALUES('epic', 'PC + Epic');



INSERT INTO jocs VALUES('efre', 'Electro Freddy', 1982, NULL, 0.2, 'cpc');

INSERT INTO jocs VALUES('mmic', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'cpc');

INSERT INTO jocs VALUES('mmiz', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'spec');

INSERT INTO jocs VALUES('aa', 'Ant Attack', 1983, NULL, 0.1, 'spec');

INSERT INTO jocs VALUES('ikaw', 'Ikari Warriors', 'Disparos, vista cenital', 1986, 0.2, 'msx');

INSERT INTO jocs VALUES('wsr', 'Wii Sports Resort', 2009, 0, NULL, 'wii');

INSERT INTO jocs VALUES('gt5', 'Gran Turismo 5', 2010, 0, NULL, 'ps3');

INSERT INTO jocs VALUES('last1', 'The last of US', 2013, NULL, NULL, 'ps3');

INSERT INTO jocs VALUES('fortn', 'Fortnite', 'FPS + Battle Royale', 2017, NULL, 'epic');

INSERT INTO jocs VALUES('aliso', 'Alien: Isolation', NULL, 2017, 35000, 'epic');

INSERT INTO jocs VALUES('cont', 'Control', 'Aventura', 2019, NULL, 'epic');

INSERT INTO jocs VALUES('batao', 'Batman: A.O.', NULL, 2013, 18250, 'stea');



CREATE TABLE country (
  Code VARCHAR2(3),
  Name VARCHAR2(52) NOT NULL,
  Continent VARCHAR2(20) NOT NULL,
  Region VARCHAR2(26) NOT NULL DEFAULT '',
  SurfaceArea NUMBER(10,2) NOT NULL DEFAULT '0.00',
  IndepYear NUMBER(5),
  Population NUMBER(12) NOT NULL,
  LifeExpectancy NUMBER(3,1),
  GNP NUMBER(10,2),
  GNPOld NUMBER(10,2),
  LocalName VARCHAR2(45) NOT NULL DEFAULT '',
  GovernmentForm VARCHAR2(45) NOT NULL DEFAULT '',
  HeadOfState VARCHAR2(60) DEFAULT NULL,
  Capital NUMBER(12),
  Code2 CHAR2(2) NOT NULL,
  PRIMARY KEY (Code)
);

CREATE TABLE countrylanguage (
  CountryCode VARCHAR2(3),
  Language VARCHAR2(30),
  IsOfficial CHAR(1),
  Percentage NUMBER(4,1),
  PRIMARY KEY (CountryCode,Language),
  CONSTRAINT countryLanguage_ibfk_1 FOREIGN KEY (CountryCode) REFERENCES country (Code)
);

-- 1. Muestra los nombres de los idiomas que aparecen en la base de datos, sin duplicados, ordenados alfabéticamente.
 SELECT DISTINCT Language FROM countrylanguage ORDER BY Language;

-- 2. Muestra la cantidad de veces que aparece cada idioma.
SELECT COUNT(*), Language FROM countrylanguage GROUP BY Language;
 
-- 3. Muestra el nombre de cada país junto con la cantidad de idiomas que nos consta que se hablan en él 
--(incluso si para alguno no conocemos ningún idioma).
SELECT country.Name, COUNT(countrylanguage.Language) FROM country
LEFT JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
GROUP BY country.Name;


-- 4. Muestra el nombre del idioma que más veces aparece en nuestra base de datos (sin usar LIMIT/FETCH)
SELECT Language, COUNT(*) as cantidad_de_veces
FROM countrylanguage
GROUP BY Language
HAVING COUNT(*) = (
  SELECT MAX(cantidad)
  FROM (
    SELECT COUNT(*) as cantidad
    FROM countrylanguage
    GROUP BY Language
  )
);


-- 5. Muestra el nombre del idioma que más veces aparece en nuestra base de datos.
--5. Muestra el nombre de los dos idiomas que más veces aparecen en nuestra base de datos.
SELECT Language, COUNT(*) as cantidad_de_veces
FROM countrylanguage
GROUP BY Language
ORDER BY COUNT(*) DESC
FETCH FIRST 2 ROWS ONLY;


-- 6. Muestra el nombre del país en el que se hablan más idiomas distintos.
 SELECT Name, COUNT(DISTINCT Language) FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
GROUP BY Name
ORDER BY COUNT(DISTINCT Language) DESC
FETCH FIRST 1 ROW ONLY;

-- 7. Muestra los países que se llamen igual que algún idioma, si es que existen.
SELECT country.Name
FROM country
JOIN countrylanguage ON country.Name = countrylanguage.Language;


-- 8. Muestra los nombres de idiomas que no aparezcan repetidos.
 SELECT DISTINCT Language FROM countrylanguage;

-- 9. Muestra la cantidad de personas que hablan cada idioma en cada país, multiplicando el porcentaje de uso del idioma por la población del país (y dividiendo entre 100). Muestra el resultado ordenado por nombre de país y nombre de idioma.
SELECT country.Name, countrylanguage.Language, 
       (country.Population * countrylanguage.Percentage / 100) FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
ORDER BY country.Name, countrylanguage.Language;
 
-- 10. Muestra la cantidad de idiomas que se hablan en cada continente.
SELECT country.Continent, COUNT(DISTINCT countrylanguage.Language) FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
GROUP BY country.Continent;
-----------------------------------------------------------------------------
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

--Crea un script PL/SQL que empre cursors per a obtindre la següent informació a partir de 
--la nostra base de dades de jocs i plataformes: per a cadascuna de les plataformes, es mostrarà 
--el seu nom i la quantitat de jocs que tenim emmagatzemats. En cas que aqueixa quantitat siga
--0 per a alguna plataforma, no es mostrarà el número 0, sinó el text "Cap". Usa un bucle WHILE, 
--com en l'exemple anterior

--Mostra les quatre primeres lletres de 
--la plataforma el codi de la qual és 
--"psx", després de convertir-les a 
--minúscules. Primer hauràs d'obtindre
--el nom de la plataforma i després 
--bolcar a una variable auxiliar el 
--resultat de convertir-lo a minúscules
-- i d'extraure les seues 4 primeres 
--lletres. Inclou un comentari de 
--diverses línies, que permeta recordar 
--posteriorment què estaves practicant 
--en aquest exercici.

INSERT INTO plataformes VALUES('cpc', 'Amstrad CPC');
INSERT INTO plataformes VALUES('pcw', 'Amstrad PCW');
INSERT INTO plataformes VALUES('msx', 'MSX');
INSERT INTO plataformes VALUES('spec', 'Sinclair ZX Spectrum');
INSERT INTO plataformes VALUES('psx', 'Playstation');
INSERT INTO plataformes VALUES('ps2', 'Playstation 2');
INSERT INTO plataformes VALUES('ps3', 'Playstation 3');
INSERT INTO plataformes VALUES('ps4', 'Playstation 4');
INSERT INTO plataformes VALUES('ps5', 'Playstation 5');
INSERT INTO plataformes VALUES('wii', 'Nintendo WII');
INSERT INTO plataformes VALUES('stea', 'PC + Steam');
INSERT INTO plataformes VALUES('epic', 'PC + Epic');

INSERT INTO jocs VALUES('efre', 'Electro Freddy', 1982, NULL, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmic', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmiz', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'spec');
INSERT INTO jocs VALUES('aa', 'Ant Attack', 1983, NULL, 0.1, 'spec');
INSERT INTO jocs VALUES('ikaw', 'Ikari Warriors', 'Disparos, vista cenital', 1986, 0.2, 'msx');
INSERT INTO jocs VALUES('wsr', 'Wii Sports Resort', 2009, 0, NULL, 'wii');
INSERT INTO jocs VALUES('gt5', 'Gran Turismo 5', 2010, 0, NULL, 'ps3');
INSERT INTO jocs VALUES('last1', 'The last of US', 2013, NULL, NULL, 'ps3');
INSERT INTO jocs VALUES('fortn', 'Fortnite', 'FPS + Battle Royale', 2017, NULL, 'epic');
INSERT INTO jocs VALUES('aliso', 'Alien: Isolation', NULL, 2017, 35000, 'epic');
INSERT INTO jocs VALUES('cont', 'Control', 'Aventura', 2019, NULL, 'epic');
INSERT INTO jocs VALUES('batao', 'Batman: A.O.', NULL, 2013, 18250, 'stea');
------------------------------------------------------------------------------------------
DECLARE
v_nom_plataforma VARCHAR2(30);
v_prefix_plataforma VARCHAR2(4);
BEGIN
SELECT nom INTO v_nom_plataforma
FROM plataformes
WHERE codi = 'psx';

v_prefix_plataforma := SUBSTR(v_nom_plataforma, 1, 4);

dbms_output.put_line(v_nom_plataforma);
END;
-------------------------------------------------------------------------------------------
DECLARE 
v_count_jocs_PS3 NUMBER(5);
v_count_jocs_PS4 NUMBER(5);
BEGIN
SELECT COUNT(*) INTO v_count_jocs_PS3 FROM plataformes 
WHERE codi = 'ps3';

SELECT COUNT(*) INTO v_count_jocs_PS4 FROM plataformes 
WHERE codi = 'ps4';
DECLARE
    IF v_count_jocs_PS3 > v_count_jocs_PS4 THEN 
      dbms_output.put_line('Hi ha mes de ps3');
    ELSIF v_count_jocs_PS3 = v_count_jocs_PS4 THEN
      dbms_output.put_line('Hi ha la mateixa quantitat');
    ELSE
      dbms_output.put_line('Hi ha mes de ps4');
    END IF;
END; 
----------------------------------------------------------------------------------------
--Crea un script PL/SQL que escriga en pantalla "Tenim més plataformes amb jocs que 
--plataformes sense jocs", o bé "Tenim més plataformes sense jocs que plataformes amb 
--jocs", segons corresponga.
DECLARE
  v_nom_plataforma_tenim NUMBER(5);
  v_nom_plataforma_NoTenim NUMBER(5);
  v_nom_plataforma NUMBER(5);

BEGIN
  SELECT DISTINCT COUNT(codiPlataforma) INTO v_nom_plataforma_tenim FROM plataformes;
  SELECT COUNT(codiPlataforma) INTO v_nom_plataforma FROM plataformes;

  v_nom_plataforma_NoTenim := v_nom_plataforma - v_nom_plataforma_tenimº;

   IF v_nom_plataforma_tenim > v_nom_plataforma_NoTenim THEN 
      dbms_output.put_line('Hi ha mes de amb plataforma');
    ELSIF v_nom_plataforma_tenim < v_nom_plataforma_NoTenim THEN
      dbms_output.put_line('Hi ha mes de sense plataforma');
    ELSE
      dbms_output.put_line('Tenen la mateixa cuantitat');
    END IF;
  End if;
END;
--------------------------------------------------------------------------------------------
-- A partir de les dades de la taula de plataformes (de jocs), crea un script que escriba 
--"No tenim dades de plataformes basades en Playstation", "Tenim dades d'1 
--plataforma basada en Playstation", "Tenim dades de 2 plataformes basades en 
--Playstation" o "Tenim dades de més de 2 plataformes basada en Playstation", 
--segons corresponga, emprant CASE.


DECLARE
  quantitat NUMBER(5);

BEGIN 
  SELECT COUNT(*) INTO quantitat FROM jocs WHERE UPPER(nom) LIKE '%Playstation%';


  CASE quantitat
    WHEN 0 THEN
      dbms_output.put_line('No tenim dades de plataformes basades en Playstation');
    WHEN 1 THEN
      dbms_output.put_line('eTnim dades d1 plataforma basada en Playstation');
    ELSE 
      dbms_output.put_line('Tenim mes de 2');
  END CASE;
END;
---------------------------------------------------------------------------------------------
DECLARE
  quantitat NUMBER(5);

BEGIN 
  SELECT COUNT(*) INTO quantitat FROM jocs WHERE codiPlataforma = 'ps3';


  CASE quantitat
    WHEN 0 THEN
      dbms_output.put_line('No tnim jocs');
    WHEN 1 THEN
      dbms_output.put_line('Tenim I joc');
    WHEN 2 THEN
      dbms_output.put_line('Tenim II joc');
    WHEN 3 THEN
      dbms_output.put_line('Tenim III joc');
    WHEN 4 THEN
      dbms_output.put_line('Tenim IV joc');
    WHEN 5 THEN
      dbms_output.put_line('Tenim V joc');
    ELSE 
      dbms_output.put_line('Tenim mogolló de jocs');
  END CASE;
END;

CREATE VIEW vista AS
  SELECT j.codi AS 'JuegoCodi', j.name AS 'JuegoName', descripcio, anyLlancament, 
  espaiOcupatMb, p.codi AS 'PlataformaCodi', p.nom AS 'PlataformaName' 
  FROM jocs j, plataformes j WHERE j.codiPlataforma = p.codi;

SELECT juego.nom, juego.codi, plataforma.nom FROM vista;
-------------------------------------------------------------------------------------------
DECLARE
  quantitat NUMBER(5);
  resposta VARCHAR2(20);

BEGIN 
  SELECT COUNT(*) INTO quantitat FROM jocs WHERE codiPlataforma = 'ps3';

  resposta := CASE quantitat
    WHEN 0 THEN 'No tenim jocs'
    WHEN 1 THEN 'Tenim I joc'
    WHEN 2 THEN 'Tenim II joc'
    WHEN 3 THEN 'Tenim III joc'
    WHEN 4 THEN 'Tenim IV joc'
    WHEN 5 THEN 'Tenim V joc'
    ELSE 'Tenim mogolló de jocs'
  END;
  dbms_output.put_line(resposta);
END;
----------------------------------------------------------------------------------------
DECLARE 
  quantitat NUMBER(5);
  resposta VARCHAR2(20);

BEGIN
  SELECT COUNT(*) INTO quantitat FROM jocs WHERE codiPlataforma = 'ps3';

  resposta := CASE quantitat
    WHEN 0 THEN 'Zero'
    WHEN 1 THEN 'Uno'
    WHEN 2 THEN 'DOS'
    ELSE 'Mes de dos'
  END;

  dbms_output.put_line('Hi ha ' || resposta || 'joc/s');
END;

--------------------------------------------------------------------------------------
DECLARE
  i NUMBER;
BEGIN
  i := 10;
  WHILE i <= 100 LOOP
  dbms_output.put_line(i || ', ');
  i := i + 1;
  END LOOP;
END;

--------------------------------------------------------------------------------------
DECLARE
  i NUMBER;
BEGIN
  i := 10;
  WHILE i >= 1 LOOP
  dbms_output.put_line(i || ', ');
  i := i - 1;
  END LOOP;
END;

--------------------------------------------------------------------------------------
BEGIN
FOR i IN 20 .. 30 LOOP
  dbms_output.put_line(i || ', ');
  END LOOP;
END;

---------------------------------------------------------------------------------------
BEGIN
FOR i IN REVERSE 1 .. 10 LOOP
  dbms_output.put_line(i || ', ');
  END LOOP;
END;

----------------------------------------------------------------------------------------
BEGIN 
  FOR i IN 2 .. 20 LOOP 
  dbms_output.put_line(i*10 || ', ');
  END LOOP;
END;
---------------------------------------------------------------------------------------
DECLARE
  guion VARCHAR2;
BEGIN
  FOR i IN 1 .. 10 LOOP
  guion := guion || '-';
  END LOOP;
  dbms_output.put_line(guion);
END;

-------------------------------------------------------------------------------------------

DECLARE
  v_codi jocs.codi %TYPE;
  v_nom jocs.nom %TYPE;
BEGIN
  SELECT codi, nom INTO v_codi, v_nom
  FROM jocs WHERE codi = 'aa';

  dbms_output.put_line(v_codi || ' ' || v_nom);
END;

---------------------------------------------------------------------------------------
DECLARE
v_joc jocs%ROWTYPE;
BEGIN
SELECT *
INTO v_joc
FROM jocs WHERE codi = 'aa';

dbms_output.put_line(v_joc.codi || ' ' || v_joc.nom);
END;
----------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE EscriureGuions(num_guions IN NUMBER) IS
  v_guions VARCHAR2(2000);
BEGIN
  FOR i IN 1..num_guions LOOP
    v_guions := v_guions || '-';
  END LOOP;

  dbms_output.put_line(v_guions);
END;
-----------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE InserirJoc(codi IN CHAR(5), nom IN VARCHAR2(50),
codiPlataforma IN CHAR 4) IS  
  v_codi CHAR(5);
  v_nom VARCHAR2(50);
  v_codiPlataforma CHAR(5);
  v_countRegistros NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_countRegistros FROM jocs 
  codi = v_codi AND nom = v_nom AND codiPlataforma = v_codiPlataforma;

  IF v_countRegistros > 0 THEN
    dbms_output.put_line('Jocs guardat correctament');

  ELSE THEN
    INSERT INTO jocs VALUES (v_codi, v_nom, '', '', '', v_codiPlataforma);
END InserirJoc;

-----------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE AnyMitja(nom in VARCHAR2(50)) IS
 v_nom VARCHAR2(50);

 v_anyMitja NUMBER;
BEGIN 
  SELECT AVG(anyLlancament) INTO v_anyMitja FROM plataformes, jocs 
  WHERE plataformes.codi = jocs.codiPlataforma AND plataformes.nom = v_nom;

  dbms_output.put_line('La mitjana es' || v_anyMitja);
END;

----------------------------------------------------------------------------------------------------

--Crea un script PL/SQL que empre cursors per a obtindre la següent informació a partir de 
--la nostra base de dades de jocs i plataformes: per a cadascuna de les plataformes, es mostrarà 
--el seu nom i la quantitat de jocs que tenim emmagatzemats. En cas que aqueixa quantitat siga
--0 per a alguna plataforma, no es mostrarà el número 0, sinó el text "Cap". Usa un bucle WHILE, 
--com en l'exemple anterior

SET SERVEROUTPUT ON;

DECLARE
   v_nom_plataforma plataformes.nom%TYPE;
   v_num_jocs NUMBER;
   CURSOR c_plataformes IS
      SELECT codi, nom FROM plataformes;
BEGIN
   LOOP
      FETCH c_plataformes INTO v_nom_plataforma, v_nom_plataforma;
      EXIT WHEN c_plataformes%NOTFOUND;
      
      SELECT COUNT(*) INTO v_num_jocs FROM jocs WHERE codiPlataforma = v_nom_plataforma;
      
      DBMS_OUTPUT.PUT_LINE(v_nom_plataforma || ': ' || NVL(TO_CHAR(v_num_jocs), 'Cap'));
   END LOOP;
   CLOSE c_plataformes;
END;
-----------------------------------------------------------------------------------------------------

--Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i quantitat de jocs o, si és zero, la paraula "Cap"), però en aquesta ocasió hauràs d'utilitzar un bucle LOOP, juntament amb la clàusula EXIT
SET SERVEROUTPUT ON;

DECLARE
   v_nom_plataforma plataformes.nom%TYPE;
   v_num_jocs NUMBER;
BEGIN
   FOR plat IN (SELECT codi, nom FROM plataformes) LOOP
      v_nom_plataforma := plat.nom;

      SELECT COUNT(*) INTO v_num_jocs FROM jocs WHERE codiPlataforma = plat.codi;
      
      DBMS_OUTPUT.PUT_LINE(v_nom_plataforma || ': ' || NVL(TO_CHAR(v_num_jocs), 'Cap'));
      
      IF plat.codi = (SELECT MAX(codi) FROM plataformes) THEN
         EXIT;
      END IF;
   END LOOP;
END;
/
----------------------------------------------------------------------------------------------------------------------
-- Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i quantitat de jocs o, si és zero, la paraula 
--"Cap"), però en aquesta ocasió hauràs d'utilitzar un bucle FOR.

SET SERVEROUTPUT ON;

DECLARE
   v_nom_plataforma plataformes.nom%TYPE;
   v_num_jocs NUMBER;
BEGIN

   FOR plat IN (SELECT codi, nom FROM plataformes) LOOP
      v_nom_plataforma := plat.nom;
      
      SELECT COUNT(*) INTO v_num_jocs FROM jocs WHERE codiPlataforma = plat.codi;
      
      DBMS_OUTPUT.PUT_LINE(v_nom_plataforma || ': ' || NVL(TO_CHAR(v_num_jocs), 'Cap'));
   END LOOP;
END;
/


  

