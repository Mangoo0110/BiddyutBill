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
$meterNoData = $_POST[$MeterNo];
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
// Delete if...
if($responseOfCheckQuery->num_rows>0){
    $sqlQuery = "DELETE FROM houses 
    WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";    
    $responseOfUpdateQuery = $connectionNow->query($sqlQuery);
    if($responseOfUpdateQuery){
        echo json_encode(array(
        "Success"=>true,
    ));
    }
    else{
        echo json_encode(array("Success"=>false,"Error"=>"Failed DELETE"));
    }
}
// else if($responseOfCheckQuery->num_rows>1){
//     echo json_encode(array("Success"=>false,"Error"=>"With buildingname and houseno, there should be only one house. But more than one house has found!!"));
// }

else{
    echo json_encode(array("Success"=>false,"Error"=>"NO SUCH HOUSE"));
 }
}
?>