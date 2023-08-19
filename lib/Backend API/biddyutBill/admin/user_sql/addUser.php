<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

//$uId = "1702044";
//$uName = "hasan";
//$uNumber = "23489475";
//$assignedHouseID = "18974";


$uId = $_POST["varsity_id"];
$uName = $_POST["full_name"];
$uEmail = $_POST["email"];
$assignedMeterNo = $_POST["assignedMeterNo"];
$houseAddress = $_POST["house_address"];

$sqlQuery = "INSERT INTO users SET varsity_id = '$uId', house_address = '$houseAddress', full_name = '$uName', email = '$uEmail', assignedMeterNo = '$assignedMeterNo'";

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
