<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "monthly_biddyutbill_data";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");


$monthAndYear = "month_year";
$varsityId = "varsity_id";
$fullName= "full_name";
$houseAddress= "house_address";
$meterNo = "meter_no";
$presentMeterReading = "present_meter_reading";
$previousMeterReading= "previous_meter_reading";
$usedUnit = "used_unit";
$unitCostTk = "unit_cost_tk";
$demandChargeTk = "demand_charge_tk";
$firstTotalTk = "first_total_tk";
$vatPercentage = "vat_percentage";
$secondTotalTk = "second_total_tk";
$finalTotalTk = "final_total_tk";

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

$monthAndYearData = $_POST["month_year"];
$varsityIdData = $_POST["varsity_id"];
$fullNameData= $_POST["full_name"];
$houseAddressData= $_POST["house_address"];
$meterNoData = $_POST["meter_no"];
$presentMeterReadingData = $_POST["present_meter_reading"];
$previousMeterReadingData = $_POST["previous_meter_reading"];
$usedUnitData = $_POST["used_unit"];
$unitCostTkData = $_POST["unit_cost_tk"];
$demandChargeTkData = $_POST["demand_charge_tk"];
$firstTotalTkData = $_POST["first_total_tk"];
$vatPercentageData = $_POST["vat_percentage"];
$secondTotalTkData = $_POST["second_total_tk"];
$finalTotalTkData = $_POST["final_total_tk"];

// $json_data = file_get_contents("php://input");
// $arr = json_decode($json_data,true);

// echo json_encode($finalTotalTkData);

$sqlCreateQuery = 
"CREATE TABLE IF NOT EXISTS $monthAndYearData (
$varsityId TEXT UNIQUE KEY,
$fullName TEXT,
$houseAddress TEXT,
$meterNo TEXT,
$presentMeterReading TEXT NOT NULL,
$previousMeterReading TEXT NOT NULL,
$usedUnit TEXT NOT NULL,
$unitCostTk TEXT NOT NULL,
$demandChargeTk TEXT NOT NULL,
$firstTotalTk TEXT NOT NULL,
$vatPercentage TEXT NOT NULL,
$secondTotalTk TEXT NOT NULL,
$finalTotalTk TEXT NOT NULL
)
";

$responseOfCreateQuery = $connectionNow->query($sqlCreateQuery);

if(!$responseOfCreateQuery){
    die('Sorry, API problem: '.mysql_error());
    }
$sqlInsertQuery = "INSERT INTO $monthAndYearData SET $varsityId = '$varsityIdData'";
// else{
//     echo ("created table");
// }
$sqlInsertQuery = "INSERT INTO $monthAndYearData SET
$varsityId = '$varsityIdData',
$fullName = '$fullNameData',
$houseAddress = '$houseAddressData',
$meterNo = '$meterNoData',
$presentMeterReading = '$presentMeterReadingData',
$previousMeterReading = '$previousMeterReadingData',
$usedUnit = '$usedUnitData',
$unitCostTk = '$unitCostTkData',
$demandChargeTk = '$demandChargeTkData',
$firstTotalTk= '$firstTotalTkData',
$vatPercentage = '$vatPercentageData',
$secondTotalTk = '$secondTotalTkData',
$finalTotalTk = '$finalTotalTkData'
 ";
$responseOfInsertQuery = $connectionNow->query($sqlInsertQuery);
if(!$responseOfInsertQuery){
    die("Could not Insert data!!".mysql_error());
}
else{
    echo json_encode(
        "Data [$fullNameData] pushed successfully."
    );
}
?>