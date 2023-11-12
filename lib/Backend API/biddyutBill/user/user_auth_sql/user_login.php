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
$pwd = "pwd";

//post data
$emailData = $_POST[$email];
$pwdData = $_POST[$pwd];

//query...

$sqlQuery = "SELECT * FROM user_auth WHERE $email = '$emailData' AND $pwd = '$pwdData'";

$resultOfQuery = $connectionNow->query($sqlQuery);

if($resultOfQuery->num_rows == 1){
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
    //echo json_encode($resultOfQuery->num_rows);
    // echo json_encode("Error description: " . mysqli_error($connectionNow));
     echo json_encode(array("Success"=>false, "Message"=>$pwdData));
}