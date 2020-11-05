 <?php
$servernamedb = "localhost";
$usernamedb = "id15223135_shahbaz";
$passworddb = "3Y93NjG2XYq5FEx_";
$dbname="id15223135_covital";

// Create connection
$conn = new mysqli($servernamedb, $usernamedb, $passworddb,$dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
else{
    //echo "successful";
}
?>