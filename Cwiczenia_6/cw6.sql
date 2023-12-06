--ZADANIE 1
UPDATE ksiegowosc.pracownicy
SET telefon = 
    CASE 
        WHEN id_pracownika IN (1, 4) THEN '111 222 333'
        WHEN id_pracownika IN (2, 8) THEN '457 880 256'
        WHEN id_pracownika IN (3, 5) THEN '256 027 487'
        WHEN id_pracownika IN (6, 10) THEN '289 145 263'
        WHEN id_pracownika IN (7, 9) THEN '756 144 426'
    END;

--1a
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon);
--concat służy do łączenia paru stringów w jeden dłuższy string

SELECT pracownicy.telefon FROM ksiegowosc.pracownicy

--1b -poprawić!!!!!!!
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(
    LEFT(telefon, 9),
    '-',
    SUBSTRING(telefon FROM 11 FOR 3),
    '-',
    RIGHT(telefon, 3));

--1c
SELECT UPPER(pracownicy.nazwisko) AS najdluzsze_nazwisko 
FROM ksiegowosc.pracownicy
ORDER BY LENGTH(pracownicy.nazwisko) DESC
LIMIT 1;

--1d - środowisko nie widzi funkcji MD5
SELECT imie, nazwisko, MD5(pensja.kwota) AS pensja_MD5
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pensji
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji;

--1e
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota, COALESCE(premia.kwota, 0) AS premia
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii;

--1f
SELECT
CONCAT('Pracownik ', pracownicy.imie, ' ', pracownicy.nazwisko, ', w dniu ', godziny.data, 
' otrzymał pensję całkowitą na kwotę ',
SUM(COALESCE(premia.kwota, 0) + pensja.kwota), ' zł,',
' gdzie wynagrodzenie zasadnicze wynosiło: ', pensja.kwota, 'zł, premia: ', 
SUM(COALESCE(premia.kwota, 0)), ' zł.') AS raport
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN ksiegowosc.godziny ON wynagrodzenie.id_pracownika = godziny.id_pracownika
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_wynagrodzenia = premia.id_premii
GROUP BY pracownicy.imie, pracownicy.nazwisko, godziny.data, pensja.kwota;

--ZADANIE 2
CREATE SCHEMA cw6;

--tabela1
CREATE TABLE cw6.pracownicy(
IDPracownika varchar PRIMARY KEY,
NazwaLekarza varchar NOT NULL );

INSERT INTO cw6.pracownicy
(IDPracownika, NazwaLekarza)
VALUES
    ('S1011', 'Maria Nowak'),
    ('S1045', 'Anna Jabłońska'),
    ('S1034', 'Marek Potocki');

CREATE TABLE cw6.pacjenci(
    IDPacjenta varchar PRIMARY KEY,
    NazwaPacjenta varchar NOT NULL);

INSERT INTO cw6.pacjenci
(IDPacjenta, NazwaPacjenta)
VALUES
    ('P100', 'Anna Jeleń'),
    ('P105', 'Jarosław Nicpoń'),
    ('P120', 'Jan Kałuża'),
    ('P130', 'Jerzy Lis'),
    ('P123', 'Olga Nowacka'),
    ('P108', 'Joanna Nosek');

CREATE TABLE cw6.wizyty(
    IDPacjenta varchar NOT NULL,
    DataGodzinaWizyty timestamp PRIMARY KEY,
    IDPracownika varchar,
    IDZabiegu varchar);

INSERT INTO cw6.wizyty
(IDPacjenta, IDPracownika, IDZabiegu, DataGodzinaWizyty)
VALUES    
('P100', 'S1011', 'Z500', '2020-03-12 10:00:00'),
('P105', 'S1011', 'Z496', '2020-03-12 13:00:00'),
('P120', 'S1045', 'Z500', '2020-03-18 9:00:00'),
('P130', 'S1034', 'Z496', '2020-03-20 8:00:00'),
('P123', 'S1034', 'Z503', '2020-03-12 15:00:00'),
('P108', 'S1011', 'Z500', '2020-03-14 10:00:00'),
('P108', 'S1024', 'Z503', '2020-03-16 17:00:00');

CREATE TABLE cw6.zabiegi(
    IDZabiegu varchar PRIMARY KEY,
    NazwaZabiegu varchar NOT NULL);

INSERT INTO cw6.zabiegi
(IDZabiegu, NazwaZabiegu)
VALUES
    ('Z500', 'Borowanie'),
    ('Z496', 'Lakowanie'),
    ('Z503', 'Usuwanie kamienia');

ALTER TABLE cw6.wizyty
--ADD CONSTRAINT IDPracownika
--FOREIGN KEY (IDPracownika) REFERENCES cw6.pracownicy(IDPracownika),
ADD CONSTRAINT IDPacjenta
FOREIGN KEY (IDPacjenta) REFERENCES cw6.pacjenci(IDPacjenta),
ADD CONSTRAINT IDZabiegu
FOREIGN KEY (IDZabiegu) REFERENCES cw6.zabiegi(IDZabiegu);


SELECT
wizyty.DataGodzinaWizyty, pracownicy.NazwaLekarza, pacjenci.NazwaPacjenta, zabiegi.NazwaZabiegu
FROM cw6.wizyty
JOIN cw6.pracownicy ON wizyty.IDPracownika = pracownicy.IDPracownika
JOIN cw6.pacjenci ON wizyty.IDPacjenta = pacjenci.IDPacjenta
JOIN cw6.zabiegi ON wizyty.IDZabiegu = zabiegi.IDZabiegu;


--tabela2
CREATE TABLE cw6.Produkty( 
NazwaProduktu varchar PRIMARY KEY,
cenaNetto float,
cenaBrutto float);

INSERT INTO cw6.Produkty
(NazwaProduktu, cenaNetto, cenaBrutto)
VALUES
('makaron nitki', 130, 150),
('keczup pikantny', 200, 220),
('sos pomidorowy', 89, 110);

CREATE TABLE cw6.Dostawcy
(NazwaDostawcy varchar,
AdresDostawcy varchar);

INSERT INTO cw6.Dostawcy
(NazwaDostawcy, AdresDostawcy)
VALUES
('Makarony Polskie', 'Turystyczna 40, 31-435 Kraków' ),
('Lubelski Makaron', 'Piłsudskiego 332a, 04-242 Lublin'),
('Polskie przetwory', 'Wojska Polskiego 44a, 31-342 Kraków'),
('Przetwory pomidorowe', 'Rolnicza 22/4 30-243 Tarnów'),
('Małopolskie smaki', 'Mickiewicza 223/77, 35-434 Nowy Targ' );

CREATE TABLE cw6.Dostawcy_Produktow(
    identyfikator int PRIMARY KEY,
    NazwaProduktu varchar,
    NazwaDostawcy varchar,
    FOREIGN KEY (NazwaProduktu) REFERENCES cw6.Produkty(NazwaProduktu));
    --FOREIGN KEY (NazwaDostawcy) REFERENCES cw6.Dostawcy(NazwaDostawcy));

INSERT INTO cw6.Dostawcy_Produktow
(identyfikator, NazwaProduktu, NazwaDostawcy)
VALUES
    (1, 'makaron nitki', 'Makarony Polskie'),
    (2, 'makaron nitki', 'Lubelski Makaron'),
    (3, 'keczup pikantny', 'Przetwory pomidorowe'),
    (4, 'keczup pikantny', 'Polskie przetwory'),
    (5, 'sos pomidorowy', 'Polskie przetwory'),
    (6, 'sos pomidorowy', 'Małopolskie smaki');

SELECT
Produkty.NazwaProduktu, Produkty.cenaNetto, Produkty.cenaBrutto, Dostawcy.NazwaDostawcy, Dostawcy.AdresDostawcy
FROM cw6.Produkty
JOIN cw6.Dostawcy_Produktow ON Produkty.NazwaProduktu = Dostawcy_Produktow.NazwaProduktu
JOIN cw6.Dostawcy ON Dostawcy_Produktow.NazwaDostawcy = Dostawcy.NazwaDostawcy;