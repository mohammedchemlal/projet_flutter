<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

// Replace these values with your database information
include('../connection.php');
$conn = dbconnection();

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the 'numSalle' value from the URL parameter
if (isset($_POST['idR'])) {
    $id = $_POST['idR'];

    // Use the 'numSalle' directly in the SQL query (vulnerable to SQL injection)
    $sql = "DELETE FROM reservations WHERE idR = $id";

    // Execute the query
    if ($conn->query($sql) === TRUE) {
        echo "Row deleted successfully";
    } else {
        echo "Error deleting row: " . $conn->error;
    }
} else {
    echo "The 'reservation' parameter is not specified.";
}

// Close the connection
$conn->close();
?>
