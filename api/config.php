<?php
 
    $servername = "your servername";
    $username = "your username";
    $password = "your password";
    $dbname = "your database";
    $table = "your table"; 
 
    $action = $_POST["action"];
     
    $conn = new mysqli($servername, $username, $password, $dbname);
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    } 
    ?>
