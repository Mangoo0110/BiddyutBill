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
$emailData = $_POST[$email];
$passwordData = $_POST[$password];

//query...

$sqlQuery = "SELECT * FROM admin_auth WHERE $email = '$emailData' AND $password = '$passwordData'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    $sqlAdminFetchQuery = "SELECT * FROM admins WHERE $email = '$emailData'";

    $resultOfsqlAdminFetchQuery = $connectionNow->query($sqlAdminFetchQuery);
    $adminRecord = [];
    if($resultOfsqlAdminFetchQuery->num_rows == 1){
        
            while($rowFound = $resultOfsqlAdminFetchQuery->fetch_assoc()){
                $adminRecord[] = $rowFound;
                
            }
    echo json_encode(
        array(
            "Success"=>true,
            "Admin"=>$adminRecord[0]
        )
        );
    }
    else{
        echo json_encode(array("Success"=>false));
        
    }
}
else{
    echo json_encode(array("Success"=>false));
}

?>