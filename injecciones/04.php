<html>
<head>
    <title>Users list</title>
</head> 
<body>
<?php

// Second approach to SQL injection
if (! isset($_POST["login"]) )
{
    // Show form if no data have been received
?>   
    <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
    Login: <input type="text" name="login"> <br />
    Password: <input type="text" name="pass"> <br />
    <input type="submit" value="Access" ><br/ >
    </form>

<?php 
}
else
{
    // Try to connect and show results if the user has entered data
    $server="localhost";
    $dbuser="root";
    $password="root";
    $link = mysql_connect($server,$dbuser,$password);
 
    if (!($link)) 
    {
        echo "Error connecting to the database.";
        exit();
    } 
  
    if (!mysql_select_db("sqlinjectionexample",$link)) {
        echo "Error selecting the database.";
        exit();
    } 

    $query=mysql_query("SELECT * FROM users WHERE login = '".
        $_POST["login"] . "' AND password = '" .
        $_POST["pass"] . "'", $link);

    $row = mysql_fetch_array($query);
    if (isset($row["login"]))
        echo "<p>Welcome, " . $row["login"] . "</p>";
    else
        echo "<p>Access denied</p>";
    mysql_close($link);
}
?>
</body>
</html>
