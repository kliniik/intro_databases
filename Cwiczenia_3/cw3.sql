/*zadania 1 i 2 - ręcznie*/
/*zadanie 3*/
CREATE TABLE rozliczenia.pracownicy
(id_pracownika int NOT NULL,
 imie varchar,
 nazwisko varchar,
 adres varchar,
 telefon varchar, 
 /*teoretycznie nie będą wykonywane żadne
 operacje arytmetyczne, więc ciąg znaków wystaczy*/
PRIMARY KEY (id_pracownika));
 
 CREATE TABLE rozliczenia.godziny
 (id_godziny int NOT NULL, 
 data date, 
 liczba_godzin int, 
 id_pracownika int,
 PRIMARY KEY (id_godziny));
 
CREATE TABLE rozliczenia.pensje
(id_pensji int NOT NULL,
stanowisko varchar,
kwota float,
id_premii int,
PRIMARY KEY (id_pensji));

CREATE TABLE rozliczenia.premie
(id_premii int NOT NULL,
rodzaj varchar,
kwota float,
PRIMARY KEY (id_premii));

ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT id_pracownika
FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika); 

/*zadanie 4*/
INSERT INTO rozliczenia.pracownicy
(id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Jan', 'Kowalski', 'ul. Przykładowa 123', '555-123-456'),
(2, 'Anna', 'Nowak', 'ul. Inna 456', '555-789-123'),
(3, 'Marek', 'Wójcik', 'ul. Spokojna 789', '555-456-789'),
(4, 'Katarzyna', 'Lis', 'ul. Prosta 1', '555-111-222'),
(5, 'Andrzej', 'Szymański', 'ul. Nad Rzeką 7', '555-777-888'),
(6, 'Maria', 'Nowacka', 'ul. Górska 22', '555-999-333'),
(7, 'Piotr', 'Dąbrowski', 'ul. Lasowa 55', '555-444-666'),
(8, 'Ewa', 'Kamińska', 'ul. Wschodnia 10', '555-222-555'),
(9, 'Tomasz', 'Zając', 'ul. Dolna 15', '555-666-444'),
(10, 'Magdalena', 'Woźniak', 'ul. Polna 17', '555-123-987');

INSERT INTO rozliczenia.godziny
(id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2023-10-01', 8, 1),
(2, '2023-10-02', 7, 3),
(3, '2023-10-02', 6, 5),
(4, '2023-10-17', 9, 7),
(5, '2023-10-03', 8, 9),
(6, '2023-10-01', 8, 2),
(7, '2023-10-02', 10, 4),
(8, '2023-10-23', 7, 6),
(9, '2023-10-30', 5, 8),
(10, '2023-11-02', 8, 10);

INSERT INTO rozliczenia.premie
(id_premii, rodzaj, kwota)
VALUES
(1, 'Bonus świąteczny', 500.00),
(2, 'Dodatek motywacyjny', 300.00),
(3, 'Nagroda jubileuszowa', 1000.00),
(4, 'Bonus za nadgodziny', 400.00),
(5, 'Bonus świąteczny', 500.00),
(6, 'Nagroda jubileuszowa', 1400.00),
(7, 'Bonus urodzinowy', 200.00),
(8, 'Dodatek motywacyjny', 250.00),
(9, 'Dodatek motywacyjny', 350.00),
(10, 'Bonus za nadgodziny', 550.00);

INSERT INTO rozliczenia.pensje
(id_pensji, stanowisko, kwota, id_premii)
VALUES
(1, 'Kierownik', 8000.00, 10),
(2, 'Programista', 10300.00, 9),
(3, 'Księgowy', 5500.00, 8),
(4, 'Analityk', 6200.00, 7),
(5, 'Sprzedawca', 4700.00, 6),
(6, 'Inżynier', 7000.00, 5),
(7, 'Asystent', 3600.00, 4),
(8, 'Project Manager', 8500.00, 3),
(9, 'Designer', 5900.00, 2),
(10, 'Technik', 4800.00, 1);

/*zadanie 5*/
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

/*zadanie 6*/
SELECT EXTRACT(DOW FROM data) FROM rozliczenia.godziny;
/*0 to niedziela, 1 poniedziałek, itp*/
SELECT EXTRACT(MONTH FROM data) FROM rozliczenia.godziny;

/*zadanie 7*/
ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto float;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * (1-0.12);

SELECT kwota_netto FROM rozliczenia.pensje;