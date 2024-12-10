<?php 

function dbconnection() {
    $con = mysqli_connect("localhost", "dbsql", "MmS00WoBbv8FK/(s", "flutterapp");
    if (mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
        exit(); // Exit the script if the connection fails
    }
    return $con;
}
?>