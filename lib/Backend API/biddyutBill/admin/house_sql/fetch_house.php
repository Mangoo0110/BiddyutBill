<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");


$buildingName = "building_name";
$houseNo = "house_no";
$meterNo = "meter_no";
$assignedUserID = "assigned_user_id";
$typeA = "type_a";
$typeB = "type_b";
$typeS = "type_s";

$sqlCreateQuery = "CREATE TABLE IF NOT EXISTS houses(
    $buildingName TEXT NOT NULL,
    $houseNo TEXT NOT NULL,
    $meterNo TEXT,
    $assignedUserID TEXT,
    $typeA BOOLEAN,
    $typeB BOOLEAN,
    $typeS BOOLEAN,
    CONSTRAINT house_unique_key UNIQUE ($buildingName, $houseNo)
    )";

$responseOfCreateQuery = $connectionNow->query($sqlCreateQuery);
if(!$responseOfCreateQuery){
    die("Sorry API problem : ".mysql_error());
}
else{
$buildingNameData = $_POST[$buildingName];
$houseNoData = $_POST[$houseNo];
$sqlFetchQuery = "SELECT * FROM houses WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";

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
}
?>