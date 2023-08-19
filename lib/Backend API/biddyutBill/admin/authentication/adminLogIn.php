<?php

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "biddyutBill";

$connectionNow = new mysqli($serverhost, $user, $password, $database);
header("Access-Control-Allow-Origin: *");
$adminId = $_POST['varsityID'];
$adminPassword = $_POST['password'];


// $adminId = "1702062";
// $adminPassword = "1702062";

//query...

$sqlQuery = "SELECT * FROM admin_auth WHERE varsity_id = '$adminId' AND ipassword = '$adminPassword'";

$resultOfQuery = $connectionNow->query($sqlQuery);


if($resultOfQuery->num_rows== 1){
    $adminRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $adminRecord[] = $rowFound;
        
    }
    echo json_encode(
        array(
            "Success"=>true,
            "AdminAuth"=>$adminRecord[0],
        )
        );
}
else{
    echo json_encode(array("Success"=>false));
}

?>