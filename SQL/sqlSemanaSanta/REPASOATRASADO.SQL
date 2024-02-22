-- Mostra les quatre primeres lletres de la plataforma el codi de la qual 
-- és "psx", després de convertir-les a minúscules. Primer hauràs 
-- d'obtindre el nom de la plataforma i després bolcar a una variable 
-- auxiliar el resultat de convertir-lo a minúscules i d'extraure les 
-- seues 4 primeres lletres. Inclou un comentari de diverses línies, que 
-- permeta recordar posteriorment què estaves practicant en aquest 
-- exercici.

DECLARE
        v_plataformes_psx plataformes.nom%TYPE;

BEGIN
        SELECT nom INTO v_plataformes_psx 
        FROM plataformes WHERE codi = 'psx';

        DBMS_OUTPUT.put_line(SUBSTR(LOWER(v_plataformes_psx), 1, 4));
END;

-- A partir de les dades de la taula de jocs, crea un script que guarde en 
-- una variable la quantitat de jocs que tenim de la plataforma el codi de 
-- la qual és "ps3". En una altra variable, guarda la quantitat de jocs 
-- que tenim de la plataforma el codi de la qual és "ps4". Finalment, 
-- mostra el missatge "Tenim més jocs de PS3 que de PS4" o bé "No tenim 
-- més jocs de PS3 que de PS4", segons corresponga

DECLARE 
        v_quantitat_jocs_ps3 NUMBER;
        v_quantitat_jocs_ps4 NUMBER;      
BEGIN
        SELECT COUNT(*) INTO v_quantitat_jocs_ps3 FROM jocs
        WHERE codi = 'ps3';
        SELECT COUNT(*) INTO v_quantitat_jocs_ps4 FROM jocs
        WHERE codi = 'ps4';
        IF v_quantitat_jocs_ps3 > v_quantitat_jocs_ps4 THEN
            DBMS_OUTPUT.put_line('Tenim mes de ps3');
        ELSE IF v_quantitat_jocs_ps3 < v_quantitat_jocs_ps4 THEN
            DBMS_OUTPUT.PUT_LINE('Tenim mes de ps4');
END;

-------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE EscriureGuions(numero IN NUMBER)
IS 
    guions VARCHAR2(20) := '';
BEGIN
    FOR i IN 1..numero LOOP
        guions := guions || '-';
    END LOOP;

    DBMS_OUTPUT.put_line(guions);
END EscriureGuions;

EXECUTE(EscriureGuions(10));

-----------------------------------------------------------------------------------------------------------
/*
Crea un procediment "InserirJoc", que afija un nou joc a la base de 
dades. Rebrà com a paràmetres el codi del joc, el nom del joc i el codi 
de la plataforma. Si la plataforma no existeix, es limitarà a escriure 
l'avís de "No existeix aqueixa plataforma", i si existeix, guardarà el 
joc i avisarà "Joc guardat correctament".
*/

CREATE OR REPLACE PROCEDURE InserirJoc (
        codiJoc IN CHAR,
        nomJoc IN VARCHAR2,
        codiPlataformaProcedure IN CHAR
        ) 
IS  
    quantitat NUMBER;
BEGIN
    SELECT COUNT(*) INTO quantitat 
    FROM plataformes WHERE codi = codiPlataformaProcedure

    IF quantitat > 0 THEN
        INSERT INTO jocs (codi, nom, codiPlataforma) VALUES (
            codiJoc, nomJoc, codiPlataformaProcedure
        );
        DBMS_OUTPUT.PUT_LINE('Actualizando...');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se puede ');
    END IF;
END InserirJoc;

------------------------------------------------------------------------------------------------------------------------------------------
/* Crea un script PL/SQL que empre cursors per a obtindre la següent 
informació a partir de la nostra base de dades de jocs i plataformes: 
per a cadascuna de les plataformes, es mostrarà el seu nom i la 
quantitat de jocs que tenim emmagatzemats. En cas que aqueixa quantitat 
siga 0 per a alguna plataforma, no es mostrarà el número 0, sinó el 
text "Cap". Usa un bucle WHILE, com en l'exemple. */

DECLARE
    CURSOR jocs_cursor IS
        SELECT p.nom, COUNT(codiPlataforma)
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

    v_nomPlataforma plataformes.nom%TYPE;
    v_quantitat NUMBER;

BEGIN
    OPEN jocs_cursor;

    FETCH jocs_cursor INTO v_nomPlataforma, v_quantitat;
    WHILE jocs_cursor % FOUND LOOP

        IF v_quantitat = 0 THEN
            dbms_output.put_line(v_nomPlataforma || ' - Cap');
        ELSE
            dbms_output.put_line(v_nomPlataforma || ' - ' || v_quantitat);
        END IF;
        FETCH jocs_cursor INTO v_nomPlataforma, v_quantitat;

    END LOOP;

    CLOSE jocs_cursor;
END;
