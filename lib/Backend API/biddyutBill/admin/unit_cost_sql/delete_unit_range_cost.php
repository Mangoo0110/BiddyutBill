<?php
    $serverHost = "localhost";
    $user = "root";
    $password = "";
    $database = "biddyutBill";

    $connectionNow = new mysqli($serverHost,$user,$password,$database);
    header("Access-Control-Allow-Origin: *");

    $endingRange = "ending_range";
    $startingRange = "starting_range";
    $rate = "rate";
    $startingRangeData = $_POST[$startingRange];
    $endingRangeData = $_POST[$endingRange];
    $rateData = $_POST[$rate];
    $unitCostAndOtherRecord = [];

    $sqlDeleteQuery = "DELETE FROM `unit_cost` WHERE $startingRange = '$startingRangeData' and $endingRange = '$endingRangeData'";
    $responseOfDeleteQuery = $connectionNow->query($sqlDeleteQuery);
    if ($responseOfDeleteQuery) {
        echo json_encode(array(
        "Success"=>true,
        ));
    }
    else {
        echo json_encode(array("Success"=>false));
    }
    
?>