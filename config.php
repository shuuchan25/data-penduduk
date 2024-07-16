<?php
$servername = "localhost";
$username = "root";
$password = ""; 
$dbname = "data_penduduk"; 

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    //echo "Connected successfully"; // Pesan jika koneksi berhasil
}
?>
