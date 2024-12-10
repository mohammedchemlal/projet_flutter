<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("Failed to connect to MySQL: " . $conn->connect_error);
}

$user_input_username = $_POST['username'];
$user_input_password = $_POST['password'];

$user_input_username = $_POST['username'];
$user_input_password = $_POST['password'];


$sql = "SELECT * FROM users WHERE username='$user_input_username' AND password='$user_input_password'";
$result = $conn->query($sql);

$response = array();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    
    $response['status'] = 'success';
    $response['message'] = 'Login successful!';
    $response['userType'] = $user['userType']; 
} else {
    $response['status'] = 'error';
    $response['message'] = 'Login failed. Invalid username or password.';
}


header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>