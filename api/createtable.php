<?php
include 'config.php';
if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table ( 
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            first_name VARCHAR(30) NOT NULL,
            last_name VARCHAR(30) NOT NULL
            )";
 
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
    ?>