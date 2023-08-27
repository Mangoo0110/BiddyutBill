<?php
   $serverHost = "localhost";
   $user = "root";
   $password = "";
   $database = "biddyutBill";
   $connectionNow = new mysqli($serverHost,$user,$password,$database);
   header("Access-Control-Allow-Origin: *");

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
    $query = "SELECT * FROM users WHERE varsity_id = '$varsityIdData'";
    $responseOfFetchQuery = $connectionNow->query($query);

    if(!$responseOfFetchQuery){
        die('Could not get data: '.mysql_error());
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
            "Data"=>$userInfo[0]  
        ));
    }
    else {
        $userInfo[] = $varsityIdData;
        echo json_encode(array(
            "Success"=>false,
            $varsityId
        ));
    }
    }
?>
