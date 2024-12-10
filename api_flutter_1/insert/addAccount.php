<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("La connexion à la base de données a échoué : " . $conn->connect_error);
}


$username = $_POST['username'];
$password = $_POST['password'];
$name = $_POST['name'];
$phoneNumber = $_POST['phoneNumber'];
$email = $_POST['email'];
$userType = $_POST['userType'];
$batiment = $_POST['batiment'];
$cours = $_POST['cours'];

$requeteInsertion = "INSERT INTO users (username, password, name, phoneNumber, email, userType, batiment, cours) 
                     VALUES ('$username', '$password', '$name', '$phoneNumber', '$email', '$userType', '$batiment', '$cours')";

// Afich les valeurs et la reqt SQL
echo "Nom d'utilisateur : $username\n";
echo "Mot de passe : $password\n";


echo "Requête SQL : $requeteInsertion\n";

// Exécuter rqt
if ($conn->query($requeteInsertion) === TRUE) {
    echo "L'utilisateur a été ajouté avec succès.";
} else {
    echo "Erreur lors de l'ajout de l'utilisateur : " . $conn->error;
}

$conn->close();

?>