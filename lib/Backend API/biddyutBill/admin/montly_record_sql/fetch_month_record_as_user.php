<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_tables";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");


$varsityId = "varsity_id";
$monthYearData = $_POST["month_year"];
$varsityIdData = $_POST[$varsityId];

$sqlFetchQuery = "SELECT * FROM $monthYearData WHERE $varsityId = '$varsityIdData'";

$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);
$monthlyRecord ;
if(!$responseOfFetchQuery){
    echo json_encode(
        array(
            "Success"=>false,
            "Data"=>$monthlyRecord,
            "Error"=>"This month is not in record",
        )
        );
}
else {
    if($responseOfFetchQuery->num_rows==0){
        echo json_encode(
            array(
                "Success"=>false,
                "Data"=>$monthlyRecord,
                "Error"=>"No user record on this month",
            )
            );
    }
    else {
        while($row = $responseOfFetchQuery->fetch_assoc()){
            $monthlyRecord = $row;
        }
    }
    echo json_encode(
        array(
            "Success"=>true,
            "Data"=>$monthlyRecord
        )
        );
}
