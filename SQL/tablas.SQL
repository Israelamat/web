-- Mascotas

-- Inspirado en "menagerie-db", un ejemplo de la documentación de MySQL

-- Sintaxis de SQLite / MySQL (las fechas fallarán en Oracle si no se usa TO_DATE)

CREATE TABLE mascotas
(
  codigo CHAR(3) PRIMARY KEY,
  nombre VARCHAR(20),
  propietario VARCHAR(20),
  especie VARCHAR(20),
  genero CHAR(1),
  nacimiento DATE
);

CREATE TABLE eventos
(
  codigoMascota CHAR(3),
  fecha DATE,
  tipo VARCHAR(15),
  asistentes NUMERIC(4),
  observaciones VARCHAR(255),
  PRIMARY KEY(codigoMascota, fecha),
  FOREIGN KEY(codigoMascota) REFERENCES mascotas(codigo)
); 

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(20) NOT NULL,
  valoracion NUMERIC(3,1),
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado NUMERIC(6) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellido1 VARCHAR(30) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe NUMERIC(6) DEFAULT NULL,
  puesto VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) 
  REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) 
  REFERENCES empleado (codigo_empleado)
);
