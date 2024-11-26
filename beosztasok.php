<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beosztások megtekintése</title>
</head>
<body>
    <h1>Beosztások megtekintése</h1>

    <?php
    // Adatbázis kapcsolat
    $servername = "localhost";
    $username = "root"; // Alapértelmezett felhasználónév
    $password = ""; // Alapértelmezett jelszó, ha nincs, hagyd üresen
    $dbname = "munkahelyimuszakbeosztas";

    // Kapcsolat létrehozása
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Kapcsolat ellenőrzése
    if ($conn->connect_error) {
        die("Kapcsolati hiba: " . $conn->connect_error);
    }

    // Lekérdezés
    $sql = "SELECT muszakbeosztas_id, dolgozoazonosito, reszlegazonosito, datum, feladatkor, munkaoraszam FROM muszakbeosztasok";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table border='1'>";
        echo "<tr><th>ID</th><th>Dolgozó Azonosító</th><th>Részleg Azonosító</th><th>Dátum</th><th>Feladatkör</th><th>Munkaóraszám</th></tr>";

        // Eredmények megjelenítése
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["muszakbeosztas_id"] . "</td>";
            echo "<td>" . $row["dolgozoazonosito"] . "</td>";
            echo "<td>" . $row["reszlegazonosito"] . "</td>";
            echo "<td>" . $row["datum"] . "</td>";
            echo "<td>" . $row["feladatkor"] . "</td>";
            echo "<td>" . $row["munkaoraszam"] . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Nincs elérhető adat.";
    }

    // Kapcsolat bezárása
    $conn->close();
    ?>

</body>
</html>
