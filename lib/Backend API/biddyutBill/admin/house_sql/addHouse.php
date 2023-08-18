<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);

$buildingName = $_POST["buildingName"];
$houseNo = $_POST["houseNo"];
$MeterNo = $_POST["meterNo"];
$assignedUserID = $_POST["assignedUserID"];

$sqlQuery = "INSERT INTO houses SET BuildingName = '$buildingName', HouseNo = '$houseNo', MeterNo = '$MeterNo', AssignedUserID = '$assignedUserID'";

$responseOfInsertQuery = $connectionNow->query($sqlQuery);

if($responseOfInsertQuery){
    echo json_encode(array(
    "Success"=>true,   
));
}
else{
    echo json_encode(array("Success"=>false));
}
