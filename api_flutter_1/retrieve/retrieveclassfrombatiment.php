<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$conn = dbconnection();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$username=$_POST['username'];
$sql = "SELECT DISTINCT salles.num 
        FROM salles 
        INNER JOIN users ON salles.batiment = users.batiment 
        WHERE users.username = '".$username."'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row["num"];
    }
    echo json_encode($data); // Output JSON data
} else {
    echo json_encode(array("error" => "No results")); // Output JSON indicating no results
}

$conn->close();
?>
