<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$json_data = file_get_contents('php://input');

// Decode JSON data into an associative array
$arry = json_decode($json_data, true); 
//echo(json_encode($arry));
//echo()
//$arry = array('0'=>"1", '51'=>"2", '101'=>"3", '151'=>"4");
//$arry = $_POST;
//$post_options = array('options');
//$arry = $_POST[array('startingRangeAndRates')];
//$arry = array();
foreach($arry as $k => $v){
    //echo "{$k} to {$v} <br>";
    $sqlQuery = "UPDATE `unit_cost` SET `rate`='$v' WHERE `ending_range`='$k'";

     $responseOfUpdateQuery = $connectionNow->query($sqlQuery);

    if($responseOfUpdateQuery){
        echo json_encode(array(
        "Success"=>true,   
        ));
    }
    else{
        echo json_encode(array("Success"=>false));
    }
}
?>