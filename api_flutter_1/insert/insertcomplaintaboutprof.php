<?php
include('../connection.php'); // Include your database connection file

$conn = dbconnection(); // Establish the database connection

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Assuming the received parameters are 'text', 'numSalle', 'auteur', 'coupable', 'jour', 'heure', 'username'
$text = $_POST['text']; // Replace with the received complaint text
$numSalle = $_POST['numSalle']; // Replace with the received room number
$auteur = $_POST['auteur']; // Replace with the received author/security info
$coupable = $_POST['coupable']; // Replace with the received selected professor
$jour = $_POST['jour']; // Replace with the received day
$heure = $_POST['heure'];
$username = $_POST['username']; // Replace with the received hour // Replace with the received username

// Prepare SQL query to insert data into the database with a subquery to fetch 'batiment' from 'users' table
$sql = "INSERT INTO complaintes (text, numSalle, auteur, coupable, jour, heure, batiment) 
        SELECT '$text', '$numSalle', '$auteur', '$coupable', '$jour', '$heure', users.batiment 
        FROM users 
        WHERE users.username = '$username'";

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
