<?php

$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$varsityId = "varsity_id";
$fullName= "full_name";
$occupation = "occupation";
$accountNo = "account_no";
$buildingName = "building_name";
$houseNo = "house_no";
$meterNo = "meter_no";
$email = "email";
$pwd = "pwd";
$otp = "otp";
$isEmailVerified = "is_email_verified";
$typeA = "type_a";
$typeB = "type_b";
$typeS = "type_s";

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
$typeAData = $_POST[$typeA]=="true"?1:0;
$typeBData = $_POST[$typeB]=="true"?1:0;//true:false;
$typeSData = $_POST[$typeS]=="true"?1:0;//true:false;

// $typeAData =  filter_var($_POST[$typeA], FILTER_VALIDATE_BOOLEAN);//$_POST[$typeA];//==true?1:0;
// $typeBData = filter_var($_POST[$typeB], FILTER_VALIDATE_BOOLEAN);//==true?1:0;//true:false;
// $typeSData = filter_var($_POST[$typeS], FILTER_VALIDATE_BOOLEAN);//==true?1:0;//true:false;


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
    $typeA BOOLEAN,
    $typeB BOOLEAN,
    $typeS BOOLEAN,
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
        
    $sqlUpdateQuery = "UPDATE users SET 
        $fullName = '$fullNameData',
        $occupation = '$occupationData',
        $accountNo = '$accountNoData',
        $buildingName = '$buildingNameData',
        $houseNo = '$houseNoData', 
        $meterNo = '$meterNoData', 
        $email = '$emailData',
        $typeA = '$typeAData',
        $typeB = '$typeBData',
        $typeS = '$typeSData',
        $isEmailVerified = '$isEmailVerifiedData' 
        WHERE varsity_id = '$varsityIdData'";
                
        $responseOfUpdateQuery = $connectionNow->query($sqlUpdateQuery);
        
        if($responseOfUpdateQuery){
            $sqlQuery = "SELECT * FROM user_auth WHERE varsity_id = '$varsityIdData'";
            //echo json_encode("otp..");
            $characters = '012345$6789abcdefghijklmnopq%rstuvwxyzABCDEFGHIJK#LMNOPQRSTUVWXYZ$%#@';
            $randstring = '';
            $vrfy = 0;
            for ($i = 0; $i < 7; $i++) {
                $randstring = $randstring.$characters[rand(0, strlen($characters))];
            }
            $responseOfSqlQuery = $connectionNow->query($sqlQuery);
            if($responseOfSqlQuery->num_rows==0){
                $sqlUserAuthSettingQuery = "INSERT INTO user_auth SET $varsityId = '$varsityIdData', $pwd = '$randstring', $fullName = '$fullNameData', $email = '$emailData', $isEmailVerified = '$vrfy', $otp = '$randstring'";
                $resultOfUserAuthSettingQuery = $connectionNow->query($sqlUserAuthSettingQuery);
                if(!$resultOfUserAuthSettingQuery){
                    echo json_encode("Error description: " . mysqli_error($connectionNow));
                }  
            }
            else{
                $sqlUserAuthUpdateQuery = "UPDATE user_auth SET  $email = '$emailData', $fullName = '$fullNameData', $isEmailVerified = '$vrfy', $pwd = '$randstring', $otp = '$randstring' WHERE $varsityId = '$varsityIdData'";
                $resultOfUserAuthUpdateQuery = $connectionNow->query($sqlUserAuthUpdateQuery);
            }
            echo json_encode(array(
            "Success"=>true,));
        }
        else{
            echo json_encode(array("Success"=>false,"msg"=>"cannot update user","error"=>mysqli_error($connectionNow)));
        }
    }
    //else Insert
    else{
    $sqlQuery = "INSERT INTO users SET 
    $varsityId = '$varsityIdData', 
    $fullName = '$fullNameData', 
    $occupation = '$occupationData', 
    $accountNo = '$accountNoData', 
    $buildingName = '$buildingNameData', 
    $houseNo = '$houseNoData', 
    $meterNo = '$meterNoData', 
    $email = '$emailData',
    $typeA = '$typeAData',
    $typeB = '$typeBData',
    $typeS = '$typeSData',
    $isEmailVerified = '$isEmailVerifiedData'";

    $responseOfInsertQuery = $connectionNow->query($sqlQuery);
    if($responseOfInsertQuery){
        $sqlQuery = "SELECT * FROM user_auth WHERE varsity_id = '$varsityIdData'";
            $characters = '012345$6789abcdefghijklmnopq%rstuvwxyzABCDEFGHIJK#LMNOPQRSTUVWXYZ$%#@';
            $randstring = '';
            $vrfy = 0;
            for ($i = 0; $i < 7; $i++) {
                $randstring = $randstring.$characters[rand(0, strlen($characters))];
            }
            $responseOfSqlQuery = $connectionNow->query($sqlQuery);
            if($responseOfSqlQuery->num_rows==0){
                
                $sqlUserAuthSettingQuery = "INSERT INTO user_auth SET $varsityId = '$varsityIdData', $email = '$emailData', $fullName = '$fullNameData', $isEmailVerified = '$vrfy', $pwd = '$randstring', $otp = '$randstring'";
                
                $resultOfUserAuthSettingQuery = $connectionNow->query($sqlUserAuthSettingQuery);
                if(!$resultOfUserAuthSettingQuery){
                    echo json_encode(array(
                    "Message"=>"Failed setting user auth",
                    "Success"=>true));
                }
                else{
                    echo json_encode(array(
                        "Message"=>"User auth is created",
                        "Success"=>true));
                }
            }
            else{
                $sqlUserAuthUpdateQuery = "UPDATE user_auth SET  $email = '$emailData', $fullName = '$fullNameData', $isEmailVerified = '$vrfy', $pwd = '$randstring', $otp = '$randstring' WHERE $varsityId = '$varsityIdData'";
                
                $resultOfUserAuthUpdateQuery = $connectionNow->query($sqlUserAuthUpdateQuery);
                echo json_encode(array(
                    "Success"=>true,
                    "Message"=>"User auth updated",
                    ));
            }
        
    }
    else{
        
        echo json_encode(array("Success"=>false,"failed to add"=>$varsityIdData,"error"=>mysql_error()));
    }
 }
 }
?>