<?php
   $serverHost = "localhost";
   $user = "root";
   $password = "";
   $database = "biddyutBill";
   $connectionNow = new mysqli($serverHost,$user,$password,$database);
   header("Access-Control-Allow-Origin: *");
    $varsityId = $_POST["varsity_id"];
    $query = "SELECT * FROM users WHERE varsity_id = '$varsityId'";
    $userInfo= [];
    $responseOfFetchQuery = $connectionNow->query($query);

    if(!$responseOfFetchQuery){
        die('Could not get data: '.mysql_error());
    }
    if($responseOfFetchQuery->num_rows>0){
        //echo json_encode(array("Success"=>true));
        while($rowFound = $responseOfFetchQuery->fetch_assoc()){
            //printf("\n");
            $userInfo[] = $rowFound;      
        }
        
    }
    echo json_encode(
        $userInfo
        );
?>
