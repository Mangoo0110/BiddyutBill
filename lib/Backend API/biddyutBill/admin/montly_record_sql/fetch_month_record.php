<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_data";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$monthYear = $_POST["month_year"];
$varsityId = $_POST["varsity_id"];

$sqlFetchQuery = "SELECT * FROM $monthYear WHERE varsity_id = $varsityId";

$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);
$monthlyRecord = [];
if(!$responseOfFetchQuery){
    die('Could not get data: '.mysql_error());
}
else {
    if($responseOfFetchQuery->num_rows==0){
        
    }
    if($responseOfFetchQuery->num_rows>0){
        while($row = $responseOfFetchQuery->fetch_assoc()){
            $monthlyRecord[] = $row;
        }
    }
    
}
echo json_encode($monthlyRecord);

?>