<?php
include('../connection.php');

$username = $_POST['username']; 
$password = $_POST['password']; 

$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Success";
} else {
    
    echo "Invalid credentials";
}

$conn->close();
?>
