<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_tables";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$buildingName = "building_name";
$houseNo = "house_no";

$monthYear = $_POST["month_year"];
$buildingNameData = $_POST[$buildingName];
$houseNoData = $_POST[$houseNo];

$sqlFetchQuery = "SELECT * FROM $monthYear WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";

$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);
$monthlyRecord;
if(!$responseOfFetchQuery){
    echo json_encode(
        array(
            "Success"=>false,
            "Data"=>$monthlyRecord,
            "Error"=>mysqli_error($connectionNow),
        )
        );
}
else {
    if($responseOfFetchQuery->num_rows==0){
        echo json_encode(
            array(
                "Success"=>false,
                "Data"=>$monthlyRecord,
                "Error"=>mysqli_error($connectionNow),
            )
            );
    }
    if($responseOfFetchQuery->num_rows>0){
        while($row = $responseOfFetchQuery->fetch_assoc()){
            $monthlyRecord= $row;
        }
    }
    echo json_encode(
        array(
            "Success"=>true,
            "Data"=>$monthlyRecord,
        )
        );
}


?>