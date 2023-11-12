<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_tables";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$monthYear = $_POST["month_year"];

$sqlFetchQuery = "SELECT * FROM $monthYear";

$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);
$monthlyRecord = [];
if(!$responseOfFetchQuery){
    die('Could not get data: '.mysql_error());
}
else {
    if($responseOfFetchQuery->num_rows>0){
        while($row = $responseOfFetchQuery->fetch_assoc()){
            $monthlyRecord[] = $row;
        }
    }
    
}
echo json_encode($monthlyRecord);

?>