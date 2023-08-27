<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

//$uId = "1702044";
//$uName = "hasan";
//$uNumber = "23489475";
//$assignedHouseID = "18974";


//table column name
$varsityId = "varsity_id";
$fullName= "full_name";
$occupation = "occupation";
$accountNo = "account_no";
$buildingName = "building_name";
$houseNo = "house_no";
$meterNo = "meter_no";
$email = "email";
$isEmailVerified = "is_email_verified";


$varsityIdData = $_POST[$varsityId];

$sqlCreateQuery = "CREATE TABLE IF NOT EXISTS users(
    $varsityId TEXT,
    $fullName TEXT,
    $occupation TEXT,
    $accountNo TEXT,
    $buildingName TEXT,
    $houseNo TEXT,
    $meterNo TEXT,
    $email TEXT,
    $isEmailVerified TEXT,
    CONSTRAINT user_unique_key UNIQUE ($varsityId)
    )";
    $responseOfCreateQuery = $connectionNow->query($sqlCreateQuery);
    if(!$responseOfCreateQuery){
        die("sorry API problem : ".mysql_error());
    }


    else{
        $sqlCheckQuery ="SELECT * FROM users WHERE varsity_id = '$varsityIdData'";
        $responseOfCheckQuery = $connectionNow->query($sqlCheckQuery);
        // Update if...
    
        if($responseOfCheckQuery->num_rows>0){
            $sqlQuery = "DELETE FROM users
            WHERE varsity_id = '$varsityIdData'";
            
            //INSERT INTO `users`(`id`, `name`, `number`, `Assignedhouse`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')
            
            $responseOfUpdateQuery = $connectionNow->query($sqlQuery);
            
            if($responseOfUpdateQuery){
                echo json_encode(array(
                "Success"=>true));
            }
            else{
                echo json_encode(array("Success"=>false,"msg"=>"Cannot DELETE user"));
            }
        }
        //else Insert
        
        else{
            echo json_encode(array("Success"=>false,"msg"=>"No such user"));
        }
}
?>