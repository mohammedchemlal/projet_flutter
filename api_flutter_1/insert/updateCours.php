<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");


include('../connection.php');
$conn = dbconnection();


if ($conn->connect_error) {
    die("La connexion à la base de données a échoué : " . $conn->connect_error);
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $filiere = $_POST['filiere'];
    $prof = $_POST['prof'];
    $nom = $_POST['nom'];
    $nom = $_POST['annee'];
    $nomActuel = $_POST['nomActuel'];
    $filiereActuel= $_POST['filiereActuel'];
    $profActuel= $_POST['profActuel'];
    $anneeActuelle= $_POST['anneeActuelle'];
 
    $requeteModificationCours = "UPDATE cours SET filiere='$filiere', prof='$prof', nom='$nom', annee='$annee' WHERE nom=$nomActuel AND prof=$profActuel AND filiere=$filiereActuel AND annee=$anneeActuelle";

    if ($conn->query($requeteModificationCours) === TRUE) {
        echo "La salle a été modifiée avec succès.";
    } else {
        echo "Erreur lors de la modification de la salle : " . $conn->error;
    }
} else {
    echo "Méthode non autorisée.";
}


$conn->close();

?>
