<?php
include 'config.php'; // Mengimpor file konfigurasi untuk koneksi database

if (isset($_GET['provinsi_id'])) { // Memeriksa apakah 'provinsi_id' ada di parameter GET
    $provinsi_id = intval($_GET['provinsi_id']); // Mengambil dan memastikan provinsi_id adalah integer
    $sql_kota = "SELECT id, nama_kota FROM kota WHERE fk_provinsi_id = $provinsi_id"; // Query untuk memilih kota berdasarkan provinsi_id
    $result_kota = $conn->query($sql_kota); // Menjalankan query

    if ($result_kota->num_rows > 0) { // Memeriksa apakah ada hasil
        while ($row = $result_kota->fetch_assoc()) { // Mengambil setiap baris hasil sebagai array asosiatif
            echo "<option value='" . $row['id'] . "'>" . $row['nama_kota'] . "</option>"; // Menghasilkan elemen option untuk dropdown
        }
    } else {
        echo "<option value=''>No cities found</option>"; // Jika tidak ada kota ditemukan
    }
}

$conn->close(); // Menutup koneksi ke database
?>
