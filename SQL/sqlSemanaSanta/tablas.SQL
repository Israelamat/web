-- A partir d'una taula com aquesta:

-- CREATE TABLE ingredients(
--     codi CHAR(4) PRIMARY KEY, 
--     nom VARCHAR2(30),
--     preuKg NUMBER(7,5)
-- );


-- 1.- Crea un procediment "MostrarMesCars", que mostre els noms i preus dels ingredients el preu dels quals està per damunt de la mitjana.

CREATE OR REPLACE PROCEDURE MostrarMesCars
IS
    CURSOR c_mes_cars IS  
        SELECT nom, preuKg FROM ingredients ORDER BY nom;
    
    v_media_preu NUMBER(7,5);
BEGIN

    SELECT AVG(preuKg) INTO v_media_preu FROM ingredients;

    FOR ingredient IN c_mes_cars LOOP
        IF ingredient.preuKg > v_media_preu THEN
            DBMS_OUTPUT.PUT_LINE(ingredient.nom || ' preu: ' || ingredient.preuKg);
        END IF;
    END LOOP;
END;  


-- 2.- Crea una funció "PreuMitja", que reba com a paràmetre un cert text i retorne el preu mitjà dels ingredients que contenen aqueix text com a part del seu nom (potser amb majúscules diferents). Si no existeix cap, retornarà 0.

CREATE OR REPLACE FUNCTION PreuMitja(textInput IN VARCHAR2) 
RETURN NUMBER IS 
    v_media_preu NUMBER(7,5);

BEGIN
    SELECT AVG(preuKg) INTO v_media_preu FROM ingredients 
    WHERE UPPER(nom) LIKE '%' || UPPER(textInput) ||'%';

    IF v_media_preu IS NOT NULL THEN
        RETURN v_media_preu;
    ELSE  
        RETURN 0;
    END IF;
END;


-- 3.- Usa un cursor i un bucle LOOP per a mostrar els noms dels ingredients per als quals no coneixem el preu, ordenats alfabèticament.

DECLARE
    CURSOR c_preu_null IS   
        SELECT * FROM ingredients WHERE preuKg IS NULL ORDER BY nom;

    v_codi ingredients.codi%TYPE;
    v_nom ingredients.nom%TYPE;
    v_preuKg ingredients.preuKg%TYPE;

BEGIN
    OPEN c_preu_null;
    FETCH c_preu_null INTO v_codi, v_nom, v_preuKg;
    WHILE c_preu_null %FOUND LOOP  
        DBMS_OUTPUT.PUT_LINE(v_nom);
        FETCH c_preu_null INTO v_codi, v_nom, v_preuKg;
    END LOOP;
    CLOSE c_preu_null;
END;


-- 4.- Usa un cursor i un bucle WHILE per a mostrar els noms dels ingredients que tenim repetits (amb igual nom però diferent codi), ordenats alfabèticament.

DECLARE       
    CURSOR c_ingredients_repetits IS  
        SELECT nom FROM ingredients GROUP BY nom HAVING COUNT(*) > 1 ORDER BY nom;
    v_nom ingredients.nom%TYPE;
BEGIN
    OPEN c_ingredients_repetits;
    FETCH c_ingredients_repetits INTO v_nom;
    WHILE c_ingredients_repetits %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_nom);
        FETCH c_ingredients_repetits INTO v_nom;
    END LOOP;
    CLOSE c_ingredients_repetits;
END;


-- 5.- Crea un procediment "MostrarDetalls", que reba com a paràmetre el nom d'un ingredient (potser amb majúscules diferents) i mostre el seu codi, nom i preu, o bé el text "No trobat" en cas que no existisca, o el text "Trobat més d'una vegada" en cas que estiga repetit. Has d'emprar excepcions.

CREATE OR REPLACE PROCEDURE MostrarDetalls (nom_ingredient IN ingredients.nom%TYPE) 
IS    
    CURSOR c_nom_seleccionat IS  
        SELECT codi, nom, preuKg FROM ingredients WHERE UPPER(nom) = UPPER(nom_ingredient);

    v_codi ingredients.codi%TYPE;
    v_nom ingredients.nom%TYPE;
    v_preuKg ingredients.preuKg%TYPE;

    v_num_ingredients NUMBER := 0;
BEGIN 
    OPEN c_nom_seleccionat;
    FETCH c_nom_seleccionat INTO v_codi, v_nom, v_preuKg;
    WHILE c_nom_seleccionat %FOUND LOOP
        v_num_ingredients := v_num_ingredients + 1;
        FETCH c_nom_seleccionat INTO v_codi, v_nom, v_preuKg;
    END LOOP;
    CLOSE c_nom_seleccionat;

    IF v_num_ingredients = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No trobat');
    END IF;
    END LOOP;
END;

EXECUTE MostrarDetalls;







A partir una taula com aquesta:

CREATE TABLE ingredients(
    codi CHAR(4) PRIMARY KEY, 
    nom VARCHAR2(30),
    preuKg NUMBER(7,5)
);


-- 1.- Crea un procediment "MostrarMesCars", que mostre els noms i preus dels 
--ingredients el preu dels quals està per damunt de la mitjana.

CREATE OR REPLACE PROCEDURE MostrarMesCars
IS
    CURSOR c_mes_cars IS  
        SELECT nom, preuKG FROM ingredients ORDER BY nom;
    
    v_media_preu ingredients.preuKG %TYPE;
BEGIN

    SELECT AVG(preuKG) INTO v_media_preu FROM ingredients;

    FOR ingredient IN c_mes_cars LOOP
        IF ingredient.preu > v_media_preu THEN
            DBMS_OUTPUT.PUT_LINE(ingredient.nom || 'preu: ' || ingredient.preuKG);
        END IF;
    END LOOP;
END;  

EXECUTE MostrarMesCars;

-- 2.- Crea una funció "PreuMitja", que reba com a paràmetre un cert text i retorne 
--el preu mitjà dels ingredients que contenen aqueix text com a part del seu nom 
--(potser amb majúscules diferents). Si no existeix cap, retornarà 0.

CREATE OR REPLACE FUNCTION PreuMitja(textInput IN VARCHAR2(100)) 
RETURN NUMBER IS 
    v_media_preu NUMBER;

BEGIN
    SELECT AVG(preuKG) INTO v_media_preu FROM ingredients ORDER BY;
    WHERE UPPER(nom) LIKE '%' || textInput ||'%';

    IF v_media_preu > 0 THEN
        RETURN v_media_preu;
    ELSE  
        RETURN 0;
    END IF;
END;

EXECUTE PreuMitja('frito');

-- 3.- Usa un cursor i un bucle LOOP per a mostrar els noms dels ingredients per als 
--quals no coneixem el preu, ordenats alfabèticament.

DECLARE
    CURSOR c_preu_null IS   
        SELECT * FROM ingredients ORDER BY nom;

    v_codi ingredients.codi %TYPE;
    v_nom ingredients.nom %TYPE;
    v_preuKG ingredients.preuKG %TYPE;

BEGIN
    OPEN c_preu_null;
    FETCH c_preu_null INTO v_codi, v_nom, v_preuKg;
    LOOP  
        EXIT WHEN c_preu_null %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_codi || ' :' || ' ' v_nom || ', '  || v_preuKG);
        FETCH c_preu_null INTO v_codi, v_nom, v_preuKg;
    END LOOP;
    CLOSE c_preu_null;
END;

-- 4.- Usa un cursor i un bucle WHILE per a mostrar els noms dels ingredients que tenim 
--repetits (amb igual nom però diferent codi), ordenats alfabèticament.

DECLARE       
    CURSOR c_ingredients_repetits IS  
        SELECT nom, COUNT(*) AS numRepetits FROM ingredients GROUP BY nom 
        HAVING COUNT(*) >= 1
        ORDER BY nom;
    v_codi ingredients.codi %TYPE;
    v_nom ingredients.nom %TYPE;
    v_preuKG ingredients.preuKG %TYPE;
DECLARE
    OPEN c_ingredients_repetits;
    FETCH c_ingredients_repetits INTO v_nom, v_preuKg;
    WHILE c_ingredients_repetits %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_nom || ', '  || v_preuKG);
        FETCH c_ingredients_repetits INTO  v_nom, v_preuKg;
    END LOOP;
    CLOSE c_ingredients_repetits;
END;

DECLARE
    CURSOR c_ingredientsRepetits IS
        SELECT nom, COUNT(*) AS numRepetits FROM ingredients GROUP BY nom HAVING COUNT(*) > 1 ORDER BY nom;
    v_nom ingredients.nom%TYPE;
    v_numRepetits NUMBER;
BEGIN
    OPEN c_ingredientsRepetits;
    FETCH c_ingredientsRepetits INTO v_nom, v_numRepetits;
    WHILE c_ingredientsRepetits%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_nom || ': ' || v_numRepetits || ' vegades');
        FETCH c_ingredientsRepetits INTO v_nom, v_numRepetits;
    END LOOP;
    CLOSE c_ingredientsRepetits;
END;


-- 5.- Crea un procediment "MostrarDetalls", que reba com a paràmetre el nom d'un 
--ingredient (potser amb majúscules diferents) i mostre el seu codi, nom i preu, o 
--bé el text "No trobat" en cas que no existisca, o el text "Trobat més d'una vegada" 
--en cas que estiga repetit. Has d'emprar excepcions.
CREATE OR REPLACE PROCEDURE MostrarDetalls (nom_ingredient IN ingredients.nom%TYPE) 
IS    
    CURSOR c_nom_selecionat IS  
        SELECT * FROM ingredients ORDER BY nom;
    v_codi ingredients.codi %TYPE;
    v_nom ingredients.nom %TYPE;
    v_preuKG ingredients.preuKG %TYPE;
BEGIN 
    FOR ingredient IN c_nom_selecionat LOOP;
      IF ingredient.nom = nom_ingredient THEN
          DBMS_OUTPUT.PUT_LINE(ingredient.codi || ' :' || ingredient.nom || ', '  || ingredient.preuKG);
      ELSE
          DBMS_OUTPUT.PUT_LINE('No trobat');
      END IF;
    END LOOP;
END;

EXECUTE MostrarDetalls;

---------------------------------------------------------------------------------------------------------
CREATE OR RPLACE 
-- Taula RECEPTES(codi, nom, descripció, tempsMinuts, dificultat)
-- Taula INGREDIENTS (codi, nom, preuKg)
-- Relació INGRED_RECEPTA(codiRecepta, codiIngredient, quantitatKg)

-- 1.- Crea un procediment "MostrarIngredientsOrfes", que mostre els noms dels ingredients que apareixen en la nostra base de dades però que realment no s'utilitzen en cap recepta. Al final 
--haurà de mostrar també el text: "Trobats: XX", on XX serà la quantitat d'ingredients que no s'utilitzen.

CREATE OR REPLACE PROCEDURE MostrarIngredientsOrfes 
IS
    v_num_ingredients_sense_recepta NUMBER := 0;
    
    CURSOR c_ingredients IS 
        SELECT INGREDIENTS.codi, INGREDIENTS.nom FROM INGREDIENTS 
        LEFT OUTER JOIN INGRED_RECEPTA ON INGREDIENTS.codi = INGRED_RECEPTA.codiIngredient
        WHERE codiRecepta IS  NULL; --Si eso hacerlo con group by
BEGIN   
    FOR ingredient IN c_ingredients %FOUND LOOP
        v_num_ingredients_sense_recepta := v_num_ingredients_sense_recepta + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Trobats: ' || v_num_ingredients_sense_recepta);
END;
-- 2.- Crea una funció "QuantitatIngredients" que, a partir del codi de recepta, retorne la quantitat d'ingredients (potser 0) que 
--conté.

CREATE OR REPLACE FUNCTION QuantitatIngredients(codi IN RECEPTES.codi%TYPE)
RETURN NUMBER IN
    v_nombre_ingredients VARCHAR2(50);
    v_quantitat_ingredients NUMBER;
    CURSOR c_quantitat_ingredients IS   
        SELECT RECEPTES.nom as v_nombre_ingredients, COUNT(*) as v_quantitat_ingredients FROM RECEPTES 
        INNER JOIN INGRED_RECEPTA ON RECEPTES.codi = INGRED_RECEPTA.codiRecepta
        GROUP BY RECEPTES.nom
        WHERE RECEPTES.codi = codi;
BEGIN
    FOR ingredient IN c_quantitat_ingredients %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Nom recepta: ' || ingredient.v_nombre_ingredients || 'Numero ingredientes: ' || ingredient.v_quantitat_ingredients);
    END LOOP;
    RETURN v_quantitat_ingredients;
END;

-- 3.- Crea un procediment "MostrarRecepta", que, a partir del codi de recepta, escriga en línies separades el nom, la descripció, el temps en minuts, la dificultat, els noms 
--i quantitats de cadascun dels ingredients, i finalment, el preu de cost.

-- Taula RECEPTES(codi, nom, descripció, tempsMinuts, dificultat)
-- Taula INGREDIENTS (codi, nom, preuKg)
-- Relació INGRED_RECEPTA(codiRecepta, codiIngredient, quantitatKg)

CREATE OR REPLACE FUNCTION PreuRecepta (codi IN RECEPTES.codi%TYPE)
RETURN NUMBER IS
    v_preu_recepta NUMBER;
    v_num_ingredients NUMBER;
    v_quantitat_KG NUMBER;
    v_nombre_ingredients VARCHAR2(50);

    CURSOR c_quantitat_ingredients IS   
        SELECT RECEPTES.nom as v_nombre_ingredients, COUNT(*) as v_quantitat_ingredients FROM RECEPTES 
        INNER JOIN INGRED_RECEPTA ON RECEPTES.codi = INGRED_RECEPTA.codiRecepta
        GROUP BY RECEPTES.nom
        WHERE RECEPTES.codi = codi;
BEGIN
    FETCH c_quantitat_ingredients IN v_nombre_ingredients, v_num_ingredients;
    SELECT preuKG INTO v_quantitat_KG FROM RECEPTES, INGRED_RECEPTA 
    WHERE RECEPTES.codi = INGRED_RECEPTA.codiRecepta AND RECEPTES.codi = codi;

    v_preu_recepta:= v_num_ingredients * v_quantitat_KG;
    RETURN v_preu_recepta;
END;   


CREATE OR REPLACE PROCEDURE MostrarRecepta(codi IN RECEPTES.codi%TYPE)
IS  
    CURSOR c_receptes IS    
        SELECT * FROM RECEPTES 
        WHERE RECEPTES.codi = codi;
        

    v_preu_recepta NUMBER := PreuRecepta(codi);
BEGIN
    FOR recepta IN c_receptes LOOP
        DBMS_OUTPUT.PUT_LINE(recepta.codi || '\n'|| recepta.nom || '\n'|| recepta.tempsMinuts || '\n'|| recepta.dificultat || '\n'|| v_preu_recepta);
    END LOOP;
END;

-- 4.- Crea una taula "CopiaSeguretatIngred", amb la mateixa estructura que "Ingredients" però inicialment buida, i un trigger anomenat "EsborratIngredient", que bolque a 
--aqueixa taula cada ingredient que s'esborre.

CREATE TRIGGER EsborratIngredient
BEFORE DELETE ON Ingredients
FOR EACH ROW
BEGIN
  INSERT INTO CopiaSeguretatIngred (codi, nom, quantitat, unitat_mesura, categoria)
  VALUES (OLD.codi, OLD.nom, OLD.quantitat, OLD.unitat_mesura, OLD.categoria);
END;

-- 5.- Crea una taula "CanvisDePreu", formada per codi d'article, data, preu inicial i preu final, i un trigger "CanviDePreu", que anote la corresponent informació cada 
--vegada que es modifique el preu d'un ingredient.

CREATE TRIGGER CanviDePreu
AFTER UPDATE ON Ingredients
FOR EACH ROW
BEGIN
  IF OLD.preu <> NEW.preu THEN
    INSERT INTO CanvisDePreu (codi_art, data_canvi, preu_inicial, preu_final)
    VALUES (NEW.codi, NOW(), OLD.preu, NEW.preu);
  END IF;
END;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ens han demanat crear una base de dades per a anotar programes informàtics que pertanyen a diferents categories:

-- - Taula CATEGORIA (codi, nom, codCategPare)
-- - Taula PROGRAMA (codi, nom, descripc, codCategoria)

-- Com a dades de prova pots usar (almenys) el següents:

INSERT INTO CATEGORIA VALUES ('so', 'Sistemes operatius', *NULL);
INSERT INTO CATEGORIA VALUES ('soca', 'Sistemes operatius de codi obert', 'so');
INSERT INTO CATEGORIA VALUES ('sop', 'Sistemes operatius propietaris', 'so');

INSERT INTO PROGRAMA VALUES ('wi10', 'Windows 10', 'Windows 10', 'sop');
INSERT INTO PROGRAMA VALUES ('WP55', 'WordPerfect 5.5', NULL, NULL);

-- 1.- Crea una vista PROGRAMESICATEGORIES que permeta saber el nom de cada programa i el nom de la categoria a la qual pertany, ordenats per nom de programa i, en cas de coincidir, per nom de categoria. Afig algunes dades de prova i comprova que es comporta correctament.

-- 2.- Crea un procediment LlistarProgramesICategories, que, per a cada programa, mostre el seu nom i el nom de la categoria a la qual pertany(o "(Sense categoritzar)", si és el cas). Usa en la vista anterior. En el teu cursor, hauràs d'emprar un bucle FOR.

-- 3.- Crea un procediment anomenat LlistarCategories, que, per a cada categoria, escriga el seu codi, el seu nom i, en cas de tractar-se d'una subcategoria d'una altra (existir una categoria pare), el nom de la categoria pare (en cas contrari, no s'escriurà res). En cas de necessitar un bucle, hauràs d'emprar LOOP.

-- 4.- Crea una funció "QuantitatDeSubcategories", que retorne la quantitat de subcategories que existeixen per a una categoria donada, el nom de la qual s'indique com a paràmetre. Per exemple, amb les dades de prova inicials, per a "Sistemes operatius" hauria de retornar 2.

-- 5.- Crea una funció "QuantitatDeProgrames", que, a partir d'un codi de categoria (per exemple, "sop"), retorne la quantitat de programes que tenim d'aqueixa categoria (sense comptar les seues subcategories), en format un text dels següents textos: "Cap", "Un", "Entre 2 i 5" o "Més de 5", Has d'emprar CASE.

-- 6.- Crea un TRIGGER anomenat "CompletarPrograma" que, quan s'inserisca un programa, si la descripció està buida, bolque en ella el mateix text que s'havia introduït per al nom.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE productos (
  codigo VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(30),
  precioCoste NUMBER(7,2)
);

CREATE TABLE categoriasProd (
  codigo VARCHAR(4) PRIMARY KEY,
  nombre VARCHAR(30)
);

CREATE TABLE perteneceA (
  codigoProd VARCHAR(6),
  codigoCateg VARCHAR(4)
  PRIMARY KEY (codigoProd, codigoCateg)
);

-- 6.- Crea un bloque anónimo que muestre el código de cada producto, su nombre y su precio en dólares, suponiendo un cambio de 1 Euro = 1.09 dólares. Debes emplear un bloque WHILE.
DECLARE
    v_codigo productos.codigo%TYPE;
    v_nombre productos.nombre%TYPE;
    v_precioCoste productos.precioCoste%TYPE;

    CURSOR c_productos IS 
    SELECT * FROM  productos;
BEGIN
    OPEN c_productos;
    FETCH c_productos INTO v_codigo, v_nombre, v_precioCoste;
    WHILE c_productos %FOUND LOOP   
        DBMS_OUTPUT.PUT_LINE(v_codigo || ' ' || v_nombre || ' ' || v_precioCoste*1.09);
        FETCH c_productos INTO v_codigo, v_nombre, v_precioCoste;
    END LOOP;
    CLOSE c_productos;
END;



-- 7.- Crea una función "PrecioMedio", que reciba el código de una categoría y devuelva el precio medio de los artículos que hay en esa categoría, o 
---99 en caso de que no haya ningún artículo en esa categoría.

CREATE OR REPLACE FUNCTION PrecioMedio(codigo IN categoriasProdcategoriasProd.codigo%TYPE)
    RETURN NUMBER IS
    v_precioMedio NUMBER;
BEGIN
    SELECT AVG(productos.precioCoste) INTO v_precioMedio FROM 
    productos p, categoriasProd c, perteneceA a WHERE p.codigo = a.codigoProd AND c.codigo = a.codigoCateg
    AND c.codigo = codigo; 

    RETURN v_precioMedio;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(PrecioMedio('c2'));
END;

-- 8.- Crea un procedimiento "MostrarCategoriasYProds", que, sin recibir parámetros, muestre el nombre de cada categoría, y, en la línea siguiente, 
--los nombres de todos los productos que pertenecen a esa categoría, todos ellos en la misma línea, separados por un espacio en blanco.

CREATE OR REPLACE FUNCTION ProductosPorCategoria(codicateg IN NUMBER)
    RETURN VARCHAR2(200) IS
    v_productosPorcateg VARCHAR2(200) := '';
    CURSOR c_prods IS SELECT productos.codigo, productos.nombre FROM productos, perteneceA WHERE productos.codigo = perteneceA.codigoProd
        AND perteneceA.codicateg = codicateg;
    BEGIN
        FOR item IN c_prods LOOP
            v_productosPorcateg := v_productosPorcateg + item.nombre;
        END LOOP;
    END;

CREATE OR REPLACE PROCEDURE MostrarCategoriasYProds
IS
    CURSOR c_mostrarProductos IS 
    SELECT nombre FROM 
    productos p, categoriasProd c, perteneceA a WHERE p.codigo = a.codigoProd AND c.codigo = a.codigoCateg;

    CURSOR c_categoria IS   
        SELECT * FROM categoriasProd;
BEGIN
    FOR itemCateg IN c_categoria LOOP
        DBMS_OUTPUT.PUT_LINE(itemCateg.nombre);
        FOR itemProd IN c_mostrar LOOP
            DBMS_OUTPUT.PUT_LINE(ProductosPorCategoria(itemCateg.codigo));
        END LOOP;
    END LOOP;
END;

EXECUTE MostrarCategoriasYProds;

-- 9.- Crea un trigger llamado "PrecioPorDefecto" que, cuando se guarda un nuevo producto, si no se indica su precio, le asigne precio 10 si es de categoría 1 o precio 15 si es de categoría 2. Si es de cualquier otra categoría, dejará el valor NULL.

-- 10.- Crea un procedimiento "MostrarPreciosMedios", que se apoye en la función "PrecioMedio" para mostrar los precios medios de todas las categorías que tenemos almacenadas.
CREATE OR REPLACE PROCEDURE MostrarPreciosMedios IS 
    CURSOR c_categorias IS  
        SELECT c.codigo, c.nombre FROM categoriasProd c, perteneceA a WHERE c.codigo = a.codicateg;
BEGIN
    FOR item IN c_categoria LOOP
        DBMS_OUTPUT.PUT_LINE(item.nombre || 'Precio medio es: ' || PrecioMedio(item.codigo));
    END LOOP;
END LOOP;