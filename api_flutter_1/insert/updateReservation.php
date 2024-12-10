<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");


include('../connection.php');
$conn = dbconnection();

// verf cnx
if ($conn->connect_error) {
    die("La connexion à la base de données a échoué : " . $conn->connect_error);
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $salle = $_POST['salle'];
    $etage = $_POST['etage'];
    $batiment = $_POST['batiment'];
    $dateRes = $_POST['dateRes'];
    $prof = $_POST['prof'];
    
    $salleActuel = $_POST['salleActuel'];
    $etageActuel= $_POST['etageActuel'];
    $batimentActuel= $_POST['batimentActuel'];
    $dateResActuel = $_POST['dateResActuel'];
    $profActuel= $_POST['profActuel'];

    
    $requeteModificationRES = "UPDATE reservations SET fsalle='$fsalle', etage='$etage', batiment='$batiment', dateRes='$dateRes', prof='$prof' WHERE salle=$salleActuel AND etage=$etageActuel AND batiment=$batimentActuel AND dateRes=$dateResActuel AND prof=$profActuel";

    // Execution
    if ($conn->query($requeteModificationRES) === TRUE) {
        echo "La reservation a été modifiée avec succès.";
    } else {
        echo "Erreur lors de la modification de la reservations : " . $conn->error;
    }
} else {
    echo "Méthode non autorisée.";
}

$conn->close();

?>
