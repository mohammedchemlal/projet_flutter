<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");
include('../connection.php');
$conn = dbconnection();
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
if (isset($_POST['idU'])) {
    $usrDelete = $_POST['idU'];
 $sql = "DELETE FROM users WHERE idU = $usrDelete";
    if ($conn->query($sql) === TRUE) {
        echo "Account deleted successfully";
    } else {
        echo "Error deleting account: " . $conn->error;
    }
} else {
    echo "The 'username' parameter is not chosed.";
}
$conn->close();
?>
