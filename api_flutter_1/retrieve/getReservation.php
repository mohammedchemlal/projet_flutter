<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn=dbconnection();
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM reservations"; // Adjust your SQL query accordingly

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row; // Add each notification as an array to the main data array
    }
    echo json_encode($data); // Return the data as JSON
} else {
    echo json_encode(array("error" => "No reservation found"));
}
$conn->close();
?>