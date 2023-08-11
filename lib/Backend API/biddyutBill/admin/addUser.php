<?php
$serverHost = "127.0.0.1";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

//$uId = "1702044";
//$uName = "hasan";
//$uNumber = "23489475";
//$assignedHouseID = "18974";


$uId = $_POST["userId"];
$uName = $_POST["name"];
$uNumber = $_POST["mobileNo"];
$assignedHouseID = $_POST["assignedHouseID"];

$sqlQuery = "INSERT INTO users SET id = '$uId', name = '$uName', number = '$uNumber', Assignedhouse = '$assignedHouseID'";

//INSERT INTO `users`(`id`, `name`, `number`, `Assignedhouse`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')

$responseOfInsertQuery = $connectionNow->query($sqlQuery);

if($responseOfInsertQuery){
    echo json_encode(array(
    "Success"=>true,   
));
}
else{
    echo json_encode(array("Success"=>false));
}
