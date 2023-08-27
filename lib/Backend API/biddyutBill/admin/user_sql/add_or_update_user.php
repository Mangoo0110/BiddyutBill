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

//Post data
$varsityIdData = $_POST[$varsityId];
$fullNameData= $_POST[$fullName];
$occupationData = $_POST[$occupation];
$accountNoData = $_POST[$accountNo];
$buildingNameData= $_POST[$buildingName];
$houseNoData = $_POST[$houseNo];
$meterNoData = $_POST[$meterNo];
$emailData = $_POST[$email];
$isEmailVerifiedData = $_POST[$isEmailVerified];

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
        $sqlQuery = "UPDATE users SET 
        $fullName = '$fullNameData',
        $occupation = '$occupationData',
        $accountNo = '$accountNoData',
        $buildingName = '$buildingNameData',
        $houseNo = '$houseNoData', 
        $meterNo = '$meterNoData', 
        $email = '$emailData', 
        $isEmailVerified = '$isEmailVerifiedData' 
        WHERE varsity_id = '$varsityIdData'";
        
        //INSERT INTO `users`(`id`, `name`, `number`, `Assignedhouse`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')
        
        $responseOfUpdateQuery = $connectionNow->query($sqlQuery);
        
        if($responseOfUpdateQuery){
            echo json_encode(array(
            "Success"=>true,));
        }
        else{
            echo json_encode(array("Success"=>false,"msg"=>"cannot update user"));
        }
    }
    //else Insert
    else{
    echo json_encode(array("Success"=>false));
    $sqlQuery = "INSERT INTO users SET 
    $varsityId = '$varsityIdData', 
    $fullName = '$fullNameData', 
    $occupation = '$occupationData', 
    $accountNo = '$accountNoData', 
    $buildingName = '$buildingNameData', 
    $houseNo = '$houseNoData', 
    $meterNo = '$meterNoData', 
    $email = '$emailData', 
    $isEmailVerified = '$isEmailVerifiedData'";
    //INSERT INTO `users`(`id`, `name`, `number`, `Assignedhouse`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')

    $responseOfInsertQuery = $connectionNow->query($sqlQuery);

    if($responseOfInsertQuery){
        echo json_encode(array(
        "Success"=>true  
    ));
    }
    else{
        
        echo json_encode(array("Success"=>false,"failed to add"=>$varsityIdData));
        //die("sorry API problem : ".mysql_error());
    }
 }
 }
?>