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
            $to = $emailData;

            // Subject of the email
            $subject = "PSTU Biddyut Bill ADMIN OTP";

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
            $headers .= "From: arrow360degree@gmail.com\r\n";
            $headers .= "Reply-To: arrow360degree@gmail.com\r\n";

            // Send the email
            $sendMail = mail($to, $subject, $message, $headers);
            if ($sendMail) {
                echo json_encode(array(
                    "Success"=>true,
                    "Message"=>"Email sent successfully!",
                ));
               // echo "Email sent successfully!";
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

// $to = "example@domain.com";
// $subject = "This is a test";
// $message = "This is a PHP plain text email example.";
// $headers =
//     "From: hello@mailersend.com" .
//     "\r\n" .
//     "Reply-To: reply@mailersend.com" .
//     "\r\n" .
//     mail($to, $subject, $message, $headers);
// <?php



