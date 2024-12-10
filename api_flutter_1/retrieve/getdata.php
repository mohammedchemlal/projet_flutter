<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$con=dbconnection();
$sql = "SELECT COUNT(*) AS total FROM complaintes";
$result = mysqli_query($con, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $count = $row['total'];
    echo $count;
} else {
    echo "Error: " . mysqli_error($con);
}

mysqli_close($con);

?>
