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
    $etage = $_POST['etage'];
    $batiment = $_POST['batiment'];
    $num = $_POST['num'];

    // Prepare the SQL insertion query
    $requeteInsertion = "INSERT INTO salles (etage, batiment, num) VALUES ('$etage', '$batiment', '$num')";

    // Execute the query
    if ($conn->query($requeteInsertion) === TRUE) {
        echo "La salle a été ajoutée avec succès.";
    } else {
        echo "Erreur lors de l'ajout de la salle : " . $conn->error;
    }

// Close the connection
$conn->close();

?>