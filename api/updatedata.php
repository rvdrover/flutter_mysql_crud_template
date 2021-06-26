<?php
include 'config.php';
if("UPDATE_PERSON" == $action){
        $id = $_POST['id'];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = $id";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
    ?>