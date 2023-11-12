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
// $adminId = "1702062";
// $adminPassword = "1702062";

//query...
$sqlQuery = "SELECT * FROM user_auth WHERE email = '$emailData'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    //$recoveryCode = array();
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $userEmail = $rowFound["email"];
        if($userEmail==""||$userEmail=="NULL"){
            die(array(
                "Success"=>false,
                "Message"=>"No email address found",
            ));
        }
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$#@+';
        $randstring = '';
        for ($i = 0; $i < 7; $i++) {
            $randstring = $randstring.$characters[rand(0, strlen($characters))];
        }
        //$recoveryCode = $randstring;
        $sqlUpdateQuery = "UPDATE user_auth SET $otp = '$randstring' WHERE $varsityId = '$varsityIdData'";
        $resultOfUpdateQuery = $connectionNow->query($sqlUpdateQuery);
        if(!$resultOfUpdateQuery){
            echo json_encode(array(
                "Success"=>false,
                "Message"=>"Server error",
            ));
        }
        else{
            // Recipient email address
            $to = $userEmail;

            // Subject of the email
            $subject = "PSTU Biddyut Bill user OTP";

            // Message body
            $message = "<html>
                        <head>
                            <title>OTP</title>
                        </head>
                        <body>
                            <p>Your otp is <h1>$randstring.</h1></p>
                        </body>
                        </html>";

            // Additional headers
            $headers = "MIME-Version: 1.0" . "\r\n";
            $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
            //$headers .= "From: arrow360degree@gmail.com\r\n";
            $headers .= "Reply-To: arrow360degree@gmail.com\r\n";

            // Send the email
            if (mail($to, $subject, $message, $headers)) {
                echo json_encode(array(
                    "Success"=>true,
                    "Message"=>"Email sent successfully!",
                ));
            } else {
                echo json_encode(array(
                    "Success"=>false,
                    "Message"=>"Email send failed!!",
                ));
            }
           
            
        }
        
        
    }
    
}
else{
    echo json_encode(array(
        "Success"=>false,
        "Message"=>"Invalid email!!",
    ));
}


// <?php



