<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$buildingName = $_POST["category"];
$houseNo = $_POST["houseNo"];
$MeterNo = $_POST["meterNo"];
$assignedUserID = $_POST["assignedUserID"];
$sqlFetchQuery = "SELECT * FROM houses WHERE BuildingName = '$buildingName' AND HouseNo = '$houseNo'";

$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);
if(!$responseOfFetchQuery){
    die('Could not get data: '.mysql_error());
}
if($responseOfFetchQuery->num_rows>0){
    //echo json_encode(array("Success"=>true));
    while($rowFound = $responseOfFetchQuery->fetch_assoc()){
        //printf("\n");
        $houseRecord[] = $rowFound;      
    }
    
}
echo json_encode(
    $houseRecord
    );