<?php
// Adatbázis kapcsolat
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "munkahelyimuszakbeosztas";

$conn = new mysqli($servername, $username, $password, $dbname);

//kapcsolat ellenőrzése
if ($conn->connect_error) {
    die("Kapcsolati hiba: " . $conn->connect_error);
}

//mentés gomb
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    foreach ($_POST['muszakbeosztas_id'] as $key => $id) {
        $dolgozoazonosito = $_POST['dolgozoazonosito'][$key];
        $reszlegazonosito = $_POST['reszlegazonosito'][$key];
        $datum = $_POST['datum'][$key];
        $feladatkor = $_POST['feladatkor'][$key];
        $munkaoraszam = $_POST['munkaoraszam'][$key];

        //frissít
        $updateSql = "UPDATE muszakbeosztasok 
                      SET dolgozoazonosito = '$dolgozoazonosito',
                          reszlegazonosito = '$reszlegazonosito',
                          datum = '$datum',
                          feladatkor = '$feladatkor',
                          munkaoraszam = '$munkaoraszam'
                      WHERE muszakbeosztas_id = '$id'";
        $conn->query($updateSql);
    }
    echo "<p>Adatok frissítve!</p>";
}

//adatok lekérdezése
$sql = "SELECT muszakbeosztas_id, dolgozoazonosito, reszlegazonosito, datum, feladatkor, munkaoraszam FROM muszakbeosztasok";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Szerkeszthető Beosztások</title>
</head>
<body>
    <h1>Szerkeszthető Műszakbeosztások</h1>
    <form method="POST" action="">
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Dolgozó Azonosító</th>
                <th>Részleg Azonosító</th>
                <th>Dátum</th>
                <th>Feladatkör</th>
                <th>Munkaóraszám</th>
            </tr>

            <?php if ($result->num_rows > 0): ?>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td>
                            <?php echo $row['muszakbeosztas_id']; ?>
                            <input type="hidden" name="muszakbeosztas_id[]" value="<?php echo $row['muszakbeosztas_id']; ?>">
                        </td>
                        <td><input type="text" name="dolgozoazonosito[]" value="<?php echo $row['dolgozoazonosito']; ?>"></td>
                        <td><input type="text" name="reszlegazonosito[]" value="<?php echo $row['reszlegazonosito']; ?>"></td>
                        <td><input type="date" name="datum[]" value="<?php echo $row['datum']; ?>"></td>
                        <td><input type="text" name="feladatkor[]" value="<?php echo $row['feladatkor']; ?>"></td>
                        <td><input type="number" name="munkaoraszam[]" value="<?php echo $row['munkaoraszam']; ?>"></td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6">Nincsenek elérhető adatok</td>
                </tr>
            <?php endif; ?>
        </table>
        <br>
        <button type="submit">Mentés</button>
    </form>
</body>
</html>

<?php $conn->close(); ?>
