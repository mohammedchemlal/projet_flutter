<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$username = $_POST['username'];

// SQL query to join reservations and users tables based on batiment
$sql = "SELECT r.* FROM reservations r 
        INNER JOIN users u ON r.batiment = u.batiment
        WHERE u.username = '$username'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row; // Add each reservation as an array to the main data array
    }
    echo json_encode($data); // Return the data as JSON
} else {
    echo json_encode(array("error" => "No reservations found for the user's batiment"));
}
$conn->close();
?>
