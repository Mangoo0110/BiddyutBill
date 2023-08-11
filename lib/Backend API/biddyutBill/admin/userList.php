<?php
   $serverHost = "localhost";
   $user = "root";
   $password = "";
   $database = "biddyutBill";
   $connectionNow = new mysqli($serverHost,$user,$password,$database);
   header("Access-Control-Allow-Origin: *");
    $query = "SELECT * FROM users";
    $userRecord = [];
    $responseOfFetchQuery = $connectionNow->query($query);

    if(!$responseOfFetchQuery){
        die('Could not get data: '.mysql_error());
    }
    if($responseOfFetchQuery->num_rows>0){
        //echo json_encode(array("Success"=>true));
        while($rowFound = $responseOfFetchQuery->fetch_assoc()){
            //printf("\n");
            $userRecord[] = $rowFound;      
        }
        
    }
    echo json_encode(
        $userRecord
        );
?>
