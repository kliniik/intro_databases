--zadanie 2
CREATE SCHEMA ksiegowosc;

--zadanie 3
CREATE TABLE ksiegowosc.pracownicy
(id_pracownika int PRIMARY KEY,
 imie varchar NOT NULL,
 nazwisko varchar NOT NULL,
 adres varchar NOT NULL,
 telefon varchar);


CREATE TABLE ksiegowosc.godziny
(id_godziny int PRIMARY KEY,
 data date NOT NULL,
 liczba_godzin int,
 id_pracownika int);
 
CREATE TABLE ksiegowosc.pensja
(id_pensji int PRIMARY KEY,
 stanowisko varchar, 
 kwota float NOT NULL);
  
CREATE TABLE ksiegowosc.premia
(id_premii int PRIMARY KEY,
 rodzaj varchar,
 kwota float NOT NULL);
   
CREATE TABLE ksiegowosc.wynagrodzenie
(id_wynagrodzenia int PRIMARY KEY,
 data date NOT NULL,
 id_pracownika int,
 id_pensji int,
 id_premii int);
 
ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT id_pracownika 
FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika); 


ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT id_pracownika
FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT id_premii
FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT id_pensji
FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);

--zadanie 4
INSERT INTO ksiegowosc.pracownicy
(id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Anna', 'Kowalska', 'ul. Kwiatowa 5, Warszawa', '123-456-789'),
(2, 'Piotr', 'Nowak', 'ul. Słoneczna 10, Kraków', '987-654-321'),
(3, 'Magda', 'Wiśniewska', 'ul. Leśna 3, Gdańsk', '555-111-222'),
(4, 'Marcin', 'Jankowski', 'ul. Morska 8, Szczecin', '777-888-999'),
(5, 'Ewa', 'Lis', 'ul. Polna 15, Poznań', '333-444-555'),
(6, 'Krzysztof', 'Wójcik', 'ul. Łąkowa 7, Wrocław', '666-999-111'),
(7, 'Monika', 'Sadowska', 'ul. Wiatrowa 2, Łódź', '222-333-444'),
(8, 'Bartosz', 'Dąbrowski', 'ul. Różana 12, Katowice', '888-777-666'),
(9, 'Karolina', 'Nowicka', 'ul. Jaskółcza 4, Lublin', '555-222-777'),
(10, 'Michał', 'Kaczmarek', 'ul. Brzozowa 9, Gdynia', '111-444-888');

INSERT INTO ksiegowosc.godziny
(id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2023-01-01', 8, 1),
(2, '2023-01-02', 7, 2),
(3, '2023-01-03', 6, 3),
(4, '2023-01-04', 8, 4),
(5, '2023-01-05', 7, 5),
(6, '2023-01-06', 9, 6),
(7, '2023-01-07', 8, 7),
(8, '2023-01-08', 7, 8),
(9, '2023-01-09', 6, 9),
(10, '2023-01-10', 8, 10);

INSERT INTO ksiegowosc.pensja
(id_pensji, stanowisko, kwota)
VALUES
(1, 'Kierownik', 10000),
(2, 'Inżynier Oprogramowania', 7000),
(3, 'Księgowy', 5500),
(4, 'Manager Projektu', 8000),
(5, 'Doradca Klienta', 4500),
(6, 'Analityk Finansowy', 65000),
(7, 'Administrator Systemów', 7500),
(8, 'Specjalista ds. Marketingu', 6000),
(9, 'Przedstawiciel Handlowy', 5000),
(10, 'Architekt Systemowy', 8500);

INSERT INTO ksiegowosc.premia
(id_premii, rodzaj, kwota)
VALUES
(1, 'Bonus świąteczny', 500.00),
(2, 'Dodatek motywacyjny', 300.00),
(3, 'Nagroda jubileuszowa', 1000.00),
(4, 'Bonus za nadgodziny', 400.00),
(5, 'Bonus świąteczny', 500.00),
(6, 'Nagroda jubileuszowa', 1400.00),
(7, 'Bonus świąteczny', 200.00),
(8, 'Dodatek motywacyjny', 250.00),
(9, 'Nagroda za osiągnięcia', 600.00),
(10, 'Bonus za nadgodziny', 550.00);

INSERT INTO ksiegowosc.wynagrodzenie
(id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES
(1, '2023-01-15', 1, 1, 2),
(2, '2023-01-15', 2, 2, 4),
(3, '2023-01-15', 3, 3, 3),
(4, '2023-01-15', 4, 4, 6),
(5, '2023-01-15', 5, 5, 3),
(6, '2023-01-15', 6, 6, 9),
(7, '2023-01-15', 7, 7, 5),
(8, '2023-01-15', 8, 8, 7),
(9, '2023-01-15', 9, 9, 10),
(10, '2023-01-15', 10, 10, 9);

--zadanie 5
--a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE pensja.kwota > 1000;

--c
UPDATE ksiegowosc.wynagrodzenie
SET id_premii = NULL
WHERE id_pracownika IN (5, 7, 2);

SELECT id_pracownika FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE (premia.id_premii IS NULL AND pensja.kwota > 2000);

--d
UPDATE ksiegowosc.pracownicy
SET imie = 'Jan'
WHERE id_pracownika = 10;

SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

--e
SELECT * FROM ksiegowosc.pracownicy
--WHERE (nazwisko LIKE '%n%a' OR nazwisko LIKE '%N%a');
WHERE LOWER(nazwisko) LIKE '%n%a';

--f
--mnożę liczbę godzin dla danego pracownika razy 
-- +-25 dni w miesiącu

SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika
WHERE (liczba_godzin*25) > 160;

--g
UPDATE ksiegowosc.pensja
SET kwota = 2700
WHERE stanowisko = 'Doradca Klienta';

SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE (pensja.kwota > 1500 AND pensja.kwota < 3000);

--h
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika
LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = wynagrodzenie.id_premii
WHERE (liczba_godzin*25 > 160 AND premia.id_premii IS NULL);

--i
SELECT imie, nazwisko, stanowisko, kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja on wynagrodzenie.id_pensji = pensja.id_pensji
ORDER BY pensja.kwota DESC;


--j
SELECT imie, nazwisko, pensja.kwota, COALESCE (premia.kwota, 0) AS premia
/*zwróci niepustą wartość, czyli jeśli premia to NULL (wartość pusta)
pod kwotę podstawi 0, w przeciwnym razie zwróci po prostu kwotę*/
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
ORDER BY (pensja.kwota + COALESCE (premia.kwota, 0)) DESC;

--k
UPDATE ksiegowosc.pensja
SET stanowisko = 'Kierownik'
WHERE stanowisko = 'Analityk Finansowy';

SELECT stanowisko, COUNT(*) AS liczba_pracowników
FROM ksiegowosc.pensja
GROUP BY stanowisko;

--l
SELECT stanowisko,
AVG(pensja.kwota) AS srednia,
MIN(pensja.kwota) AS minimalna,
MAX(pensja.kwota) AS maksymalna
FROM ksiegowosc.pensja
WHERE pensja.stanowisko = 'Kierownik'
GROUP BY stanowisko;

--m
SELECT SUM(kwota) AS wszystkie_wynagrodzenia
FROM ksiegowosc.pensja;

--n 
SELECT stanowisko,
SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja
GROUP BY stanowisko;

--o
SELECT stanowisko,
SUM(premia.kwota) AS suma_premii
FROM ksiegowosc.premia
JOIN ksiegowosc.wynagrodzenie ON premia.id_premii = wynagrodzenie.id_wynagrodzenia
JOIN ksiegowosc.pensja on wynagrodzenie.id_pensji = pensja.id_pensji
GROUP BY stanowisko;

--p
--zmieniam warunek na pensję < 5500, żeby kogokolwiek usunąć
DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (
	SELECT id_pracownika FROM ksiegowosc.wynagrodzenie
	JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
	WHERE pensja.kwota < 5500);





