<?php
include('../connection.php'); 

$currentUsername = $_POST['currentUsername']; 
$email = $_POST['email']; 

$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "UPDATE users SET email = '$email' WHERE username = '$currentUsername'";
if ($conn->query($sql) === TRUE) {
    echo "Name updated successfully!";
} else {
    echo "Error updating name: " . $conn->error;
}

$conn->close();
?>
