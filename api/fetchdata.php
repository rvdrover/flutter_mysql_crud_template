<?php
include 'config.php';
if("FETCH_DATA" == $action){
        $db_data = array();
        $sql = "SELECT id, first_name, last_name from $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
    ?>