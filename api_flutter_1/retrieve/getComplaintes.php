<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn=dbconnection();
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM complaintes"; 

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row; 
    }
    echo json_encode($data);
} else {
    echo json_encode(array("error" => "No notifications found"));
}
$conn->close();
?>