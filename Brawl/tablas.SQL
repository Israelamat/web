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

INSERT INTO hablaSobre VALUES ('ill','var','Español','Twitch',12800);;

INSERT INTO hablaSobre VALUES ('ap','var','Español','Twitch',14900);

INSERT INTO hablaSobre VALUES ('ng','inf','Español','YouTube',2450);

INSERT INTO hablaSobre VALUES ('ltt','inf','Inglés','YouTube',15200);

INSERT INTO hablaSobre VALUES ('dyip','bri','Inglés','YouTube',4140);

INSERT INTO hablaSobre VALUES ('ach','bri','Inglés','YouTube',370);

INSERT INTO hablaSobre VALUES ('cad','inf','Inglés','YouTube',3);






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