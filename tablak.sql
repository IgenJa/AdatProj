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
