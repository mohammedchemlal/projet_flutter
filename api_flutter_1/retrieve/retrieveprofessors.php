<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT name FROM users WHERE userType = 'Prof'"; // Make sure 'Prof' is a string
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row["name"];
    }
    echo json_encode($data); // Output JSON data
} else {
    echo json_encode(array("error" => "No results")); // Output JSON indicating no results
}

$conn->close();
?>