<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");
// $varsityId = "";
// $address = "";
// $presentMeterReading = "5.7";
// $previousMeterReading = "1.2";
// $usedUnit = ((double)"$presentMeterReading") - ((double)"$previousMeterReading") ;

// $monthAndYear = "january_2023";
$monthAndYear = $_POST["MonthAndYear"];
$sqlFetchQuery = "
CREATE table IF NOT EXISTS $monthAndYear(
varsity_id TEXT UNIQUE KEY,
address TEXT,
meter_no TEXT,
present_meter_reading TEXT,
previous_meter_reading TEXT,
used_unit TEXT,
unit_cost_tk TEXT,
demand_charge_tk TEXT,
first_total_tk TEXT,
vat_percentage TEXT,
second_total TEXT,
final_total TEXT,
)
";
$houseRecord = [];
$responseOfFetchQuery = $connectionNow->query($sqlFetchQuery);


?>