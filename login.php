<?php
//adatbázis kapcsolódási adatok
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "login_system";

try {
    //kapcsolódás az adatbázishoz
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    //ellenőrzés
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $user = $_POST['username'];
        $pass = $_POST['password'];

        //felhasználó lekérdezése
        $sql = "SELECT * FROM users WHERE username = :username";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':username', $user);
        $stmt->execute();

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result && hash('sha256', $pass) === $result['password']) {
            echo "Sikeres bejelentkezés, Üdvözlünk " . htmlspecialchars($result['username']) . "!";
        } else {
            echo "Hibás felhasználónév vagy jelszó!";
        }
    }
} catch (PDOException $e) {
    echo "Hiba: " . $e->getMessage();
}

$conn = null;
?>
