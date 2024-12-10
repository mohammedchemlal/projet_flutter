<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php'); // Include your database connection file

$conn = dbconnection(); // Establish the database connection

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Assuming 'username' is received via POST request
$username = $_POST['username']; // Replace with your POST variable name

// Query to retrieve 'name' based on 'username'
$sql = "SELECT name FROM users WHERE username = '$username'"; // Customize this query according to your database schema

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode($row); // Output JSON data containing the 'name'
} else {
    echo json_encode(array("error" => "No results")); // Output JSON indicating no results for the provided username
}

$conn->close();
?>
