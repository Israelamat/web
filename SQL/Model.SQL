--A partir de estas tablas y estos inserts:
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
INSERT INTO streamers VALUES ('ill','Ibai Llanos', 'España');
INSERT INTO streamers VALUES ('ap','AuronPlay', 'España');
INSERT INTO streamers VALUES ('ng','Nate Gentile', 'España');
INSERT INTO streamers VALUES ('ltt','Linus Tech Tips', 'Canadá');
INSERT INTO streamers VALUES ('dyip','DYI Perks', NULL);
INSERT INTO streamers VALUES ('ach','Alexandre Chappel', 'Noruega');
INSERT INTO streamers VALUES ('tkn','Tekendo','España');
INSERT INTO streamers VALUES ('cad','Caddac Tech',NULL);
INSERT INTO tematicas VALUES ('inf','Informática');
INSERT INTO tematicas VALUES ('tec','Tecnología en general');
INSERT INTO tematicas VALUES ('gam','Gaming');
INSERT INTO tematicas VALUES ('var','Variado');
INSERT INTO tematicas VALUES ('bri','Bricolaje');
INSERT INTO tematicas VALUES ('via','Viajes');
INSERT INTO tematicas VALUES ('hum','Humor');
INSERT INTO hablaSobre VALUES ('ap','gam','Español','YouTube',29200);
INSERT INTO hablaSobre VALUES ('ill','var','Español','Twitch',12800);
INSERT INTO hablaSobre VALUES ('ap','var','Español','Twitch',14900);
INSERT INTO hablaSobre VALUES ('ng','inf','Español','YouTube',2450);
INSERT INTO hablaSobre VALUES ('ltt','inf','Inglés','YouTube',15200);
INSERT INTO hablaSobre VALUES ('dyip','bri','Inglés','YouTube',4140);
INSERT INTO hablaSobre VALUES ('ach','bri','Inglés','YouTube',370);
INSERT INTO hablaSobre VALUES ('cad','inf','Inglés','YouTube',3);
Hazme las siguientes consultas con sintaxis de oracle en un unico txt:
-- 01. Nombre de las temáticas que tenemos almacenadas, ordenadas alfabéticamente.

-- 02. Cantidad de streamers cuyo país es "España".

-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.

-- 06. Media de suscriptores para los canales cuyo idioma es "Español".

-- 07. Media de seguidores para los canales cuyo streamer es del país "España".

-- 08. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, usando BETWEEN.

-- 09. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, sin usar BETWEEN.

-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos canales de esa temática (quizá ninguno), sin duplicados.

-- 11. Nombre de cada streamer, nombre de la temática de la que habla y del medio en el que habla de esa temática, usando INNER JOIN.

-- 12. Nombre de cada streamer, nombre de la temática de la que habla y del medio en el que habla de esa temática, usando WHERE.

-- 13. Nombre de cada streamer, del medio en el que habla y de la temática de la que habla en ese medio, incluso si de algún streamer no tenemos dato del medio o de la temática.

-- 14. Nombre de cada medio y cantidad de canales que tenemos anotados en él, ordenado alfabéticamente por el nombre del medio.

-- 15, 16, 17, 18. Medio en el que se emite el canal de más seguidores, de 4 formas distintas.

-- 19. Categorías de las que tenemos 2 o más canales.

-- 20. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando COUNT.

-- 21. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando IN / NOT IN.

-- 22. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando ALL / ANY.

-- 23. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando EXISTS / NOT EXISTS.

-- 24. Tres primeras letras de cada país y tres primeras letras de cada idioma, en una misma lista.

-- 25, 26, 27, 28. Tres primeras letras de países que coincidan con las tres primeras letras de un idioma, sin duplicados, de cuatro formas distintas.

-- 29. Nombre de streamer, nombre de medio y nombre de temática, para los canales que están por encima de la media de suscriptores.

-- 30. Nombre de streamer y medio, para los canales que hablan de la temática "Bricolaje".

-- 31. Crea una tabla de "juegos". Para cada juego querremos un código (5 cifras, clave primaria), un nombre (hasta 20 letras, no nulo) y una referencia al streamer que más habla de él (clave ajena a la tabla "streamers"). Usa sintaxis de Oracle.

-- 32. Añade a la tabla de juegos la restricción de que el código debe ser 1000 o superior.

-- 33. Añade 3 datos de ejemplo en la tabla de juegos. Para uno indicarás todos los campos, para otro no indicarás el streamer, ayudándote de NULL, y para el tercero no indicarás el streamer porque no detallarás todos los nombres de los campos.

-- 34. Borra el segundo dato de ejemplo que has añadido en la tabla de juegos, a partir de su código.

-- 35. Muestra el nombre de cada juego junto al nombre del streamer que más habla de él, si existe. Los datos aparecerán ordenados por nombre de juego y, en caso de coincidir éste, por nombre de streamer.

-- 36. Modifica el último dato de ejemplo que has añadido en la tabla de juegos, para que sí tenga asociado un streamer que hable de él.

-- 37. Crea una tabla "juegosStreamers", volcando en ella el nombre de cada juego (con el alias "juego") y el nombre del streamer que habla de él (con el alias "streamer").

-- 38. Añade a la tabla "juegosStreamers" un campo "fechaPrueba".

-- 39. Pon la fecha de hoy (prefijada, sin usar SYSDATE) en el campo "fechaPrueba" de todos los registros de la tabla "juegosStreamers".

-- 40. Muestra juego, streamer y fecha de ayer (día anterior al valor del campo "fechaPrueba") para todos los registros de la tabla "juegosStreamers".

-- 41. Muestra todos los datos de los registros de la tabla "juegosStreamers" que sean del año actual de 2 formas distintas (por ejemplo, usando comodines o funciones de cadenas).

-- 42. Elimina la columna "streamer" de la tabla "juegosStreamers".

-- 43. Vacía la tabla de "juegosStreamers", conservando su estructura.

-- 44. Elimina por completo la tabla de "juegosStreamers".

-- 45. Borra los canales del streamer "Caddac Tech".

-- 46. Muestra la diferencia entre el canal con más seguidores y la media, mostrada en millones de seguidores. Usa el alias "diferenciaMillones".

-- 47. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", sin duplicados, usando IN (pero no en una subconsulta).

-- 48. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", sin duplicados, sin usar IN.

-- 49. Nombre de streamer y nombre del medio en el que habla, para aquellos de los que no conocemos el país.

-- 50. Nombre del streamer y medio de los canales que sean del mismo medio que el canal de Ibai Llanos que tiene 12800 miles de seguidores (puede aparecer el propio Ibai Llanos).

-- 51. Nombre del streamer y medio de los canales que sean del mismo medio que el canal de Ibai Llanos que tiene 12800 miles de seguidores (sin incluir a Ibai Llanos).

-- 52. Nombre de cada streamer, medio y temática, incluso si para algún streamer no aparece ningún canal o para alguna temática no aparece ningún canal.

-- 53. Nombre de medio y nombre de cada temática, como parte de una única lista (quizá desordenada).

-- 54. Nombre de medio y nombre de cada temática, como parte de una única lista ordenada alfabéticamente.

-- 55. Nombre de medio y cantidad media de suscriptores en ese medio, para los que están por encima de la media de suscriptores de los canales.

-- 56. Nombre de los streamers que emiten en YouTube y que o bien hablan en español o bien sus miles de seguidores están por encima de 12.000.

-- 57. Añade información ficticia sobre ti: datos como streamer, temática sobre la que supuestamente y medio en el que hablas sobre ella, sin indicar cantidad de seguidores. Crea una consulta que muestre todos esos datos a partir de tu código.

-- 58. Muestra el nombre de cada streamer, medio en el que emite y cantidad de seguidores, en millones, redondeados a 1 decimal.

-- 59. Muestra el nombre de cada streamer y el país de origen. Si no se sabe este dato, deberá aparecer "(País desconocido)".

-- 60. Muestra, para cada streamer, su nombre, el medio en el que emite (precedido por "Emite en: ") y el idioma de su canal (precedido por "Idioma: ")
israelamatgil@gmail.com
--A partir de estas tablas y estos inserts:
create table categories(
    codi numeric(3) primary key,
    nom varchar(30)
);

create table articles(
    codi varchar(10),
    marca varchar(20),
    model varchar(30),
    preu numeric(6,2),
    codi_categoria numeric(3),
    primary key (codi),
    foreign key (codi_categoria) references categories(codi)
);

-- Introducció de dades d'exemple

insert into categories values(1, 'Ratón gaming');
insert into categories values(2, 'Teclado mecánico');
   
insert into articles values('l203', 'Logitech', 'G203', 47.99, 1);
insert into articles values('rbs', 'Razer', 'Basilisk', 75, 1);
insert into articles values('rbw', 'Razer', 'Blackwidow', 99.99, 2);
insert into articles values('c63', 'Corsair', 'K63', 109.99, 2);

Hazme las siguientes consultas sql con sintaxis de oracle en un unico txt:
1. Dades de les categories.
2. Marca, model i preu dels articles.
3. Marca, model i preu dels articles, el preu dels quals és major que 20 i menor que 100.
4. Marca, model i nom de categoria per a tots els articles.
5. Marca i model dels articles de categoria "Ratón gaming".
6. Marca i model dels articles de categoria "Ratón gaming", la marca del qual comença per L.
7. Marques que comencen per L o per R.
8. Marques que comencen per L o per R, sense duplicats.
9. Marca, model i preu dels articles, ordenats del més car al més barat.
10. Marca, model i nom de categoria per a tots els articles, ordenats per marca, ascendent, i, si coincideix, per model, també ascendent.
Aquí tienes las consultas solicitadas en sintaxis de Oracle:

