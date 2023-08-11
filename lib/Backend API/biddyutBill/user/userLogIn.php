<?php
include '../connection.php';

$adminId = //$_POST['varsity_id'];
$adminPassword = $_POST['admin_password'];

//query...

$sqlQuery = "SELECT * FROM adminAuth WHERE varsityId = '$adminId' AND ipassword = '$adminPassword'";

$resultOfQuery = $connectionNow->query($sqlQuery);

if($resultOfQuery->num_rows == 1){
    
    
    
}
else{
    echo json_encode(array("success"=>false));
}