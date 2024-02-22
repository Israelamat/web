<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php
        $insercion = $pdo->prepare("INSERT INTO videojuegos(titulo, genero, precio)" .
        " VALUES(:titulo, :genero, :precio)");
        $insercion->bindParam(':titulo', $_REQUEST['titulo']);
        $insercion->bindParam(':genero', $_REQUEST['genero']);
        $insercion->bindParam(':precio', $_REQUEST['precio']);
        $insercion->execute();
    
        if ($insercion->execute())
        {
            $insercion->execute();
            $nuevoID = $pdo->lastInserId();
    
            $consulta = $pdo->prepare("SELECT * FROM videojuegos WHERE genero=:genero");
            $consulta->bindParam(':genero', $_REQUEST['genero']);
            $consulta->execute();
            while($registro = $consulta->fetch())
            {
                echo $registro['titulo'];
            }
                }
        else
        {
        // Error
        }
    ?>
    
</body>
</html>