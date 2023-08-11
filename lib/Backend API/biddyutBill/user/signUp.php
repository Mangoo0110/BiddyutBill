<?php
include 'connection.php';

$userId = $_POST["varsity_id"];
$userImage = $_POST["image"];
$userName = $_POST["full_name"];
$userEmail = $_POST["email"];
$userPassword = md5($_POST["ipassword"]);


//query...
$sqlQuery = "INSERT INTO user_info SET varsity_id = '$userId', picture = '$userImage', full_name = '$userName', email = '$userEmail', ipassword = '$userPassword'";
$responseOfQuery = $connectionNow->query($sqlQuery);
if($responseOfQuery){
    echo json_encode(array("success"=>true));
}
else{
    echo json_encode(array("success"=>false));
}
