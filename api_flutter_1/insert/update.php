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

// Retrieve form data
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Assuming you have an "id" for the salle to be updat
    $etage = $_POST['etage'];
    $batiment = $_POST['batiment'];
    $num = $_POST['num'];
    $numActuel = $_POST['numActuel'];
    $batimentActuel= $_POST['batimentActuel'];
    $etageActuel= $_POST['etageActuel'];

    // Prepare the SQL update query
    $requeteModification = "UPDATE salles SET etage='$etage', batiment='$batiment', num='$num' WHERE num=$numActuel AND batiment=$batimentActuel AND etage=$etageActuel";

    // Execute the query
    if ($conn->query($requeteModification) === TRUE) {
        echo "La salle a été modifiée avec succès.";
    } else {
        echo "Erreur lors de la modification de la salle : " . $conn->error;
    }
} else {
    echo "Méthode non autorisée.";
}

// Close the connection
$conn->close();

?>
