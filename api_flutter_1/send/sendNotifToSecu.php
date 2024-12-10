<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$notif = $_POST['notif'];
$salle = $_POST['salle'];
$batiment = $_POST['batiment'];
$prof = $_POST['de'];

// Insert f BD
$sql = "INSERT INTO notifs (notif, salle, batiment, prof) VALUES ('$notif', '$salle', '$batiment', '$prof')";

$response = array();
if ($conn->query($sql) === TRUE) {
    $response['status'] = "Success";
    echo json_encode($response);
} else {
    $response['status'] = "Failure";
    $response['error'] = $conn->error;
    echo json_encode($response);
}

$conn->close();
?>