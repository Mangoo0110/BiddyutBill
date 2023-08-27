<?php
   $serverHost = "localhost";
   $user = "root";
   $password = "";
   $database = "biddyutBill";
   $connectionNow = new mysqli($serverHost,$user,$password,$database);
   header("Access-Control-Allow-Origin: *");
   $tableName = "demand_charge_vat_percentage";
//    $sqlCreateQuery = 
//     "CREATE table IF NOT EXISTS $tableName(
//     demand_charge_tk TEXT,
//     vat_percentage_tk TEXT,
//     )
//     ";
    $query = "SELECT * FROM $tableName";
    $demandChargeAndVat = [];
    $responseOfFetchQuery = $connectionNow->query($query);

    if(!$responseOfFetchQuery){
        die('Could not get data: '.mysql_error());
    }
    if($responseOfFetchQuery->num_rows==1){
        //echo json_encode(array("Success"=>true));
        while($rowFound = $responseOfFetchQuery->fetch_assoc()){
            //printf("\n");
            $demandChargeAndVat[] = $rowFound;
            break;      
        }
    }


    echo json_encode(
        $demandChargeAndVat
        );
?>
