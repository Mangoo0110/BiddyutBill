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
$sqlQuery = "SELECT * FROM admin_auth WHERE email = '$emailData'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $userEmail = $rowFound["email"];
        if($userEmail==""||$userEmail=="NULL"){
            die(array(
                "Success"=>false,
                "Message"=>"No email address found",
            ));
        }
        $characters = '0123456789abcdefghijklmnopqrstu$#@+vwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$#@+';
        $randstring = '';
        for ($i = 0; $i < 7; $i++) {
            $randstring = $randstring.$characters[rand(0, strlen($characters))];
        }
        //$recoveryCode = $randstring;
        $sqlUpdateQuery = "UPDATE admin_auth SET $otp = '$randstring' WHERE $email = '$emailData'";
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
            $subject = "PSTU Biddyut Bill ADMIN email verification";

            // Message body
            $message = "<html>
                        <head>
                            <title>Verify email</title>
                        </head>
                        <body>
                            <p>Your email verification otp is <h1>$randstring.</h1></p>
                        </body>
                        </html>";

            // Additional headers
            $headers = "MIME-Version: 1.0" . "\r\n";
            $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
            $headers .= "From: arrow360degree@gmail.com\r\n";
            $headers .= "Reply-To: arrow360degree@gmail.com\r\n";

            // Send the email
            if (mail($to, $subject, $message, $headers)) {
                echo json_encode(array(
                    "Success"=>true,
                    "Message"=>"Email sent successfully!",
                ));
                echo "Email sent successfully!";
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
        "Message"=>"Invalid email address!!",
    ));
}


// <?php



