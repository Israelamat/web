--3. Nombres de todas las marcas, ordenados alfabéticamente.
SELECT DISTINCT nombre FROM motos ORDER BY nombre;

--4. Nombres de todos los modelos, sin duplicados, ordenados alfabéticamente de la Z a la A.
SELECT DISTINCT modelo FROM motos ORDER BY modelo DESC;

--5. Nombre de la marca y nombre del modelo para las motos cuya cilindrada no es 124,9.
SELECT marcas.nombre, motos.modelo FROM motos, marcas
WHERE motos.codigoMarca = marca.codigo AND cilindrada <> 124.9;

--6. Marca y modelo para las motos de las que no conocemos la potencia.
SELECT  marcas.nombre, motos.modelo FROM motos, marcas
WHERE motos.codigoMarca = marca.codigo WHERE potencia IS NULL;

-- 7. Modelo y categoría para las motos de marca “Honda” (quizás con mayúsculas distintas).
SELECT moto.modelo, categorias.nombre FROM motos, categorias, marca
WHERE motos.codigoMarca = marca.codigo
AND motos.codigoCategoria = categoria.codigo
AND UPPER(marcas.nombre) = 'HONDA';

-- 8. Modelo y potencia redondeada sin decimales, para las motos cuya 
--cilindrada es 600.
SELECT modeleo, potencia FROM motos WHERE potencia = 600; 

-- 9. Potencia media de las motos que tenemos registradas en nuestra base de datos.
--Debes usar el alias “potenciaMedia”. 
SELECT AVG(potencia) AS potenciaMedia FROM motos;

-- 10. Cantidad de motos que tenemos de cada cilindrada.
SELECT cilindrada, COUNT(*) FROM motos GROUP BY cilindrada;

-- 11. Cantidad de motos que tenemos de cada categoría, solo 
--por las categorías en las que realmente aparece alguna moto.
SELECT categorias.nombre FROM motos INNER JOIN categorias ON
motos.codigoCategoria = categorias.codigo


SELECT categorias.nom COUNT(*) FROM motos, categorias WHERE  
motos.codigoCategoria = categoria.codigo GROUP BY categorias.nombre;

-- 12. Nombres de las marcas y cantidad de motos que tenemos de cada marca, incluso si en alguna marca no tenemos ninguna moto.
SELECT marcas.nom COUNT(motos.modelo) FROM marcas LEFT OUTER JOIN motos ON  
motos.codigoCategoria = marcas.codigo GROUP BY marcas.nombre;

-- 13. Motos de las marcas Honda o Yamaha, de 2 formas distintas.
SELECT marcas.nombre, motos.modelo FROM  marcas, modelo
WHERE modelos.codigoCategoria = marca.codigo
AND marcas.nombre = "Honda" OR marcas.nombre = 'Yamaha';

SELECT marcas.nombre, motos.modelo FROM  marcas, modelo
WHERE modelos.codigoCategoria = marca.codigo
AND marcas.nombre IN ('Honda', 'Yamaha');

--  14. Motos de la misma marca que la moto más potente que tenemos registrada.
SELECT codigoMarca FROM motos WHERE marca.codigo = (
SELECT codigo, MAX(potencia) FROM motos);

SELECT modelo FROM motos WHERE codigoMarca IN (
    SELECT codigoMarca FROM motos WHERE marca.codigo = (
        SELECT codigo, MAX(potencia) FROM motos)
);

--  15. Motos de la misma marca que la CB125R.
SELECT codigoMarca FROM motos WHERE modelo = 'CB125R';

SELECT modelo FROM motos WHERE codigoMarca IN (
    SELECT codigoMarca FROM motos WHERE modelo = 'CB125R';
)

--  16. Marca y modelo de las motos que pertenecen a alguna marca en la que 
--existe algún modelo de 600 cm3 de cilindrada.
SELECT marca.nombre, motos.modelo FROM marca, motos

SELECT codigoMarca FROM motos WHERE potencia = 600

SELECT modelo FROM  motos WHERE codiMarca IN (
    SELECT codigoMarca FROM motos WHERE potencia = 600
)

SELECT marca.nombre, motos.modelo FROM marca, motos WHERE
marca.codigo = motos.codiMarca AND codiMarca IN (
    SELECT codigoMarca FROM motos WHERE potencia = 600
)

--  17. Marca y modelo de la moto más potente de cada marca, 
--ordenada por marca y modelo.
SELECT codiMarca, MAX(potencia) FROM motos GROUP BY codigoMarca;

SELECT marcas.nombre, MAX(potencia) FROM marcas, motos 
WHERE marcas.codigo = motos.codigoMarca

--  18. Modelos cuya primera letra sea una C, tras quitar los posibles espacios redundantes iniciales y finales. Bonus: modelos cuya segunda letra sea una B.
SELECT modelo FROM motos WHERE UPPER(TRIM(modelo)) LIKE '%C'

SELECT modelo FROM motos WHERE UPPER(TRIM(SUBSTR(modelo, 1, 1)) = 'C'

SELECT modelo FROM motos WHERE UPPER(TRIM(modelo)) LIKE '_b%'

SELECT modelo FROM motos WHERE UPPER(TRIM(SUBSTR(modelo, 1, 1)) = 'B'

-- 19. Muestra todos los códigos que aparecen en la base de datos, ya sean de modelos, de marcas o de categorías.
SELECT  codigo FROM motos UNION
SELECT SELECT codigo FROM marcas
UNION
SELECT SELECT codigo FORM categorias

SELECT codigo FROM(
    SELECT  codigo FROM motos UNION
    SELECT SELECT codigo FROM marcas
    UNION
    SELECT SELECT codigo FORM categorias
) ORDER BY codigo ASC;
-- 20. Marcas en las que aparecen tanto modelos de la categoría “Scooter” como modelos de la categoría “Naked”. 

-- 21. Bonus: marca y modelo de la segunda moto más potente. 

----------------------------------------------------------------------------------------


-- 3. Nombres de todas las marcas, ordenados alfabéticamente.
SELECT nombre FROM marcas ORDER BY nombre;

-- 4. Nombres de todos los modelos, sin duplicados, ordenados alfabéticamente de la Z a la A.
SELECT DISTINCT modelo FROM motos ORDER BY modelo; 

-- 5. Nombre de la marca y nombre del modelo para las motos cuya cilindrada 
--no es 124,9.
SELECT marcas.nombre, motos.modelo FROM motos, marcas 
WHERE marcas.codigo = motos.codigoMarca AND cilindrada <> 124.9; 


-- 6. Marca y modelo para las motos de las que no conocemos la potencia.
SELECT marcas.nombre, motos.modelo FROM marcas, motos 
WHERE marcas.codigo = motos.codigoMarca AND potencia IS NULL;

-- 7. Modelo y categoría para las motos de marca “Honda” 
--(quizás con mayúsculas distintas).
SELECT motos.modelo, categorias.nombre FROM motos, categorias, marcas
WHERE motos.codigoCategoria = categorias.codigo
AND marcas.codigo = motos.codigoMarca
AND UPPER(marcas.nombre) = 'HONDA'; 

-- 8. Modelo y potencia redondeada sin decimales, para las motos cuya 
--cilindrada es 600.
SELECT modelo, potencia FROM motos 
WHERE cilindrada = 600;

-- 9. Potencia media de las motos que tenemos registradas en nuestra 
--base de datos. Debes usar el alias “potenciaMedia”. 
SELECT AVG(potencia) AS 'potenciaMedia' FROM motos;

-- 10. Cantidad de motos que tenemos de cada cilindrada.
SELECT cilindrada, COUNT(*) FROM motos
GROUP BY cilindrada;

-- 11. Cantidad de motos que tenemos de cada categoría, solo por las 
--categorías en las que realmente aparece alguna moto.
SELECT categorias.nombre, COUNT(*) FROM categorias, motos
WHERE motos.codigoCategoria = categorias.codigo
GROUP BY categorias.nombre; 

-- 12. Nombres de las marcas y cantidad de motos que tenemos de cada marca, 
--incluso si en alguna marca no tenemos ninguna moto.
SELECT marcas.nombre, COUNT(motos.modelo) FROM marcas, motos
WHERE marcas.codigo = motos.codigoMarca
GROUP BY marcas.nombre; 

-- 13. Motos de las marcas Honda o Yamaha, de 2 formas distintas.
SELECT motos.modelo FROM motos, marcas 
WHERE marcas.codigo = motos.codigoMarca 
AND UPPER(marcas.nombre) = 'HONDA' OR UPPER(marcas.nombre) = 'YAMAHA';

SELECT motos.modelo FROM motos, marcas 
WHERE marcas.codigo = motos.codigoMarca 
AND UPPER(marcas.nombre) IN ('HONDA', 'YAMAHA');

--  14. Motos de la misma marca que la moto más potente que tenemos registrada.
-- SELECT nombre FROM marcas WHERE codigo IN (
--     SELECT codigoMarca FROM motos WHERE potencia IN (
--         SELECT MAX(potencia) FROM motos;
--     )
-- );

SELECT modelo FROM motos WHERE codigoMarca IN (
    SELECT codigoMarca FROM motos WHERE potencia IN (
         SELECT MAX(potencia) FROM motos;
     ) 
);

--  15. Motos de la misma marca que la CB125R.
SELECT modelo FROM motos WHERE codigoMarca IN (
    SELECT codigoMarca FROM motos WHERE modelo = 'CB125R'
);

--  16. Marca y modelo de las motos que pertenecen a alguna marca en la que 
--existe algún modelo de 600 cm3 de cilindrada.
SELECT marcas.nombre, motos.modelo FROM marcas, motos 
WHERE motos.codigoMarca = marcas.codigo AND marcas.codigo in (
    SELECT codigoMarca FROM motos WHERE cilindrada = 600
);

--  17. Marca y modelo de la moto más potente de cada marca, ordenada 
--por marca y modelo.
SELECT marcas.nombre, motos.modelo FROM marcas, motos 
WHERE motos.codigoMarca = marcas.codigo GROUP BY
marcas.nombre, motos.modelo ORDER BY marcas.nombre, motos.modelo; 

--  18. Modelos cuya primera letra sea una C, tras quitar los posibles 
--espacios redundantes iniciales y finales. Bonus: modelos cuya segunda 
--letra sea una B.
SELECT modelo FROM motos WHERE UPPER(TRIM(modelo)) LIKE 'C%';

SELECT modelo FROM motos WHERE UPPER(TRIM(modelo)) LIKE '_B%';

-- 19. Muestra todos los códigos que aparecen en la base de datos, ya sean de modelos, de marcas o de categorías.
SELECT codigo FROM motos
UNION
SELECT codigo FROM marcas
UNION
SELECT codigo FROM categorias ;
----------------------------------------------------------------------------------
SELECT codigo FROM 
(
    SELECT codigo FROM motos
    UNION
    SELECT codigo FROM marcas
    UNION
    SELECT codigo FROM categorias
)
ORDER BY codigo DESC;

-- 20. Marcas en las que aparecen tanto modelos de la categoría “Scooter” 
--como modelos de la categoría “Naked”.
SELECT nombre FROM marcas WHERE codigo IN ( 
    SELECT codigoMarca FROM motos 
    WHERE (UPPER(modelo) = 'Scooter' OR UPPER(modelo) = 'NAKED')
    
);
-- 21. Bonus: marca y modelo de la segunda moto más potente. 
-----------------------------------------------------------------------------------------------------------------
-- 1. Nombre de cada ciudad y nombre del país al que pertenece, ordenado por ciudad y , 
--en caso de que dos ciudades se llamen igual, por nombre del país.
SELECT city.Name, country.Name FROM city, country
WHERE city.CountryCode = country.code;
-- 2. Países de los que no tenemos ninguna ciudad, ordenados de forma descendente.
SELECT country.Name FROM country LEFT OUTER JOIN city ON city.CountryCode = country.code
GROUP BY country.Name HAVING COUNT(city.name) = 0 ORDER BY  country.Name; 
-- 3. Países cuyo nombre coincide con el de una ciudad.
SELECT city.Name, country.Name FROM city, country
WHERE city.CountryCode = country.code AND city.Name = country.Name; 
-- 4. Nombre de cada país junto al nombre de su capital, si existe.
SELECT country.name, city.name FROM country LEFT JOIN city
ON country.capital = city.id;
-- 5. País, capital y gobernante, para los países cuyo gobernante tenga 3 o más palabras, ordenado
--por país.
SELECT country.Name, city.name, country.HeadOfState FROM country, city 
WHERE country.code = city.CountryCode AND city.ID = country.Capital AND HeadOfState LIKE "% % %"; 
-- 6. Capitales y nombres de países cuyo producto interior bruto sea inferior a todos los 
--de Europa.
SELECT city.Name, country.Name FROM country, city
WHERE city.ID = country.Capital AND city.CountryCode = country.Code <=(
    SELECT MIN(GNP) FROM country WHERE Continent = "Europe";
);
-- 7. Para cada país: nombre, población y suma de las poblaciones de las ciudades que nos 
--aparecen de ese país.
SELECT country.Name, country.population, SUM(city.population) FROM country, city
WHERE country.Code = city.CountryCode GROUP BY country.Name, country.population;
-- 8. Países cuya población es menos de la mitad de la ciudad más poblada de toda la base de datos.
SELECT Name FROM country WHERE population < (     
    SELECT MAX(population)/2 FROM city
);
-- 9. Capitales que tengan la mitad (o más) de la población de su país.
SELECT city.Name FROM city, country WHERE city.ID = country.Capital
AND country.population >= (
    SELECT population/2 FROM country
);
SELECT country.name, country.population
FROM country WHERE population < 
(
    SELECT MAX(population)/2 FROM city
);
-- 10. Ciudades cuyo nombre está repetido, y nombre de los países en los que están esas ciudades.
SELECT city.name, city.id, country.name 
FROM city, country
WHERE city.CountryCode = country.Code
AND city.name IN
(
    SELECT name FROM city
    GROUP BY name
    HAVING COUNT(*) >= 2
)
ORDER BY city.name, country.name;
-----------------------------------------------------------------------------------------------------

CREATE TABLE articles (
    codi CHAR (5) PRIMARY KEY, 
    nombre VARCHAR2 (60)),
    CONSTRAINT pk_codi PRIMARY KEY (codi)
); 
CREATE TABLE peces (
    codi CHAR (5) PRIMARY KEY, 
    nombre VARCHAR2 (60)),
    CONSTRAINT pk_codi PRIMARY KEY (codi)
);

CREATE TABLE contiene (
    codigo_articles VARCHAR (5), 
    codigo_peces VARCHAR (5),
    PRIMARY KEY (codigo_articulo, codigo_pieza),
    FOREIGN KEY (codigo_articulo) REFERENCES articulos(codigo),
    FOREIGN KEY (codigo_pieza) REFERENCES piezas(codigo),
    CONSTRAINT pk_contiene PRIMARY KEY (codigo_articulo, codigo_articles),
    CONSTRAINT fk_codigo_articulo PRIMARY KEY (codigo_articles),
    CONSTRAINT fk_codigo_pieza PRIMARY KEY (codigo_peces),
);

ALTER TABLE peces ADD COLUMN preu_compra NUMBER(6,2); 

ALTER TABLE conte ADD COLUMN quantitat NUMBER(4);

ALTER TABLE  articles ADD COLUMN nom2 VARCHAR2(100);
ALTER TABLE  articles RANAME COLUMN nom2 TO descripcio VARCHAR2(100);

ALTER TABLE articles DROP COLUMN descripcio;

INSERT INTO peces VALUES('p1', 'Peça 1', 0.26);
INSERT INTO peces VALUES('p2', 'Peça 2', 0.26); 
INSERT INTO peces VALUES('p3', 'Peça 3', 0.26); 
INSERT INTO peces VALUES('p4', 'Peça 4', 0.26);

INSERT INTO articles VALUES(a1, Article 1); 
INSERT INTO articles VALUES (a2, Article 2);

INSERT INTO conte VALUES('a1', 'p1', 4);
INSERT INTO conte VALUES('a1', 'p2', 4);
INSERT INTO conte VALUES('a2', 'p3', 4);
INSERT INTO conte VALUES('a2', 'p4', 4);

SELECT nom FROM pcees WHERE nom LIKE "%4" ORDER BY nom;

SELECT * FROM peces WHERE  preu_compra IS NOT NULL ORDER BY preu_compra DESC;

SELECT nom.peces FROM peces, contiene WHERE  
peces.codi = contiene.codigo_pieza AND contiene.codigo_articles = 'a1' ORDER BY  nom;

SELECT SUM(preu_compra)FROM peces, contiene WHERE
peces.codi = contiene.codigo_pieza AND contiene.codigo_articles = 'a2';

SELECT articles.nom FROM articles, peces, contiene WHERE 
peces.codi = contiene.codigo_peces 
AND articles.codi = contiene.codigo_articles;

SELECT articles.nom FROM articles LEFT OUTER JOIN peces JOIN contiene ON 
peces.codi = contiene.codigo_peces 
WHERE articles.codi = contiene.codigo_articles;

-- 1. Crea les taules corresponents i les restriccions que siguen necessàries, 
--usant la sintaxi de Oracle.

-- 2. Afig un camp que permeta anotar el preu de compra, en la taula de peces. 
--Afig un camp "quantitat" en la relació "conté". 

-- 3. Afig un camp "nom2" a la taula d'articles, i després canvia'l de nom a "descripció".

-- 4. Esborra el camp "descripció".

-- 5. Introdueix les següents dades: Peces (p1, Peça 1, 0.26), (p2, Peça 2, 0.37), (p3, Peça 3, 0.48), (p4, Peça 4, 1.05). Articles (a1, Article 1) i (a2, Article 2). L'article a1 està format per 4 peces p1 i una peça p4. L'article a2 està format per 6 peces p2 i dues peces p4. 

-- 6. Mostra els noms de les peces el nom de les quals acaba en 4, ordenades 
--alfabèticament.

-- 7. Mostra les peces per a les quals sabem el preu de compra, ordenades de 
--la més cara a la més barata.

-- 8. Mostra els noms de les peces que formen l'article a1, ordenades alfabèticament.

-- 9. Calcula el cost de fabricació de l'article a2.

-- 10. Mostra cada article i les peces que conté (fins i tot per als articles 
--dels quals no coneixem peces), ordenat per nom d'article i nom de peça.

SELECT articles.nom FROM articles LEFT OUTER JOIN peces JOIN contiene ON 
peces.codi = contiene.codigo_peces 
WHERE articles.codi = contiene.codigo_articles;


-- 11. Mostra els noms de les peces que actualment no estem usant com a part de 
--cap article.
SELECT peces.nom FROM peces, contiene WHERE peces.codi = contiene.codigo_peces 
AND codigo_articles IS NULL;

-- 12. Mostra els noms dels articles i també els de les peces, tot això ordenat 
--alfabèticament.
SELECT peces.nom, article.nom FROM peces, articles, contiene WHERE 
peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles
ORDER BY peeces.nom, articles.nom;

-- 13. Mostra els noms d'articles que no coincideixen amb el nom de cap peça.
SELECT articles.nom FROM peces, articles, contiene WHERE 
peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles
AND peces.nom <> articles.nom;

-- 14. Mostra el nom dels articles que tenen 2 o més peces.
SELECT articles.nom, COUNT(*) FROM peces, articles, contiene WHERE 
peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles
GROUP BY articles.nom HAVING COUNT(*) >= 2;


-- 15. Mostra el nom de l'article amb el major cost de fabricació.
SELECT articles.nombre
FROM articles
WHERE articles.codi = (
  SELECT MAX(articles.cost)
  FROM articles
)

-- 16. Obtingues els noms de les peces que s'usen en l'article 2 però no en 
--l'article 1.
SELECT peces.nom FROM peces, articles, contiene WHERE 
peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles
AND codigo_articles = "HP"; NOT IN(
    SELECT peces.nom FROM peces, articles, contiene WHERE 
    peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles
    AND codigo_articles = "LEN";
)

-- 17. Mostra els articles en els quals s'usa la peça més cara.
SELECT articles.nom FROM peces, articles, contiene WHERE 
peces.codi = contiene.codigo_peces AND articles.codi = contiene.codigo_articles 
AND codigo_peces IN (
    SELECT peces.codi FROM peces WHERE preu_compra = (
        SELECT MAX(preu_compra) FROM peces
    )
);

-- 18. Mostra el nom de cada article i el nom de cadascun dels seus components. 
--Han d'aparéixer totes les peces, fins i tot les que no s'usen en cap article.
SELECT articles.nom, peces.nom FROM peces LEFT OUTER JOIN articles JOIN contiene ON  
peces.codi = contiene.codigo_peces WHERE articles.codi = contiene.codigo_articles 

-- 19. Mostra la diferència de preu entre la peça més cara i la més barata.
SELECT MAX(preu_compra) - MIN(preu_compra) AS 'Rango de preus ' FROM peces; 

-- 20. Mostra el preu de la segona peça més cara.
SELECT peces.preu
FROM (
  SELECT peces.preu, ROW_NUMBER() OVER (ORDER BY peces.preu DESC) as rank
  FROM peces
) peces
WHERE rank = 2;
--------------------------------------------------------------------------------------------------
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

INSERT INTO fabricantes VALUES(1, 'Asus');
INSERT INTO fabricantes VALUES(2, 'Lenovo');
INSERT INTO fabricantes VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricantes VALUES(4, 'Samsung');
INSERT INTO fabricantes VALUES(5, 'Seagate');
INSERT INTO fabricantes VALUES(6, 'Crucial');
INSERT INTO fabricantes VALUES(7, 'Gigabyte');
INSERT INTO fabricantes VALUES(8, 'Huawei');
INSERT INTO fabricantes VALUES(9, 'Xiaomi');

INSERT INTO productos VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO productos VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO productos VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO productos VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO productos VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO productos VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO productos VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO productos VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO productos VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO productos VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO productos VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 38. Devuelve una lista con el nombre del producto, precio y nombre de 
--fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del 
--fabricante, por orden alfabético.
SELECT productos.nombre, productos.precio, fabricantes.nombre FROM fabricantes, productos
WHERE productos.id_fabricante = fabricantes.id ORDER BY fabricantes.nombre;

--47.  Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de 
--fabricante contenga el carácter w en su nombre.
SELECT productos.nombre, precio FROM fabricantes, productos
WHERE productos.id_fabricante = fabricantes.id AND UPPER(fabricantes.nombre) LIKE '%W%';

-- 55. Calcula el número de valores distintos de identificador de fabricante aparecen en 
--la tabla productos.
SELECT productos.nombre, productos.id, COUNT(*) FROM fabricantes, productos
WHERE productos.id_fabricante = fabricantes.id GROUP BY productos.id, id_fabricante;

--56. Calcula la media del precio de todos los productos.
SELECT ROUND(AVG(precio),3) FROM productos;

--65. Calcula el precio más caro de todos los productos del fabricante Asus.
SELECT MAX(precio) FROM fabricantes, productos
WHERE productos.id_fabricante = fabricantes.id AND 
fabricantes.nombre = 'Asus';

--- 99. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
--de productos que el fabricante Lenovo.
SELECT fabricantes.nombre
FROM fabricantes 
WHERE (
  SELECT COUNT(*)
  FROM productos
  WHERE id_fabricante = (SELECT id FROM fabricantes WHERE nombre = 'Lenovo')
) = (
  SELECT COUNT(*)
  FROM productos
  WHERE id_fabricante = fabricantes.id
) AND fabricantes.nombre <> 'Lenovo';

---- 90. Devuelve los nombres de los fabricantes que tienen productos asociados. 
--(Utilizando ALL o ANY)
SELECT fabricantes.nombre FROM fabricantes, productos
WHERE productos.id_fabricante = fabricantes.id AND id_fabricante NOT IN(
   SELECT id FROM fabricantes
);

-- 83. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
-- 86. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.

-- 87. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.


-- Subconsultas con ALL y ANY

-- 88. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.

-- 89. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 01 - Muestra el nombre de los juegos que ocupan menos de 1 MB.
SELECT nom FROM jocs WHERE espaiOcupatMb < 1;

-- 02 - Datos de las plataformas que comienzan por "PC".
SELECT * FROM plataformes WHERE nom LIKE 'PC%';

-- 03 - Nombre de los juegos cuya plataforma se llama "Nintendo WII" 
--y que no son del año 2010.
SELECT nom FROM jocs WHERE nom = 'Nintendo WII' AND anyLlancament <> 2010;

-- 04 - Nombre de los juegos para los que no sabemos el espacio ocupado, 
--ordenados alfabéticamente.
SELECT nom FROM jocs WHERE espaiOcupatMb IS NULL ORDER BY nom;

-- 05 - Nombres de las plataformas que contienen la palabra "STATION" 
--(quizá con mayúsculas distintas).
SELECT nom FROM plataformes WHERE UPPER(nom) LIKE '%STATION%';

-- 06 - Nombres de los juegos que son de las plataformas "Amstrad CPC" o "MSX", usando IN.
SELECT nom FROM jocs WHERE codiPlataforma IN ('ACPC', 'MSX');

-- 07 - Nombres de los juegos que son de las plataformas "Amstrad CPC" o "MSX", sin usar IN.
SELECT nom FROM jocs WHERE (codiPlataforma = 'ACPC' OR codiPlataforma = 'MSX');

-- 08 - Nombre de cada juego y nombre de la plataforma a la que pertenece, ordenado 
--por juego y (si coincide el nombre del juego) por plataforma.
SELECT j.nom, p.nom AS plataforma FROM jocs j, plataformes p 
ON j.codiPlataforma = p.codi ORDER BY j.nom, p.nom;

-- 09 - Nombre de cada plataforma y cantidad de juegos que tenemos para esa plataforma, 
--incluso si de alguna plataforma no tenemos ningún juego.
SELECT p.nom, COUNT(j.codi) AS numJuegos FROM plataformes p LEFT JOIN jocs j 
ON p.codi = j.codiPlataforma GROUP BY p.nom;

-- 10 - Nombre de cada plataforma y cantidad de juegos que tenemos para esa 
--plataforma, para las plataformas en las que tenemos más de un juego.
SELECT plataformes.nom, COUNT(*) FROM plataformes , jocs 
GROUP BY plataformes.nom HAVING COUNT(*) > 1;  

-- 11 - Nombre de las plataformas para las que no tenemos ningún 
--juego, ordenadas alfabéticamente.
SELECT p.nom FROM plataformes p LEFT JOIN jocs j ON p.codi = j.codiPlataforma 
WHERE j.codi IS NULL ORDER BY p.nom;

-- 12 - Nombre y descripción de los juegos que son para la misma plataforma que 
--el juego más grande que tenemos en nuestra base de datos.
SELECT nom, descripcio FROM jocs, plataformes WHERE jocs.codiPlataforma = plataformes.codi
AND espaiOcupatMb IN (
    SELECT MAX(espaiOcupatMb) FROM jocs
);

-- 13 - Nombre de los juegos que tenemos para más de una plataforma.
SELECT DISTINCT nombre FROM Juegos WHERE codigo IN (
    SELECT codigo FROM Juegos GROUP BY codigo
HAVING COUNT(DISTINCT plataforma) > 1
);

-- 14 - Espacio ocupado por el juego que menos ocupa en cada plataforma.
SELECT jocs.nom, plataformes.nom, MIN(espaiOcupatMb) FROM jocs, plataformes 
WHERE jocs.codiPlataforma = plataformes.codi GROUP BY jocs.nom, plataformes.nom

-- 15 - Nombre del juego (o juegos) que menos ocupaNo en cada una de las plataformas.
SELECT Juegos.plataforma, Juegos.nombre FROM Juegos INNER JOIN (
    SELECT plataforma, MIN(espacio) AS espacio_minimo FROM Juegos 
    GROUP BY plataforma
)
ON Juegos.plataforma = subconsulta.plataforma AND Juegos.espacio = subconsulta.espacio_minimo;


-- 16 - Nombre de todos los juegos que tenemos, sin duplicados, ordenados alfabéticamente.
SELECT DISTINCT nombre FROM Juegos ORDER BY nombre ASC;

-- 17 - Nombre de cada plataforma y año medio de los juegos que tenemos para esa plataforma.
SELECT plataformes.nom, AVG(j.anyLlancament) as mediaAny
FROM plataformes , jocs 
WHERE plataformes.codi = jocs.codiPlataforma
GROUP BY plataformes.nom; 

-- 18 - Nombre de la plataforma más antigua (aquella cuyos juegos son, como media, más antiguos).

SELECT plataforma, AVG(anio) AS anyo_media FROM Juegos GROUP BY plataforma
ORDER BY anio_medio ASC FETCH FIRST ROW ONLY;

-- 19 - Nombre de los juegos y espacio que ocupan, redondeado sin decimales, 
--para aquellos que ocupan menos de 50 MB.
SELECT nombre, ROUND(espacio) AS espacio_redondeado
FROM Juegos
WHERE espacio < 50;

-- 20 - Nombre de las plataformas cuyo código coincida con las 3 primeras letras de su nombre.
SELECT nom FROM plataformes WHERE codi = SUBSTR(nom, 1, 3);

-- 21 - Añade un campo "Categoría" a la tabla de juegos, que podrá contener hasta 20 letras.
ALTER TABLE Juegos ADD categoria VARCHAR2(20);

-- 22 - Añade a la tabla de juegos una restricción de que el año de lanzamiento deba ser superior a 1979.
ALTER TABLE Juegos ADD CONSTRAINT anyo_minimo CHECK (anyo > 1979);

-- 23 - Crea una tabla Valoraciones, con un código de valoración (número, de 5 cifras), 
--que actuará como clave primaria, un código de juego (clave ajena a la tabla de juegos), un texto 
--(hasta 100 letras) y una valoración numérica (hasta 2 cifras antes de la coma decimal, y una cifra después de la coma). 
--Usa sintaxis de Oracle.
CREATE TABLE valoraciones (
    codigo_valoracion NUMBER(5),
    codigo_juego NUMBER(5) REFERENCES Juegos(codigo),
    texto VARCHAR2(100),
    valoracion NUMBER(3,1).
    CONSTRAINT pk_codigo_valoracion PRIMARY KEY (codigo_valoracion),
    CONSTRAINT fk_codigo_juego PRIMARY KEY (codigo_juego)

);

-- 24 - Añade dos datos de ejemplo a la tabla de Valoraciones, indicando valores 
--para todos los datos a excepción del texto, y haciéndolo de 2 formas distintas 
--(una vez empleando los nombres de los campos y otra vez sin detallarlos).
INSERT INTO valoraciones (codiJoc, nomUsuari, puntuacio, dataValoracio)
VALUES ('J0014', 'user1', 8.5, '2022-01-01');

INSERT INTO valoraciones
VALUES ('J0015', 'user2', 7.2, '2022-01-02', NULL);

-- 25 - Crea una tabla Usuarios, con un código de exactamente 5 letras para cada usuario,
-- un nombre y una fecha de alta. El nombre debe ser único y no nulo. Usa sintaxis de Oracle.
CREATE TABLE usuarios(
    codigo CHAR(5),
    nombre VARCHAR2(30) NOT NULL,
    dataAlta Date,
    CONSTRAINT pk_codigo_Usuarios PRIMARY KEY (codigo),
    CONSTRAINT uk_nombre_juego UNIQUE KEY (nombre)
)
-- 26 - Introduce 3 usuarios de ejemplo: en uno no indicarás los nombres de los  campos, 
--en otro indicarás todos los nombres de los campos e introducirás todos 
--los datos, en otro indicarás los nombres de algunos campos e introducirás datos sólo en algunos campos.
INSERT INTO usuarios
VALUES ('U0001', 'user1', '2022-01-01');

INSERT INTO usuarios (codi, nom, dataAlta)
VALUES ('U0002', 'user2', '2022-01-02');

INSERT INTO usuarios (nom)
VALUES ('user3');

-- 27 - Modifica el juego cuyo nombre es 'Batman: A.O.' para que pase a ser 'Batman: Arkham Origins'.
UPDATE jocs SET nom = 'Batman: Arkham Origins'
WHERE nom = 'Batman: A.O.';

-- 28 - Modifica los datos de juegos: si alguno tiene espacio ocupado 0, cámbialo por un valor nulo.
UPDATE jocs SET espaiOcupatMb = NULL
WHERE espaiOcupatMb = 0;

-- 29 - Borra los juegos que sean (a la vez) anteriores a 1982 y para plataformas cuyo nombre comience por "Play".
DELETE FROM jocs WHERE anyLlancament < 1982 AND codiPlataforma LIKE 'Play%';

-- 30 - Muestra los nombres de las plataformas cuyas 4 primeras letras no coinciden con ninguna otra plataforma.
SELECT p1.nom FROM plataformes p1 WHERE NOT EXISTS (
SELECT p2.nom FROM plataformes p2
WHERE p2.nom <> p1.nom AND SUBSTR(p2.nom, 1, 4) = SUBSTR(p1.nom, 1, 4)
);

-- 31 - Nombres de todos los usuarios y nombres de todas las plataformas.
SELECT nom FROM usuarios UNION SELECT nom FROM plataformes;

-- 32 - Nombres de los usuarios que coincidan con el nombre de alguna plataforma.
SELECT usuarios.nom FROM plataformes, usuarios WHERE usuarios.nom = plataformes.nom;

-- 33 - Nombre del juego, nombre de la plataforma y espacio ocupado, para los juegos que ocupen menos que cualquier juego de la plataforma "Amstrad CPC".
SELECT jocs.nombre, plataformes.nom, espaiOcupatMb, FROM plataformes, jocs 
WHERE plataformes.codi = jocs.codiPlataforma AND espaiOcupatMb < ANY(
    SELECT MIN(espaiOcupatMb) FROM jocs WHERE plataformes.nom = 'Amstrad CPC'
);

-- 34 - Nombres de las plataformas para las que el conjunto de todos los juegos que tenemos ocupa menos de 10 MB.
SELECT plataformes.nom FROM plataformes, jocs WHERE plataformes.codi = jocs.codiPlataforma 
GROUP BY plataformes.nom HAVING SUM(jocs.espaiOcupatMb) < 10;

-- 35 - Crea una tabla "JuegosPS3", con parte de los datos (código, nombre y año) de los juegos que tenemos para PS3.
CREATE TABLE juegosPS3 AS
SELECT codi, nom, anyLlancament
FROM jocs
WHERE codiPlataforma = 'PS3';

-- 36 - Borra la tabla de Valoraciones, que hemos decidido que no vamos a utilizar.
DROP TABLE valoraciones;

-- 37 - Añade a la tabla de Juegos un nuevo campo, valoracion, con hasta 2 cifras antes de la coma decimal, y una cifra después de la coma, y que sólo debe aceptar 
--valores entre 0 y 10.
ALTER TABLE jocs
ADD valoracion NUMBER(3,1) CHECK (valoracion >= 0 AND valoracion <= 10);

-- 38 - Asegúrate de que todos los juegos tengan valoración nula y, posteriormente, de que "The Last of Us" para la plataforma "ps3" tiene una valoración de 9.5.
UPDATE jocs
SET valoracion = NULL;

UPDATE jocs
SET valoracion = 9.5
WHERE nom = 'The Last of Us' AND codiPlataforma = 'PS3';

-- 39 - Muestra nombre y espacio ocupado por los juegos que ocupan más que la media de los juegos de su misma plataforma.
SELECT j.nom, j.espaiOcupatMb
FROM jocs j
WHERE j.espaiOcupatMb > (
  SELECT AVG(j2.espaiOcupatMb)
  FROM jocs j2
  WHERE j2.codiPlataforma = j.codiPlataforma
);


-- 40 - Muestra el nombre de cada juego, su descripción y el espacio ocupado, para los juegos que ocupen más del doble de la media de su plataforma.
SELECT j.nom, j.descripcio, j.espaiOcupatMb
FROM jocs j
WHERE j.espaiOcupatMb > (
  SELECT 2 * AVG(j2.espaiOcupatMb)
  FROM jocs j2
  WHERE j2.codiPlataforma = j.codiPlataforma
);







