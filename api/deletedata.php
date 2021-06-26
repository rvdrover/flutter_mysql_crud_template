<?php
include 'config.php';

if('DELETE_PERSON' == $action){
        $id = $_POST['id'];
        $sql = "DELETE FROM $table WHERE id = $id"; 
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    ?>