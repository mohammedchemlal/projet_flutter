
<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

include('../connection.php');
$con=dbconnection();
$sql = "SELECT COUNT(*) AS total_salles_non_reservees
FROM salles
WHERE num NOT IN (SELECT DISTINCT salle FROM reservations)";
$result = mysqli_query($con, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $count = $row['total_salles_non_reservees'];
    echo $count;
} else {
    echo "Error: " . mysqli_error($con);
}

mysqli_close($con);

?>
