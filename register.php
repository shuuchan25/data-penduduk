<?php
include 'config.php';

// Ambil data tipe user
$tipeuser_options = [];
$sql_tipeuser = "SELECT id, nama_tipeuser FROM tipeuser";
$result_tipeuser = $conn->query($sql_tipeuser);
if ($result_tipeuser->num_rows > 0) {
    while ($row = $result_tipeuser->fetch_assoc()) {
        $tipeuser_options[] = $row;
    }
}

// Ambil data provinsi
$provinsi_options = [];
$sql_provinsi = "SELECT id, nama_provinsi FROM provinsi";
$result_provinsi = $conn->query($sql_provinsi);
if ($result_provinsi->num_rows > 0) {
    while ($row = $result_provinsi->fetch_assoc()) {
        $provinsi_options[] = $row;
    }
}

// Ambil data kota
$kota_options = [];
$sql_kota = "SELECT id, nama_kota FROM kota WHERE fk_provinsi_id = 1"; // Default ke provinsi_id 1
$result_kota = $conn->query($sql_kota);
if ($result_kota->num_rows > 0) {
    while ($row = $result_kota->fetch_assoc()) {
        $kota_options[] = $row;
    }
}

// Ambil data kecamatan
$kecamatan_options = [];
$sql_kecamatan = "SELECT id, nama_kecamatan FROM kecamatan WHERE fk_kota_id = 1"; // Default ke kota_id 1
$result_kecamatan = $conn->query($sql_kecamatan);
if ($result_kecamatan->num_rows > 0) {
    while ($row = $result_kecamatan->fetch_assoc()) {
        $kecamatan_options[] = $row;
    }
}

// Proses pendaftaran user
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['username']; // Menggunakan email sebagai username
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $fk_tipeuser_id = $_POST['fk_tipeuser_id']; // Pastikan nama ini sesuai
    $name_userprofile = $_POST['name_userprofile']; // Pastikan nama ini sesuai
    $fk_provinsi_id = $_POST['fk_provinsi_id']; // Pastikan nama ini sesuai
    $fk_kota_id = $_POST['fk_kota_id']; // Pastikan nama ini sesuai
    $fk_kecamatan_id = $_POST['fk_kecamatan_id']; // Pastikan nama ini sesuai
    $status_user = 1; // Default status user aktif
    $status_userprofile = 1; // Tambahkan status_userprofile jika diperlukan

    // Insert into user table
    $sql = "INSERT INTO user (username, password, status_user, fk_tipeuser_id) VALUES ('$email', '$password', $status_user, $fk_tipeuser_id)";
    if ($conn->query($sql) === TRUE) {
        $id = $conn->insert_id;

        // Insert into userprofile table
        $sql_profile = "INSERT INTO userprofile (id, name_userprofile, status_userprofile, fk_provinsi_id, fk_kota_id, fk_kecamatan_id) VALUES ($id, '$name_userprofile', $status_userprofile, $fk_provinsi_id, $fk_kota_id, $fk_kecamatan_id)";
        if ($conn->query($sql_profile) === TRUE) {
            echo "New user registered successfully";
        } else {
            echo "Error: " . $sql_profile . "<br>" . $conn->error;
        }
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    $conn->close();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Register User</title>
    <script>
        function fetchKota() {
            var provinsiId = document.getElementById("provinsi_id").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetch_kota.php?provinsi_id=" + provinsiId, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("kota_id").innerHTML = xhr.responseText;
                    fetchKecamatan(); // Fetch kecamatan based on the new kota
                }
            };
            xhr.send();
        }

        function fetchKecamatan() {
            var kotaId = document.getElementById("kota_id").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetch_kecamatan.php?kota_id=" + kotaId, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("kecamatan_id").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <h2>Register User</h2>
    <form action="register.php" method="post">
    <label for="username">Email:</label>
    <input type="email" id="username" name="username" required><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>
    
    <label for="fk_tipeuser_id">User Type:</label>
    <select id="fk_tipeuser_id" name="fk_tipeuser_id" required>
        <?php foreach ($tipeuser_options as $tipe): ?>
            <option value="<?php echo $tipe['id']; ?>"><?php echo $tipe['nama_tipeuser']; ?></option>
        <?php endforeach; ?>
    </select><br>
    
    <label for="name_userprofile">Full Name:</label>
    <input type="text" id="name_userprofile" name="name_userprofile" required><br>
    
    <label for="fk_provinsi_id">Province:</label>
    <select id="fk_provinsi_id" name="fk_provinsi_id" required onchange="fetchKota()">
        <?php foreach ($provinsi_options as $provinsi): ?>
            <option value="<?php echo $provinsi['id']; ?>"><?php echo $provinsi['nama_provinsi']; ?></option>
        <?php endforeach; ?>
    </select><br>
    
    <label for="fk_kota_id">City:</label>
    <select id="fk_kota_id" name="fk_kota_id" required onchange="fetchKecamatan()">
        <?php foreach ($kota_options as $kota): ?>
            <option value="<?php echo $kota['id']; ?>"><?php echo $kota['nama_kota']; ?></option>
        <?php endforeach; ?>
    </select><br>
    
    <label for="fk_kecamatan_id">District:</label>
    <select id="fk_kecamatan_id" name="fk_kecamatan_id" required>
        <?php foreach ($kecamatan_options as $kecamatan): ?>
            <option value="<?php echo $kecamatan['id']; ?>"><?php echo $kecamatan['nama_kecamatan']; ?></option>
        <?php endforeach; ?>
    </select><br>
    
    <input type="submit" value="Register">
</form>

</body>
</html>
