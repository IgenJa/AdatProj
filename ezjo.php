<?php
//kapcsolatok beállítása
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "munkahelyimuszakbeosztas";

//kapcsolat létrehoz
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kapcsolódási hiba: " . $conn->connect_error);
}

//bejelentkezés ellenőrzés
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $felhasznalonev = $_POST["username"];
    $jelszo = $_POST["password"];

    //sql adatok lekérdezése
    $sql = "SELECT m.azonosito, d.dolgozoazonosito, fo.azonosito AS felelos_operator_azonosito
            FROM munkavallalo m
            LEFT JOIN dolgozo d ON m.azonosito = d.azonosito
            LEFT JOIN felelos_operator fo ON m.azonosito = fo.azonosito
            WHERE m.nev = ? AND m.jelszo = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $felhasznalonev, $jelszo);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if (!is_null($row['dolgozoazonosito'])) {
            //ha dolgozó
            header("Location: beosztasok.html");
            exit();
        } elseif (!is_null($row['felelos_operator_azonosito'])) {
            //ha operátor
            header("Location: felelosoperatorok.html");
            exit();
        } else {
            //egyéb
            echo "Ismeretlen felhasználói típus!";
        }
    } else {
        //erorr
        echo "Hibás felhasználónév vagy jelszó!";
    }

    $stmt->close();
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bejelentkezés</title>
</head>
<body>
    <h2>Bejelentkezés</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <label for="username">Felhasználónév:</label>
        <input type="text" id="username" name="username" required>
        <br><br>
        <label for="password">Jelszó:</label>
        <input type="password" id="password" name="password" required>
        <br><br>
        <button type="submit">Bejelentkezés</button>
    </form>
</body>
</html>
