<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");
include('../connection.php'); 


$newName = $_POST['name']; 
$usernameToUpdate = $_POST['username']; 
$conn = dbconnection(); 

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE users SET name = '$newName' WHERE username = '$usernameToUpdate'";
if ($conn->query($sql) === TRUE) {
    echo "Name updated successfully!";
} else {
    echo "Error updating name: " . $conn->error;
}

$conn->close();
?>
