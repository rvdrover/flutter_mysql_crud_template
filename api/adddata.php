<?php
include 'config.php';
if("ADD_PERSON" == $action){
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name', '$last_name')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}
    ?>