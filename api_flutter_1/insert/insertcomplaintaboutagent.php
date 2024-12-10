<?php
include('../connection.php'); // Include your database connection file

$conn = dbconnection(); // Establish the database connection

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Assuming the received parameters are 'text', 'numSalle', 'auteur', 'coupable'
$text = $_POST['text']; // Replace with the received complaint text
$numSalle = $_POST['numSalle']; // Replace with the received room number
$auteur = $_POST['auteur']; // Replace with the received author/security info
$jour = $_POST['jour'];
$heure = $_POST['heure'];
$batiment = $_POST['batiment'];
// Prepare SQL query to insert data into the database
$sql = "INSERT INTO complaintes (text, numSalle, auteur, jour, heure, batiment) VALUES ('$text', '$numSalle', '$auteur', '$jour', '$heure', '$batiment')";


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