<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverhost, $user, $password, $database);
header("Access-Control-Allow-Origin: *");
$varsityId = $_POST['varsity_id'];
$recoveryCode = $_POST['recovery_code'];

// $adminId = "1702062";
// $adminPassword = "1702062";

//query...

$sqlQuery = "SELECT recovery_code FROM admin_password_recovery WHERE varsity_id = '$varsityId'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    while($rowFound = $resultOfQuery->fetch_assoc()){
        if($rowFound["recovery_code"] == $recoveryCode){
            echo json_encode(array(
                "Success"=>true,
                "user code"=>$recoveryCode,
                "database code"=>$rowFound["recovery_code"],
                "Message"=>"Code validated.",
            ));
        }
        else{
            echo json_encode(array(
                "Success"=>false,
                "user code"=>$recoveryCode,
                "database code"=>$rowFound["recovery_code"],
                "Message"=>"Code does not match!!",
            ));
        }  
    }
        
    }
else{
    echo json_encode(array(
        "Success"=>false,
        "Message"=>"Invalid varsityId",
    ));
}


?>