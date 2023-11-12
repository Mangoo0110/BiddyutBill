<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_tables";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");


$monthAndYear = "month_year";
$varsityId = "varsity_id";
$fullName= "full_name";
$occupation = "occupation";
$accountNo = "account_no";
$buildingName = "building_name";
$houseNo = "house_no";
$meterNo = "meter_no";
$presentMeterReading = "present_meter_reading";
$previousMeterReading= "previous_meter_reading";
$usedUnit = "used_unit";
$unitCostTk = "unit_cost_tk";
$demandChargeTk = "demand_charge_tk";
$firstTotalTk = "first_total_tk";
$vat = "vat";
$secondTotalTk = "second_total_tk";
$finalTotalTk = "final_total_tk";
$typeA = "type_a";
$typeB = "type_b";
$typeS = "type_s";
// $monthAndYearData = "jan2009";
// $varsityIdData = "1702062";
// $fullNameData= "Anik";
// $houseAddressData= "M.k hall";
// $meterNoData = "464645";
// $presentMeterReadingData = "infinity";
// $previousMeterReadingData = "infinity";
// $usedUnitData = "Infinity";
// $unitCostTkData = "Infinity";
// $demandChargeTkData = "Infinity";
// $firstTotalTkData = "Infinity";
// $vatPercentageData = "Infinity";
// $secondTotalTkData = "Infinity";
// $finalTotalTkData = "Infinity";

$monthAndYearData = $_POST[$monthAndYear];
$varsityIdData = $_POST[$varsityId];
$fullNameData= $_POST[$fullName];
$occupationData = $_POST[$occupation];
$accountNoData = $_POST[$accountNo];
$buildingNameData= $_POST[$buildingName];
$houseNoData = $_POST[$houseNo];
$meterNoData = $_POST[$meterNo];
$presentMeterReadingData = $_POST[$presentMeterReading];
$previousMeterReadingData = $_POST[$previousMeterReading];
$usedUnitData = $_POST[$usedUnit];
$unitCostTkData = $_POST[$unitCostTk];
$demandChargeTkData = $_POST[$demandChargeTk];
$firstTotalTkData = $_POST[$firstTotalTk];
$vatData = $_POST[$vat];
$secondTotalTkData = $_POST[$secondTotalTk];
$finalTotalTkData = $_POST[$finalTotalTk];
$typeAData = $_POST[$typeA]=="true"?1:0;
$typeBData = $_POST[$typeB]=="true"?1:0;//true:false;
$typeSData = $_POST[$typeS]=="true"?1:0;//true:false;

$sqlCreateQuery = 
"CREATE TABLE IF NOT EXISTS $monthAndYearData (
varsity_id TEXT,
full_name TEXT NOT NULL,
occupation TEXT NOT NULL,
account_no TEXT NOT NULL,
building_name TEXT NOT NULL,
house_no TEXT NOT NULL,
meter_no TEXT NOT NULL,
previous_meter_reading TEXT NOT NULL,
present_meter_reading TEXT NOT NULL,
used_unit TEXT NOT NULL,
unit_cost_tk TEXT NOT NULL,
demand_charge_tk TEXT NOT NULL,
first_total_tk TEXT NOT NULL,
vat TEXT NOT NULL,
second_total_tk TEXT NOT NULL,
final_total_tk TEXT NOT NULL ,
$typeA BOOLEAN,
$typeB BOOLEAN,
$typeS BOOLEAN,
CONSTRAINT house_unique_key UNIQUE ($buildingName, $houseNo)
)";

$responseOfCreateQuery = $connectionNow->query($sqlCreateQuery);

if(!$responseOfCreateQuery){
    echo json_encode("failed create");
    die('Sorry, API problem: '.mysql_error());
    }
$sqlCheckQuery = "SELECT * FROM $monthAndYearData WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";
$responseOfCheckQuery = $connectionNow->query($sqlCheckQuery);
if(!$responseOfCheckQuery){
    echo json_encode("Failed to check if data already exist!!");
    die("Error: ".mysql_error());
}
else{
    
    if($responseOfCheckQuery->num_rows>0){
        
        $sqlDeleteQuery = "DELETE FROM $monthAndYearData
                            WHERE $buildingName = '$buildingNameData' AND $houseNo = '$houseNoData'";
        $responseOfDeleteQuery = $connectionNow->query($sqlDeleteQuery);
        if(!$responseOfDeleteQuery){
            
            echo json_encode("Failed to remove previous data");
            die("Could not Update data!!".mysql_error());
        }
        else{
            //echo json_encode("Checked");
            $sqlInsertQuery = "INSERT INTO $monthAndYearData 
                                ($varsityId, $fullName, $occupation, $accountNo, $buildingName, $houseNo, $meterNo, $previousMeterReading, $presentMeterReading, $usedUnit,
                                $unitCostTk, $demandChargeTk, $firstTotalTk, $vat, $secondTotalTk, $finalTotalTk, $typeA, $typeB, $typeS)
                                VALUES 
                                ('$varsityIdData', '$fullNameData', '$occupationData', '$accountNoData', '$buildingNameData', '$houseNoData', '$meterNoData', '$previousMeterReadingData', 
                                '$presentMeterReadingData', '$usedUnitData', '$unitCostTkData', '$demandChargeTkData', '$firstTotalTkData', '$vatData', '$secondTotalTkData', '$finalTotalTkData', '$typeAData', '$typeBData', '$typeSData')";
                                
            $responseOfInsertQuery = $connectionNow->query($sqlInsertQuery);
            if(!$responseOfInsertQuery){
                echo json_encode("failed to update");
                die("Could not Insert data!!".mysql_error());
            }
            else{
                echo json_encode(array(
                    "Success"=>true,
                    "Message"=>"Data pushed successfully."
                )
                );
            }
        }
    }
    else{
        $sqlInsertQuery = "INSERT INTO $monthAndYearData 
                            ($varsityId, $fullName, $occupation, $accountNo, $buildingName, $houseNo, $meterNo, $previousMeterReading, $presentMeterReading, $usedUnit,
                            $unitCostTk, $demandChargeTk, $firstTotalTk, $vat, $secondTotalTk, $finalTotalTk, $typeA, $typeB, $typeS)
                            VALUES 
                            ('$varsityIdData', '$fullNameData', '$occupationData', '$accountNoData', '$buildingNameData', '$houseNoData', '$meterNoData', '$previousMeterReadingData', 
                            '$presentMeterReadingData', '$usedUnitData', '$unitCostTkData', '$demandChargeTkData', '$firstTotalTkData', '$vatData', '$secondTotalTkData', '$finalTotalTkData', '$typeAData', '$typeBData', '$typeSData')";

$responseOfInsertQuery = $connectionNow->query($sqlInsertQuery);
if(!$responseOfInsertQuery){
    die("Could not Insert data!!".mysql_error());
}
else{
    echo json_encode(array(
        "Success"=>true,
        "Message"=>"Data pushed successfully."
    )
    );
}
    }
}

?>
