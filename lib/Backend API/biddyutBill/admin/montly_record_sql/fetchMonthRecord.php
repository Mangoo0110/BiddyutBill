<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverHost,$user,$password,$database);
header("Access-Control-Allow-Origin: *");

$monthYear = $_POST["month_year"];
$varsityId = $_POST["varsity_id"];

$sqlFetchQuery = "SELECT * FROM $monthYear WHERE varsity_id = $varsityId";

?>