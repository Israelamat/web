/* Crea un script PL/SQL que empre cursors per a obtindre la següent 
informació a partir de la nostra base de dades de jocs i plataformes: 
mostra el nom de les plataformes per a les quals tenim més jocs que la 
mitjana, així com quants jocs més que la mitjana tenim per a ella. 
Fes-ho amb dues consultes encadenades i emprant un bucle LOOP, 
juntament amb la clàusula EXIT */
DECLARE
    CURSOR c IS
        SELECT p.nom, COUNT(codiPlataforma)
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;
    
    v_nomPlataforma plataformes.nom%TYPE;
    v_quantitatEstaPlat NUMBER;
    
    v_quantitatJocs NUMBER;
    v_quantitatPlataformes NUMBER;
    v_mitjana NUMBER;

BEGIN
    SELECT COUNT(*) INTO v_quantitatJocs FROM jocs;
    SELECT COUNT(*) INTO v_quantitatPlataformes FROM plataformes;
    v_mitjana := v_quantitatJocs / v_quantitatPlataformes;
    -- dbms_output.put_line(' Mitjana: ' ||  v_mitjana);
    
    OPEN c;
    LOOP
        FETCH c INTO v_nomPlataforma, v_quantitatEstaPlat;
        EXIT WHEN c % NOTFOUND;
        -- dbms_output.put_line(v_nomPlataforma || ' - '  || v_quantitatEstaPlat );
        IF v_quantitatEstaPlat > v_mitjana THEN
            dbms_output.put_line(v_nomPlataforma || ': ' 
                || (v_quantitatEstaPlat - v_mitjana));
        END IF;
        FETCH c INTO v_nomPlataforma, v_quantitatEstaPlat;
    END LOOP;
    CLOSE c;
END;

/* Crea una FUNCTION en PL/SQL anomenada NomsDeJocs que reba el nom d'una 
plataforma com a paràmetre i retorne una cadena formada pels noms dels jocs 
d'aqueixa plataforma, tots ells en la mateixa línia i separats per " - ". */

CREATE OR REPLACE FUNCTION NomsDeJocs(nomPlataforma IN plataformes.nom%TYPE)
RETURN VARCHAR2(200) IS 

    CURSOR c_nomJocs IS 
        SELECT jocs.nom FROM jocs INNER JOIN plataformes ON jocs.codiPlataforma = plataformes.codi;
        WHERE plataformes.nom = nomPlataforma ORDER BY jocs.nom;

    v_jocsDePlataforma VARCHAR2(300) := '';
    v_jocs jocs.nom&TYPE;
BEGIN   
    OPEN c_nomJocs:
    LOOP
        FETCH c_nomJocs INTO v_jocs;
        IF c_nomJocs%NOTFOUND THEN
            v_jocsDePlataforma := v_jocsDePlataforma || v_jocs;
        EXIT WHEN c_nomJocs%NOTFOUND;
        v_jocsDePlataforma := v_jocsDePlataforma || v_jocs ||"-";
        END IF;
    END LOOP; 
    c_nomJocs CLOSE;
    RETURN v_jocsDePlataforma;
END NomsDeJocs;

-- 4.- Crea un script PL/SQL que contenga un bloque anónimo, que utilice 
-- un cursor y un bucle LOOP para mostrar los años en los que tenemos 
-- juegos, junto con la cantidad de juegos que tenemos de cada año.
DECLARE 
    CURSOR c_jocs IS    
        SELECT anyLlancament, COUNT(codi) FROM jocs GROUP by anyLlancament ORDER BY anyLlancament;
    v_anyLlancamnet jocs.anyLlancament%TYPE:
    v_quantitatJocs NUMBER;
BEGIN
    OPEN c_jocs;
    LOOP
        FETCH c_jocs INTO v_anyLlancamnet, v_anyLlancamnet;
        EXIT WHEN c_jocs %NOTFOUND;
        dbms_output.put_line("L'any tenim: " || v_anyLlancamnet || "que té: " || v_quantitatJocs || "jocs"); 
    END LOOP;
    CLOSE c_jocs
END;

-- 5.- Crea un script PL/SQL que contenga un bloque anónimo, que utilice 
-- un cursor y un bucle LOOP para mostrar los años en los que tenemos 
-- juegos, junto con la cantidad de juegos que tenemos de cada año. Si 
-- sólo hay un juego, en vez de escribir el número, escribirá "Solo uno". 
-- En caso contrario, escribirá el número.

DECLARE
    CURSOR c_jocs_any IS    
        SELECT anyLlancament, COUNT(codi) FROM jocs
        GROUP BY anyLlancament ORDER BY anyLlancament;
    
    v_anyLlancamnet jocs.anyLlancament%TYPE;
    v_numero_jocs NUMBER;
BEGIN
    OPEN c_jocs_any
        LOOP
            FETCH c_jocs_any INTO v_anyLlancamnet, v_numero_jocs;
            EXIT WHEN c_jocs_any %NOTFOUND
            IF v_numero_jocs >= 1 THEN 
                dbms_output.put_line(anyLlancament || "tiene: Solo uno");
            ELSE
                dbms_output.put_line(anyLlancament || "tiene: " || v_numero_jocs);
            END IF;
        END LOOP;
    CLOSE c_jocs_any
END;

-- Crea un bloc PL/SQL que mostre el nom del primer joc en ordre
-- alfabètic, usant %ROWTYPE

DECLARE
    v_registre jocs %ROWTYPE
BEGIN
    SELECT * INTO v_registre FROM jocs 
    ORDER BY nom FETCH NEXT 1 ROWS ONLY;
    dbms_output.put_line(v_registre.nom);
END;

-- Crea un script PL/SQL que escriga en pantalla "Tenim més plataformes 
-- amb jocs que plataformes sense jocs", o bé "Tenim més plataformes sense 
-- jocs que plataformes amb jocs", segons corresponga.

DECLARE 
    v_plataforms_sense_jocs NUMBER;
    v_plataforms_amb_jocs NUMBER;
    v_quantitatPlataformes NUMBER
BEGIN
    SELECT COUNT(*) INTO v_quantitatPlataformes 
    FROM plataformes;

    SELECT COUNT(DISTINCT codiPlataforma) INTO v_plataforms_amb_jocs FROM jocs 
    WHERE codiPlataforma IS NOT NULL;

    v_plataforms_sense_jocs := v_quantitatPlataformes - v_plataforms_amb_jocs;
END;

-- A partir de les dades de la taula de plataformes (de jocs), crea un 
-- script que escriba "No tenim dades de plataformes basades en 
-- Playstation", "Tenim dades d'1 plataforma basada en Playstation", 
-- "Tenim dades de 2 plataformes basades en Playstation" o "Tenim dades 
-- de més de 2 plataformes basada en Playstation", segons corresponga, 
-- emprant CASE.

DECLARE 
    v_dades_Playstation NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_dades_Playstation FROM plataformes
    WHERE UPPER(SUBSTR(nom, 1, 11)) = 'PLAYSTATION';

    CASE v_dades_Playstation 
        WHEN 0 THEN
            dbms_output.put_line('No');
        END CASE;
    
    IF v_dades_Playstation = 3 THEN 
        dbms_output.put_line()
    ELSIF v_dades_Playstation = 5 THEN
        dbms_output.put_line('funciona elsif elsif elsif elsif elsif elsif elsif elsif elsif')
    END IF;

    FOR num IN REVERSE 1..100 LOOP
    END LOOP

    LOOP 
        EXIT WHEN condicion 
    END LOOP;
    WHILE condicion LOOP
    END LOOP;

    FETCH c_cursor INTO v_campo1, :v_campo2;

   variable := CASE v_dades_Playstation 
        WHEN 0 THEN 'VARIANLE1'
    
    SUBSTR, l

END;

CREATE TABLE CambioDeNombre(
    codigo CHAR(5),
    fecha DATE,
    nombreInicial VARCHAR2(50),
    nombreFinal VARCHAR2(50)
)

CREATE OR REPLACE TRIGGER CambioDeNombre
AFTER UPDATE ON jocs
FOR EACH ROW
    INSERT INTO CambioDeNombre VALUES(:OLD.codi, SYSDATE, :OLD.nom, :NEW.nom);
END;

UPDATE jocs SET nom = 'nuevoNombre' WHERE codi = 'last1';    

SELECT * FROM CambioDeNombre;


    