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
    $filiere = $_POST['filiere'];
    $prof = $_POST['prof'];
    $nom = $_POST['nom'];
    $annee= $_POST['annee'];

    // Prepare the SQL insertion query
    $requeteInsertion = "INSERT INTO cours (filiere, prof, nom,annee) VALUES ('$filiere', '$prof', '$nom','$annee')";

    // Execute the query
    if ($conn->query($requeteInsertion) === TRUE) {
        echo "La salle a été ajoutée avec succès.";
    } else {
        echo "Erreur lors de l'ajout de la salle : " . $conn->error;
    }

// Close the connection
$conn->close();

?>