<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverhost, $user, $password, $database);
header("Access-Control-Allow-Origin: *");
$varsityId = "varsity_id";
$email = "email";
$isEmailVerified = "is_email_verified";
$otp = "otp";
$password = "pwd";

$emailData = $_POST[$email];
$otpData = $_POST[$otp];

// $adminId = "1702062";
// $adminPassword = "1702062";

//query...

$sqlQuery = "SELECT * FROM user_auth WHERE $email = '$emailData'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows == 1){
    while($rowFound = $resultOfQuery->fetch_assoc()){
        if($rowFound[$otp] == $otpData){
            $userInfo = array();
            $fetchQuery = "SELECT * FROM users WHERE $email = '$emailData'";
            $responseOfFetchQuery = $connectionNow->query($fetchQuery);

            if(!$responseOfFetchQuery){
                die('Could not get data: '.mysqli_error($connectionNow));
            }
            $userInfo = [];
            if($responseOfFetchQuery->num_rows==1){
                //echo json_encode(array("Success"=>true));
                
                while($rowFound = $responseOfFetchQuery->fetch_assoc()){
                    //printf("\n");
                    $userInfo[] = $rowFound; 
                        
                }
                echo json_encode(array(
                    "Success"=>true,
                    "User"=>$userInfo[0]  
                ));
            }
            else {
                $userInfo[] = $varsityIdData;
                echo json_encode(array(
                    "Success"=>false,
                ));
            }
        }
        else{
            echo json_encode(array(
                "Success"=>false,
                "user code"=>$otpData,
                "database code"=>$rowFound[$otp],
                "Message"=>"Code does not match!!",
            ));
        }  
    }
        
    }
else{
    if($resultOfQuery->num_rows == 0){
        echo json_encode(array(
            "Success"=>false,
            "Message"=>"Sorry, bad user!!",
        ));  
    }
    echo json_encode(array(
        "Success"=>false,
        "Message"=>"Sorry, user is not found!!",
    ));
}


?>