<?php
include('../connection.php'); 
$currentUsername = $_POST['currentUsername']; 
$newPassword = $_POST['password']; 

$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE users SET password = '".$newPassword."' WHERE username = '".$currentUsername."'";

if ($conn->query($sql) === TRUE) {
    echo "Password updated successfully!";
} else {
    echo "Error updating password: " . $conn->error;
}

$conn->close();
?>
