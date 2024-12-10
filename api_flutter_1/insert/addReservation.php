<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

// Replace these values with your database information
include('../connection.php');
$conn = dbconnection();

// Check the connection
if ($conn->connect_error) {
    die("La connexion à la base de données a échoué : " . $conn->connect_error);
}
    $salle = $_POST['salle'];
    $etage = $_POST['etage'];
    $batiment = $_POST['batiment'];
    $dateRes = $_POST['dateRes'];
    $prof = $_POST['prof'];
    $heure = $_POST['heure'];
    

    // Prepare the SQL insertion query
    $requeteInsertionRES = "INSERT INTO reservations (salle, etage, batiment, dateRes, prof, heure) VALUES ('$salle', '$etage', '$batiment','$dateRes', '$prof', '$heure')";

    // Execute the query
    if ($conn->query($requeteInsertionRES) === TRUE) {
        echo "La reservation a été ajoutée avec succès.";
    } else {
        echo "Erreur lors de l'ajout de la reservation : " . $conn->error;
    }

// Close the connection
$conn->close();

?>