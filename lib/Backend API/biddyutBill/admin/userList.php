<?php
    $serverHost = "localhost";
    $user = "root";
    $password = "";
    $database = "biddyutBill";
    
    $connectionNow = new mysqli($serverHost,$user,$password,$database);
    
    $query = "SELECT `id`, `name`, `number`, `Assignedhouse` FROM `users`";
    $exe = mysqli_query($connectionNow, $query);
    $arr=[];
    while($row = mysqli_fetch_array($exe)){
        $arr[] = $row;
    }
    print(json_encode($arr));

?>
