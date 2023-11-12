<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverhost, $user, $password, $database);
header("Access-Control-Allow-Origin: *");
$varsityId = "varsity_id";
$email = "email";
$fullName = "full_name";
$isEmailVerified = "is_email_verified";
$otp = "otp";
$password = "pwd";

$varsityIdData = $_POST[$varsityId];
$otpData = $_POST[$otp];

// $adminId = "1702062";
// $adminPassword = "1702062";

//query...

$sqlQuery = "SELECT otp FROM admin_auth WHERE varsity_id = '$varsityId'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    while($rowFound = $resultOfQuery->fetch_assoc()){
        if($rowFound[$otp] == $otpData){
            $sqlAdminFetchQuery = "SELECT * FROM admins WHERE varsity_id = '$adminId'";

            $resultOfsqlAdminFetchQuery = $connectionNow->query($sqlAdminFetchQuery);
            if($resultOfsqlAdminFetchQuery->num_rows == 1){
                $adminRecord = array();
                    while($rowFound = $resultOfsqlAdminFetchQuery->fetch_assoc()){
                        $adminRecord[] = $rowFound;
                        
                    }
            echo json_encode(array(
                "Success"=>true,
                "Admin"=>$adminRecord,
                "user code"=>$recoveryCode,
                "database code"=>$rowFound[$otp],
                "Message"=>"Code validated.",
            ));
        }
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
        "Message"=>"Invalid email",
    ));
}


?>