CREATE DATABASE IF NOT EXISTS `munkahelyimuszakbeosztas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `munkahelyimuszakbeosztas`;

DROP TABLE IF EXISTS `reszlegek`;
DROP TABLE IF EXISTS `munkavallalo`;
DROP TABLE IF EXISTS `dolgozo`;
DROP TABLE IF EXISTS `felelos_operator`;
DROP TABLE IF EXISTS `muszakbeosztasok`;
DROP TABLE IF EXISTS `vezeto`;
DROP TABLE IF EXISTS `beosztott`;
DROP TABLE IF EXISTS `muszakbeosztas`;

-- Táblák létrehozása
CREATE TABLE reszlegek (
    reszlegazonosito INT PRIMARY KEY,
    reszleg_neve VARCHAR(255),
    reszleg_helye VARCHAR(255)
);

CREATE TABLE munkavallalo (
    azonosito INT PRIMARY KEY,
    elotag VARCHAR(50),
    nev VARCHAR(255),
    munkakori_beosztas VARCHAR(255),
    jelszo VARCHAR(255)
);

CREATE TABLE dolgozo (
    dolgozoazonosito INT PRIMARY KEY,
    azonosito INT,
    FOREIGN KEY (azonosito) REFERENCES munkavallalo(azonosito)
);

CREATE TABLE felelos_operator (
    azonosito INT PRIMARY KEY,
    FOREIGN KEY (azonosito) REFERENCES munkavallalo(azonosito)
);

CREATE TABLE muszakbeosztasok (
    muszakbeosztas_id INT PRIMARY KEY,
    dolgozoazonosito INT,
    reszlegazonosito INT,
    datum DATE,
    feladatkor VARCHAR(255),
    munkaoraszam INT,
    FOREIGN KEY (dolgozoazonosito) REFERENCES dolgozo(dolgozoazonosito),
    FOREIGN KEY (reszlegazonosito) REFERENCES reszlegek(reszlegazonosito)
);

CREATE TABLE vezeto (
    azonosito INT PRIMARY KEY,
    reszlegazonosito INT,
    FOREIGN KEY (azonosito) REFERENCES munkavallalo(azonosito),
    FOREIGN KEY (reszlegazonosito) REFERENCES reszlegek(reszlegazonosito)
);

CREATE TABLE beosztott (
    azonosito INT PRIMARY KEY,
    dolgozoazonosito INT,
    FOREIGN KEY (azonosito) REFERENCES munkavallalo(azonosito),
    FOREIGN KEY (dolgozoazonosito) REFERENCES dolgozo(dolgozoazonosito)
);

CREATE TABLE muszakbeosztas (
    muszakbeosztas_id INT PRIMARY KEY,
    dolgozoazonosito INT,
    FOREIGN KEY (muszakbeosztas_id) REFERENCES muszakbeosztasok(muszakbeosztas_id),
    FOREIGN KEY (dolgozoazonosito) REFERENCES dolgozo(dolgozoazonosito)
);

-- Táblák feltöltése véletlenszerű adatokkal
INSERT INTO reszlegek (reszlegazonosito, reszleg_neve, reszleg_helye)
VALUES
(1, 'HR', 'Budapest'),
(2, 'IT', 'Szeged'),
(3, 'Marketing', 'Debrecen'),
(4, 'Finance', 'Győr'),
(5, 'Sales', 'Pécs'),
(6, 'Support', 'Miskolc'),
(7, 'Logistics', 'Kecskemét'),
(8, 'Production', 'Székesfehérvár'),
(9, 'R&D', 'Tatabánya'),
(10, 'Legal', 'Eger');

INSERT INTO munkavallalo (azonosito, elotag, nev, munkakori_beosztas, jelszo)
VALUES
(1, 'Mr.', 'Kovács István', 'Fejlesztő', 'pasw1'),
(2, 'Ms.', 'Nagy Anna', 'HR Manager', 'pasw2'),
(3, 'Dr.', 'Szabó Péter', 'Marketing Vezető', 'pasw3'),
(4, 'Mr.', 'Tóth Gábor', 'Pénzügyi Elemző', 'pasw4'),
(5, 'Ms.', 'Kiss Éva', 'Értékesítési Vezető', 'pasw5'),
(6, 'Mr.', 'Varga László', 'Ügyfélszolgálati Munkatárs', 'pasw6'),
(7, 'Ms.', 'Molnár Zsuzsanna', 'Logisztikai Koordinátor', 'pasw7'),
(8, 'Mr.', 'Németh Tamás', 'Gyártásvezető', 'pasw8'),
(9, 'Dr.', 'Horváth Katalin', 'Kutató', 'pasw9'),
(10, 'Mr.', 'Balogh János', 'Jogi Tanácsadó', 'pasw10'),
(11, 'Mr.', 'Farkas Béla', 'Fejlesztő', 'pasw11'),
(12, 'Ms.', 'Tóth Mária', 'HR Manager', 'pasw12'),
(13, 'Dr.', 'Kiss Péter', 'Marketing Vezető', 'pasw13'),
(14, 'Mr.', 'Nagy Gábor', 'Pénzügyi Elemző', 'pasw14'),
(15, 'Ms.', 'Szabó Éva', 'Értékesítési Vezető', 'pasw15'),
(16, 'Mr.', 'Molnár László', 'Ügyfélszolgálati Munkatárs', 'pasw16'),
(17, 'Ms.', 'Varga Zsuzsanna', 'Logisztikai Koordinátor', 'pasw17'),
(18, 'Mr.', 'Németh Tamás', 'Gyártásvezető', 'pasw18'),
(19, 'Dr.', 'Horváth Katalin', 'Kutató', 'pasw19'),
(20, 'Mr.', 'Balogh János', 'Jogi Tanácsadó', 'pasw20');

INSERT INTO dolgozo (dolgozoazonosito, azonosito)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

INSERT INTO felelos_operator (azonosito)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

INSERT INTO muszakbeosztasok (muszakbeosztas_id, dolgozoazonosito, reszlegazonosito, datum, feladatkor, munkaoraszam)
VALUES
(1, 1, 1, '2024-01-01', 'Fejlesztés', 8),
(2, 2, 2, '2024-01-02', 'HR feladatok', 8),
(3, 3, 3, '2024-01-03', 'Marketing kampány', 8),
(4, 4, 4, '2024-01-04', 'Pénzügyi elemzés', 8),
(5, 5, 5, '2024-01-05', 'Értékesítési stratégia', 8),
(6, 6, 6, '2024-01-06', 'Ügyfélszolgálat', 8),
(7, 7, 7, '2024-01-07', 'Logisztikai tervezés', 8),
(8, 8, 8, '2024-01-08', 'Gyártás', 8),
(9, 9, 9, '2024-01-09', 'Kutatás', 8),
(10, 10, 10, '2024-01-10', 'Jogi tanácsadás', 8),
(11, 11, 1, '2024-01-11', 'Fejlesztés', 8),
(12, 12, 2, '2024-01-12', 'HR feladatok', 8),
(13, 13, 3, '2024-01-13', 'Marketing kampány', 8),
(14, 14, 4, '2024-01-14', 'Pénzügyi elemzés', 8),
(15, 15, 5, '2024-01-15', 'Értékesítési stratégia', 8),
(16, 16, 6, '2024-01-16', 'Ügyfélszolgálat', 8),
