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

$buildingNameData = $_POST[$buildingName];
$houseNoData = $_POST[$houseNo];
$meterNoData = $_POST[$meterNo];
$assignedUserIDData = $_POST[$assignedUserID];

$sqlCreateQuery = "CREATE TABLE IF NOT EXISTS houses(
$buildingName TEXT,
$houseNo TEXT,
$meterNo TEXT,
$assignedUserID TEXT,
CONSTRAINT house_unique_key UNIQUE ($buildingName, $houseNo)
)";
$responseOfCreateQuery = $connectionNow->query($sqlCreateQuery);
if(!$responseOfCreateQuery){
    die("sorry API problem : ".mysql_error());
}
else{
$sqlCheckQuery ="SELECT * FROM houses WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";
$responseOfCheckQuery = $connectionNow->query($sqlCheckQuery);
// Update if...
if($responseOfCheckQuery->num_rows==1){
    $sqlQuery = "UPDATE houses SET 
    $meterNo = '$meterNoData', 
    $assignedUserID = '$assignedUserIDData' 
    WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";    
    $responseOfUpdateQuery = $connectionNow->query($sqlQuery);
    if($responseOfUpdateQuery){
        echo json_encode(array(
        "Success"=>true,"msg"=>"House Updated!!" 
    ));
    }
    else{
        echo json_encode(array("Success"=>false,"Error"=>"House update failed"));
    }
}
//else Insert
else{

$sqlQuery = "INSERT INTO houses SET 
$buildingName = '$buildingNameData', 
$houseNo = '$houseNoData', 
$meterNo = '$meterNoData', 
$assignedUserID = '$assignedUserIDData'";

$responseOfInsertQuery = $connectionNow->query($sqlQuery);

if($responseOfInsertQuery){
    echo json_encode(array(
    "Success"=>true,   
));
}
else{
    echo json_encode(array("Success"=>false,"Error"=>"House Insert failed"));
}
}
}
?>