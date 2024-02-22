CREATE TABLE streamers (
  codigo VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(30),
  pais VARCHAR(20)
);
CREATE TABLE tematicas (
  codigo VARCHAR(4) PRIMARY KEY,
  nombre VARCHAR(30)
);
CREATE TABLE hablaSobre (
  codigoStreamer VARCHAR(6),
  codigoTematica VARCHAR(4),
  idioma VARCHAR2(10),
  medio VARCHAR2(20),
  milesSeguidores NUMERIC(6,1),
  PRIMARY KEY (codigoStreamer, codigoTematica)
);

-- 01. Nombre de las temáticas que tenemos almacenadas, ordenadas alfabéticamente.
SELECT * FROM tematicas ORDER BY nombre;

-- 02. Cantidad de streamers cuyo país es "España".
SELECT COUNT(*) AS 'Streamers en España' FROM streamers WHERE pais = 'España';

-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.
SELECT nombre FROM streamers WHERE LOWER(nombre) NOT Like '_b%';

SELECT nombre FROM streamers WHERE LOWER(SUBSTR(nombre, 2,1)) <>'b';

SELECT nombre FROM streamers WHERE nombre LIKE '_[^B]%';

-- 06. Media de suscriptores para los canales cuyo idioma es "Español".
SELECT AVG(milesSeguidores)*1000 FROM hablaSobre WHERE pais = 'España';

-- 07. Media de seguidores para los canales cuyo streamer es del país "España".
SELECT AVG(milesSeguidores)*1000 FROM streamers, hablaSobre WHERE 
streamers.codigo = hablaSobre.codigoStreamer AND pais = 'España';

-- 08. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 
--5.000 y 15.000 miles de seguidores, usando BETWEEN.
SELECT nombre, medio FROM streamers, hablaSobre WHERE 
streamers.codigo = hablaSobre.codigoStreamer AND milesSeguidores BETWEEN 5000 AND 15000;

-- 09. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 
--5.000 y 15.000 miles de seguidores, sin usar BETWEEN.
SELECT nombre, medio FROM streamers, hablaSobre WHERE 
streamers.codigo = hablaSobre.codigoStreamer 
AND milesSeguidores <= 5000 AND milesSeguidores >= 15000;

-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos canales de esa 
--temática (quizá ninguno), sin duplicados.
SELECT tematicas.nombre, hablaSobre.idioma FROM tematicas LEFT OUTER JOIN hablaSobre
ON tematicas.codigo = hablaSobre.codigoTematica;

-- 11. Nombre de cada streamer, nombre de la temática de la que habla y del medio en 
--el que habla de esa temática, usando INNER JOIN.
SELECT s.nombre, t.nombre, h.medio
FROM streamers s
INNER JOIN hablaSobre h ON s.codigo = h.codigoStreamer
INNER JOIN tematicas t ON h.codigoTematica = t.codigo;

-- 12. Nombre de cada streamer, nombre de la temática de la que habla y del medio 
--en el que habla de esa temática, usando WHERE.
SELECT streamers.nombre, tematicas.nombre FROM streamers, tematicas, hablaSobre WHERE
hablaSobre.codigoStreamer = streamers.codigo AND hablaSobre.codigoTematica = tematicas.codigo
GROUP BY tematicas.nombre, hablaSobre.medio;

-- 13. Nombre de cada streamer, del medio en el que habla y de la temática de la que habla 
--en ese medio, incluso si de algún streamer no tenemos dato del medio o de la temática.
SELECT s.nombre, NVL(h.medio, '(Medio desconocido)'), NVL(t.nombre, '(Tema desconocido)')
FROM streamers s
LEFT OUTER JOIN hablaSobre h ON s.codigo = h.codigoStreamer
LEFT OUTER JOIN tematicas t ON h.codigoTematica = t.codigo;


-- 14. Nombre de cada medio y cantidad de canales que tenemos anotados en él, 
--ordenado alfabéticamente por el nombre del medio.
SELECT medio, COUNT(codigoStreamer) FROM hablaSobre GROUP BY medio ORDER BY medio;

-- 15, 16, 17, 18. Medio en el que se emite el canal de más seguidores, de 4 formas distintas.
SELECT medio, streamers.nombre FROM hablaSobre, streamers WHERE 
streamers.codigo, hablaSobre.codigoStreamer AND milesSeguidores(
    SELECT MAX(medio) FROM hablaSobre
);

SELECT medio, streamers.nombre FROM hablaSobre, streamers WHERE 
streamers.codigo, hablaSobre.codigoStreamer ORDER BY milesSeguidores DESC
FECTH FIRTS ROWS ONLY;

SELECT medio, streamers.nombre FROM hablaSobre, streamers WHERE 
streamers.codigo, hablaSobre.codigoStreamer AND milesSeguidores(
    SELECT medio FROM hablaSobre ORDER BY milesSeguidores DESC
    FECTH FIRTS ROWS ONLY
);

-- 19. Categorías de las que tenemos 2 o más canales.
SELECT codigoTematica
FROM hablaSobre
GROUP BY codigoTematica
HAVING COUNT(DISTINCT codigoStreamer) >= 2;


-- 20. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, 
--empleando COUNT.
SELECT t.nombre
FROM tematicas t
LEFT JOIN hablaSobre h ON t.codigo = h.codigoTematica
GROUP BY t.nombre
HAVING COUNT(h.codigoTematica) = 0
ORDER BY t.nombre;

-- 21. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando IN / NOT IN.
SELECT nombre FROM tematicas
WHERE codigo NOT IN (
    SELECT codigoTematica
    FROM hablaSobre
) ORDER BY nombre;
-- 22. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando ALL / ANY.
SELECT nombre FROM tematicas
WHERE codigo = ALL (
    SELECT codigoTematica   
    FROM hablaSobre
) ORDER BY nombre;
-- 23. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando EXISTS / NOT EXISTS.
SELECT nombre FROM tematicas t
WHERE NOT EXISTS (
    SELECT 1 FROM hablaSobre h
    WHERE h.codigoTematica = t.codigo
);

-- 24. Tres primeras letras de cada país y tres primeras letras de cada idioma, en una misma lista.
SELECT SUBSTR(pais, 1, 3) || ' ' || SUBSTR(idioma, 1, 3) AS "Pais-Idioma"
FROM hablaSobre;

-- 25, 26, 27, 28. Tres primeras letras de países que coincidan con las tres primeras letras de un idioma, sin duplicados, de cuatro formas distintas.

--25
SELECT DISTINCT SUBSTR(pais, 1, 3) FROM streamer
WHERE SUBSTR(pais, 1, 3) IN(
    SELECT DISTINCT SUBSTR(idioma, 1, 3) FROM hablaSobre
);
--26
SELECT DISTINCT SUBSTR(pais, 1, 3) FROM streamers
WHERE EXISTS (
    SELECT 1 FROM hablaSobre
    WHERE SUBSTR(idioma, 1, 3) LIKE SUBSTR(pais, 1, 3) || '%'
);

--27
SELECT DISTINCT SUBSTR(pais, 1, 3)
FROM streamers
JOIN hablaSobre ON streamers.codigo = hablaSobre.codigoStreamer
JOIN (
SELECT DISTINCT SUBSTR(idioma, 1, 3) AS idioma
FROM hablaSobre
) i ON SUBSTR(pais, 1, 3) LIKE i.idioma || '%';

--28
SELECT DISTINCT SUBSTR(pais, 1, 3)
FROM streamers
WHERE SUBSTR(pais, 1, 3) IN (
SELECT DISTINCT SUBSTR(idioma, 1, 3)
FROM hablaSobre
)
UNION
SELECT DISTINCT SUBSTR(pais, 1, 3)
FROM streamers
JOIN hablaSobre ON streamers.codigo = hablaSobre.codigoStreamer
JOIN (
SELECT DISTINCT SUBSTR(idioma, 1, 3) AS idioma
FROM hablaSobre
) i ON SUBSTR(pais, 1, 3) LIKE i.idioma || '%';


-- 29. Nombre de streamer, nombre de medio y nombre de temática, para los canales que están por encima de la media de suscriptores.

SELECT s.nombre AS "Nombre Streamer", h.medio AS "Nombre Medio", t.nombre AS "Nombre Temática"
FROM hablaSobre h
JOIN streamers s ON h.codigoStreamer = s.codigo
JOIN tematicas t ON h.codigoTematica = t.codigo
WHERE h.milesSeguidores > (
SELECT AVG(milesSeguidores)
FROM hablaSobre
);
-- 30. Nombre de streamer y medio, para los canales que hablan de la temática "Bricolaje".
SELECT s.nombre AS "Nombre Streamer", h.medio AS "Nombre Medio"
FROM hablaSobre h
JOIN streamers s ON h.codigoStreamer = s.codigo
WHERE h.codigoTematica = (
SELECT codigo
FROM tematicas
WHERE nombre = 'Bricolaje'
);

-- 31. Crea una tabla de "juegos". Para cada juego querremos un código 
--(5 cifras, clave primaria), un nombre (hasta 20 letras, no nulo) y una referencia 
--al streamer que más habla de él (clave ajena a la tabla "streamers"). Usa sintaxis de Oracle.
CREATE TABLE juegos (
codigo NUMBER(5) PRIMARY KEY,
nombre VARCHAR2(20) NOT NULL,
codigoStreamer VARCHAR(6),
FOREIGN KEY (codigoStreamer) REFERENCES streamers(codigo)
);


-- 32. Añade a la tabla de juegos la restricción de que el código debe ser 1000 o superior.
ALTER TABLE juegos
ADD CONSTRAINT codigo_minimo CHECK (codigo >= 1000);

-- 33. Añade 3 datos de ejemplo en la tabla de juegos. Para uno indicarás todos los 
--campos, para otro no indicarás el streamer, ayudándote de NULL, y para el tercero 
--no indicarás el streamer porque no detallarás todos los nombres de los campos.
INSERT INTO hablaSobre VALUES ('STR001', 'TEM001', 'es', 'Twitch', 100.5);
INSERT INTO hablaSobre (codigoStreamer, codigoTematica, idioma, medio) VALUES ('STR002', 'TEM002', 'en', 'YouTube');
INSERT INTO hablaSobre VALUES ('STR003', 'TEM003', 'fr', 'Twitch', 50.0);

-- 34. Borra el segundo dato de ejemplo que has añadido en la tabla de juegos, a 
--partir de su código.
DELETE FROM hablaSobre WHERE codigoStreamer = 'ill';

-- 35. Muestra el nombre de cada juego junto al nombre del streamer que más habla 
--de él, si existe. Los datos aparecerán ordenados por nombre de juego y, en caso de 
--coincidir éste, por nombre de streamer.
SELECT j.nombre, s.nombre
FROM juegos j
LEFT JOIN (
SELECT codigoJuego, codigoStreamer, ROW_NUMBER() OVER(PARTITION BY codigoJuego ORDER BY milesSeguidores DESC) rn
FROM hablaSobre
) hs ON j.codigo = hs.codigoJuego AND hs.rn = 1
LEFT JOIN streamers s ON hs.codigoStreamer = s.codigo
ORDER BY j.nombre, s.nombre;

-- 36. Modifica el último dato de ejemplo que has añadido en la tabla de juegos, 
--para que sí tenga asociado un streamer que hable de él.
UPDATE hablaSobre SET codigoStreamer = 'ill' WHERE codigoStreamer = 'ap';

-- 37. Crea una tabla "juegosStreamers", volcando en ella el nombre de cada juego 
--(con el alias "juego") y el nombre del streamer que habla de él (con el alias "streamer").

CREATE TABLE juegosStreamers AS
SELECT j.nombre AS juego, s.nombre AS streamer
FROM juegos j
LEFT OUTER JOIN streamers s ON j.codigoStreamer = s.codigo;

-- 38. Añade a la tabla "juegosStreamers" un campo "fechaPrueba".
ALTER TABLE juegosStreamers ADD fechaPrueba DATE;

-- 39. Pon la fecha de hoy (prefijada, sin usar SYSDATE) en el campo "fechaPrueba" de 
--todos los registros de la tabla "juegosStreamers".
UPDATE juegosStreamers SET fechaPrueba = TO_DATE('2023-03-09', 'YYYY-MM-DD');

-- 40. Muestra juego, streamer y fecha de ayer (día anterior al valor del campo 
--"fechaPrueba") para todos los registros de la tabla "juegosStreamers".
SELECT juego, streamer, fechaPrueba - 1 AS fechaAyer
FROM juegosStreamers;
-- 41. Muestra todos los datos de los registros de la tabla "juegosStreamers" 
--que sean del año actual de 2 formas distintas (por ejemplo, usando comodines o funciones de cadenas).
--SELECT * FROM juegosStreamers WHERE EXTRACT(YEAR FROM fecha
SELECT * FROM juegosStreamers WHERE fecha LIKE '2023%';
SELECT * FROM juegosStreamers WHERE TO_CHAR(fecha, 'YYYY') = '2023';

-- 42. Elimina la columna "streamer" de la tabla "juegosStreamers".
ALTER TABLE juegosStreamers DROP COLUMN streamer;

-- 43. Vacía la tabla de "juegosStreamers", conservando su estructura.
DELETE FROM juegosStreamers;

-- 44. Elimina por completo la tabla de "juegosStreamers".
DROP TABLE juegosStreamers;

-- 45. Borra los canales del streamer "Caddac Tech".
DELETE FROM streamers WHERE nombre = 'Caddac Tech';

-- 46. Muestra la diferencia entre el canal con más seguidores y la media, mostrada en 
--millones de seguidores. Usa el alias "diferenciaMillones".
SELECT MAX(milesSeguidores) - AVG(milesSeguidores) AS diferenciaMillones FROM hablaSobre;

-- 47. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", 
--sin duplicados, usando IN (pero no en una subconsulta).
SELECT DISTINCT medio FROM hablaSobre WHERE codigoStreamer IN ('ill', 'ng', 'ltt');

-- 48. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", 
--sin duplicados, sin usar IN.
SELECT DISTINCT medio FROM hablaSobre WHERE codigoStreamer = 'ill' OR 
codigoStreamer = 'ng' OR codigoStreamer = 'ltt';

-- 49. Nombre de streamer y nombre del medio en el que habla, para aquellos de 
--los que no conocemos el país.
SELECT streamers.nombre, hablaSobre.medio FROM streamers INNER JOIN hablaSobre 
ON streamers.codigo = hablaSobre.codigoStreamer WHERE streamers.pais IS NULL;

-- 50. Nombre del streamer y medio de los canales que sean del mismo medio que el canal 
--de Ibai Llanos que tiene 12800 miles de seguidores (puede aparecer el propio Ibai Llanos).
SELECT s1.nombre, s1.medio FROM hablaSobre s1 INNER JOIN hablaSobre s2 
ON s1.medio = s2.medio WHERE s2.milesSeguidores = 12800 AND s2.codigoStreamer = 'ill';

-- 51. Nombre del streamer y medio de los canales que sean del mismo medio que el 
--canal de Ibai Llanos que tiene 12800 miles de seguidores (sin incluir a Ibai Llanos).
SELECT s1.nombre, s1.medio FROM hablaSobre s1 INNER JOIN hablaSobre s2 ON 
s1.medio = s2.medio WHERE s2.milesSeguidores = 12800 AND s2.codigoStreamer <> 'ill';

-- 52. Nombre de cada streamer, medio y temática, incluso si para algún streamer 
--no aparece ningún canal o para alguna temática no aparece ningún canal.
SELECT streamers.nombre, hablaSobre.medio, tematicas.nombre FROM streamers CROSS JOIN 
tematicas LEFT OUTER JOIN hablaSobre ON streamers.codigo = hablaSobre.codigoStreamer 
AND tematicas.codigo = hablaSobre.codigoTematica;

-- 53. Nombre de medio y nombre de cada temática, como parte de una única lista 
--(quizá desordenada).
SELECT hablaSobre.medio, tematicas.nombre FROM tematicas INNER JOIN hablaSobre ON 
tematicas.codigo = hablaSobre.codigoTematica;

-- 54. Nombre de medio y nombre de cada temática, como parte de una única lista 
--ordenada alfabéticamente.
SELECT hablaSobre.medio, tematicas.nombre FROM tematicas INNER JOIN 
hablaSobre ON tematicas.codigo = hablaSobre.codigoTematica ORDER BY 
hablaSobre.medio, tematicas.nombre;

-- 55. Nombre de medio y cantidad media de suscriptores en ese medio, para los 
--que están por encima de la media de suscriptores de los canales.
SELECT hablaSobre.medio, AVG(hablaSobre.milesSeguidores) AS mediaSuscriptores FROM 
hablaSobre GROUP BY hablaSobre.medio HAVING AVG(hablaSobre.milesSeguidores) > (
    SELECT AVG(milesSeguidores) FROM hablaSobre);

-- 56. Nombre de los streamers que emiten en YouTube y que o bien hablan en español o bien 
--sus miles de seguidores están por encima de 12.000.
SELECT streamers.nombre FROM streamers INNER JOIN hablaSobre ON 
streamers.codigo = hablaSobre.codigoStreamer WHERE hablaSobre.medio = 'YouTube' 
AND (hablaSobre.idioma = 'español' OR hablaSobre.milesSeguidores > 12000);

-- 57. Añade información ficticia sobre ti: datos como streamer, temática sobre la 
--que supuestamente y medio en el que hablas sobre ella, sin indicar cantidad de 
--seguidores. Crea una consulta que muestre todos esos datos a partir de tu código.
INSERT INTO hablaSobre (codigoStreamer, codigoTematica, idioma, medio) VALUES (
    'IAmat', '0001', 'español', 'Twitch');

SELECT streamers.nombre AS "Streamer", tematicas.nombre AS "Tema", hablaSobre.medio 
AS "Medio" FROM streamers INNER JOIN hablaSobre ON streamers.codigo = hablaSobre.codigoStreamer 
INNER JOIN tematicas ON tematicas.codigo = hablaSobre.codigoTematica 
WHERE streamers.codigo = 'IAmat';

-- 58. Muestra el nombre de cada streamer, medio en el que emite y cantidad de seguidores, 
--en millones, redondeados a 1 decimal.
SELECT s.nombre, h.medio, ROUND(milesSeguidores/1000, 1) AS seguidores
FROM streamers s
JOIN hablaSobre h ON s.codigo = h.codigoStreamer;

-- 59. Muestra el nombre de cada streamer y el país de origen. Si no se sabe este dato, 
--deberá aparecer "(País desconocido)".
SELECT s.nombre AS streamer, COALESCE(s.pais, '(País desconocido)') AS pais
FROM streamers s;

-- 60. Muestra, para cada streamer, su nombre, el medio en el que emite (precedido por "Emite en: ") y el idioma de su canal (precedido por "Idioma: ")
SELECT nombre, CONCAT('Emite en: ', medio) AS medio_emite, CONCAT('Idioma: ', idioma) 
AS idioma_canal FROM hablaSobre JOIN streamers ON hablaSobre.codigoStreamer = streamers.codigo;
