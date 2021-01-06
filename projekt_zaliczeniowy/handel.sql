-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 06 Sty 2021, 14:20
-- Wersja serwera: 10.4.17-MariaDB
-- Wersja PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `handel`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedura` ()  NO SQL
SELECT * FROM produkty where id_produktu ="5"$$

--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `funkcja` (`p0` INT(20)) RETURNS TEXT CHARSET utf8 COLLATE utf8_polish_ci NO SQL
IF( SELECT COUNT(*) FROM produkty WHERE id_produktu = @p0 AND cena<30)>0 THEN RETURN "spoko" ; else RETURN "nie dobrze";
END IF$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dostawcy`
--

CREATE TABLE `dostawcy` (
  `id_dostawcy` int(20) NOT NULL,
  `imie` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `id_firmy` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `dostawcy`
--

INSERT INTO `dostawcy` (`id_dostawcy`, `imie`, `nazwisko`, `id_firmy`) VALUES
(1, 'Przemysław', 'Czarnkowski', 1),
(3, 'Oliwia', 'Ziemska', 3),
(5, 'Olaf', 'Siwobrody', 2),
(7, 'Feliks', 'Kociszek', 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `firma`
--

CREATE TABLE `firma` (
  `id_firmy` int(20) NOT NULL,
  `id_dostawcy` int(20) NOT NULL,
  `nazwa_firmy` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `adres_firmy` varchar(60) COLLATE utf8_polish_ci NOT NULL,
  `cennik` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `firma`
--

INSERT INTO `firma` (`id_firmy`, `id_dostawcy`, `nazwa_firmy`, `adres_firmy`, `cennik`) VALUES
(1, 1, 'DPD', 'ul.Kaziemirza 31 Lublin', 15),
(2, 5, 'Autonomix', 'ul.Kozła 19 Poznań', 60),
(3, 3, 'CzarodzjskaTransport', 'ul.Michała Anioła 7 Szczecin', 100),
(4, 7, 'Elchupakabratrans', 'ul.Wojtyły 88 Kalisz', 5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `odbiór`
--

CREATE TABLE `odbiór` (
  `id_odbioru` int(20) NOT NULL,
  `id_sklepu` int(20) NOT NULL,
  `id_dostawcy` int(20) NOT NULL,
  `id_firmy` int(20) NOT NULL,
  `id_pochodzenia` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `odbiór`
--

INSERT INTO `odbiór` (`id_odbioru`, `id_sklepu`, `id_dostawcy`, `id_firmy`, `id_pochodzenia`) VALUES
(1, 1, 3, 3, 4),
(2, 2, 1, 1, 2),
(3, 3, 7, 4, 1),
(4, 4, 5, 2, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pochodzenie`
--

CREATE TABLE `pochodzenie` (
  `id_pochodzenia` int(20) NOT NULL,
  `id_firmy` int(20) NOT NULL,
  `kraj` varchar(45) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `pochodzenie`
--

INSERT INTO `pochodzenie` (`id_pochodzenia`, `id_firmy`, `kraj`) VALUES
(1, 4, 'Finlandia'),
(2, 1, 'Madagaskar'),
(3, 2, 'Chiny'),
(4, 3, 'Niemcy'),
(5, 3, 'Hiszpania'),
(6, 1, 'Norwegia'),
(7, 1, 'Niemcy'),
(8, 2, 'Włochy'),
(9, 2, 'Polska'),
(10, 4, 'Holandia');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id_produktu` int(20) NOT NULL,
  `id_pochodzenia` int(20) NOT NULL,
  `nazwa_produktu` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `Rodzaj_produktu` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `Cena` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `produkty`
--

INSERT INTO `produkty` (`id_produktu`, `id_pochodzenia`, `nazwa_produktu`, `Rodzaj_produktu`, `Cena`) VALUES
(1, 2, 'Mango', 'owoc', 20),
(2, 1, 'Masełko', 'nabiał', 40),
(3, 4, 'Kebab', 'Jedzenie', 32),
(4, 3, 'Liczi', 'Smoczy owoc', 17),
(5, 5, 'banan', 'owoc', 12),
(6, 6, 'ryba', 'jedzenie', 60),
(7, 7, 'hamburger', 'jedzenie', 14),
(8, 8, 'pizza', 'jedzenie', 23),
(9, 9, 'mleko', 'nabiał', 17),
(10, 10, 'monte', 'nabiał', 6),
(11, 2, 'Melon', 'owoc', 37);

--
-- Wyzwalacze `produkty`
--
DELIMITER $$
CREATE TRIGGER `wyzwalacz2` AFTER INSERT ON `produkty` FOR EACH ROW INSERT INTO tabelka2 VALUES (null, NEW.id_produktu, NEW.id_pochodzenia)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sklepy`
--

CREATE TABLE `sklepy` (
  `id_sklepu` int(11) NOT NULL,
  `id_produktu` int(20) NOT NULL,
  `id_dostawcy` int(20) NOT NULL,
  `nazwa_sklepu` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `adres_sklepu` varchar(45) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `sklepy`
--

INSERT INTO `sklepy` (`id_sklepu`, `id_produktu`, `id_dostawcy`, `nazwa_sklepu`, `adres_sklepu`) VALUES
(1, 3, 3, 'Kebix', 'ul.Mickiewicza 88 Zgorzelec'),
(2, 1, 1, 'Biedronka', 'ul.Albrechta 69 Białystok'),
(3, 2, 7, 'Lewiatan', 'ul.Kustosza 35 Olsztyn'),
(4, 4, 5, 'Owoce Świata', 'ul.Akacjowa 77 Częstochowa'),
(5, 10, 4, 'hill', 'ul.grodzka 65 kraków');

--
-- Wyzwalacze `sklepy`
--
DELIMITER $$
CREATE TRIGGER `wyzwalacz1` AFTER INSERT ON `sklepy` FOR EACH ROW INSERT INTO tabelka VALUES (null, NEW.id_produktu, NEW.id_sklepu)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tabelka`
--

CREATE TABLE `tabelka` (
  `id` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `id_sklepu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `tabelka`
--

INSERT INTO `tabelka` (`id`, `id_produktu`, `id_sklepu`) VALUES
(2, 10, 5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tabelka2`
--

CREATE TABLE `tabelka2` (
  `id` int(20) NOT NULL,
  `id_produktu` int(20) NOT NULL,
  `id_pochodzenia` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `tabelka2`
--

INSERT INTO `tabelka2` (`id`, `id_produktu`, `id_pochodzenia`) VALUES
(2, 11, 2);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dostawcy`
--
ALTER TABLE `dostawcy`
  ADD PRIMARY KEY (`id_dostawcy`),
  ADD UNIQUE KEY `id_firmy` (`id_dostawcy`);

--
-- Indeksy dla tabeli `firma`
--
ALTER TABLE `firma`
  ADD PRIMARY KEY (`id_firmy`);

--
-- Indeksy dla tabeli `odbiór`
--
ALTER TABLE `odbiór`
  ADD PRIMARY KEY (`id_odbioru`);

--
-- Indeksy dla tabeli `pochodzenie`
--
ALTER TABLE `pochodzenie`
  ADD PRIMARY KEY (`id_pochodzenia`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`);

--
-- Indeksy dla tabeli `sklepy`
--
ALTER TABLE `sklepy`
  ADD PRIMARY KEY (`id_sklepu`);

--
-- Indeksy dla tabeli `tabelka`
--
ALTER TABLE `tabelka`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `tabelka2`
--
ALTER TABLE `tabelka2`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `produkty`
--
ALTER TABLE `produkty`
  MODIFY `id_produktu` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `sklepy`
--
ALTER TABLE `sklepy`
  MODIFY `id_sklepu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `tabelka`
--
ALTER TABLE `tabelka`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `tabelka2`
--
ALTER TABLE `tabelka2`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
