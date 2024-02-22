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
    CONSTRAINT fk_jocs_plataformes 
        FOREIGN KEY (codiPlataforma) REFERENCES plataformes(codi)
); 