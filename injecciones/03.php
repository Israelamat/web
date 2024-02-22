<html>
<head>
    <title>Users list</title>
</head> 
<body>
<?php
    // First approach to SQL injection
    $server="localhost";
    $dbuser="root";
    $password="root";
    $link = mysql_connect($server,$dbuser,$password);
 
    if (!($link)) 
    {
        echo "Error connecting to the database.";
        exit();
    } 
    else echo "Connection established.<br />";
  
    if (!mysql_select_db("sqlinjectionexample",$link)) {
        echo "Error selecting the database.";
        exit();
    } 
    else echo "Database selected.<br />";

    echo "Fetching users...";
    $query=mysql_query("SELECT * FROM users", $link);

    echo "<ul>";
    while ($row = mysql_fetch_array($query)) 
        echo "<li>" . $row["login"] . "</li>";
    echo "</ul>";
  
    mysql_close($link);
?>
</body>
</html>
