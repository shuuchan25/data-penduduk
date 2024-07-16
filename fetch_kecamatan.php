<?php
include 'config.php'; // Mengimpor file konfigurasi untuk koneksi database

if (isset($_GET['kota_id'])) { // Memeriksa apakah 'kota_id' ada di parameter GET
    $kota_id = intval($_GET['kota_id']); // Mengambil dan memastikan kota_id adalah integer
    $sql_kecamatan = "SELECT id, nama_kecamatan FROM kecamatan WHERE fk_kota_id = $kota_id"; // Query untuk memilih kecamatan berdasarkan kota_id
    $result_kecamatan = $conn->query($sql_kecamatan); // Menjalankan query

    if ($result_kecamatan->num_rows > 0) { // Memeriksa apakah ada hasil
        while ($row = $result_kecamatan->fetch_assoc()) { // Mengambil setiap baris hasil sebagai array asosiatif
            echo "<option value='" . $row['id'] . "'>" . $row['nama_kecamatan'] . "</option>"; // Menghasilkan elemen option untuk dropdown
        }
    } else {
        echo "<option value=''>No districts found</option>"; // Jika tidak ada kecamatan ditemukan
    }
}

$conn->close(); // Menutup koneksi ke database
?>
