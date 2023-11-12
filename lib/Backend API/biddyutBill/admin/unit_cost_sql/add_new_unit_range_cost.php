<?php
    $serverHost = "localhost";
    $user = "root";
    $password = "";
    $database = "biddyutBill";

    $connectionNow = new mysqli($serverHost,$user,$password,$database);
    header("Access-Control-Allow-Origin: *");

    //$json_data = file_get_contents('php://input');

    // Decode JSON data into an associative array
    //$arry = json_decode($json_data, true); 
    $endingRange = "ending_range";
    $startingRange = "starting_range";
    $rate = "rate";
    $startingRangeData = $_POST[$startingRange];
    $endingRangeData = $_POST[$endingRange];
    $rateData = $_POST[$rate];
    $unitCostAndOtherRecord = [];

    
    $query = "SELECT * FROM unit_cost";
    $responseOfFetchQuery = $connectionNow->query($query);
    
    if(!$responseOfFetchQuery){
        die('Could not get data: '.mysql_error());
    }
    
    $validRange = true;
    if($responseOfFetchQuery->num_rows > 0){
        //echo json_encode(array("Success"=>true));
        while($rowFound = $responseOfFetchQuery->fetch_assoc()){
            //printf("\n");
            if(!($rowFound[$startingRange] > $endingRangeData || $rowFound[$endingRange] < $startingRangeData) && ($startingRangeData < $endingRangeData)){
                $validRange = false;
            }
        }      
    }

    if($validRange != true){
        {
            echo json_encode(array(
                "Success"=>false,
                "Message"=>"Invalid Range",
            ));
        }
    }
    else{
        $sqlInsertQuery = "INSERT INTO `unit_cost` SET $startingRange = '$startingRangeData', $endingRange = '$endingRangeData', $rate = '$rateData'";
        $responseOfInsertQuery = $connectionNow->query($sqlInsertQuery);
        if ($responseOfUpdateQuery) {
            echo json_encode(array(
            "Success"=>true,   
            ));
        }
        else {
            echo json_encode(array("Success"=>false));
        }
    }
?>