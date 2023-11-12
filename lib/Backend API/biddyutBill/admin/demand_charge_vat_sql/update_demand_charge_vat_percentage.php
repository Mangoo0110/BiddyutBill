<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost, $user, $password, $database);
header("Access-Control-Allow-Origin: *");
$demandAndVatChargeTable = "demand_charge_vat_percentage";
$typeA = "type_a";
$typeB = "type_b";
$typeS = "type_s";
$demandChargeTk = "demand_charge_tk";
$vatPercentage = "vat_percentage";
$demandChargeTkData = $_POST[$demandChargeTk];
$vatPercentageData = $_POST[$vatPercentage];
$typeAData = $_POST[$typeA]=="true"?1:0;
$typeBData = $_POST[$typeB]=="true"?1:0;//true:false;
$typeSData = $_POST[$typeS]=="true"?1:0;

// $json_data = file_get_contents('php://input');

// // Decode JSON data into an associative array
// $arry = json_decode($json_data, true);


$sqlQuery = "UPDATE $demandAndVatChargeTable SET $demandChargeTk = '$demandChargeTkData', $vatPercentage = '$vatPercentageData' WHERE $typeA = '$typeAData' AND $typeB = '$typeBData' AND $typeS = '$typeSData'";

$responseOfUpdateQuery = $connectionNow->query($sqlQuery);

if ($responseOfUpdateQuery) {
    echo json_encode(
        array(
            "Success" => true,
        )
    );
} else {
    echo json_encode(array("Success" => false));
}
?>