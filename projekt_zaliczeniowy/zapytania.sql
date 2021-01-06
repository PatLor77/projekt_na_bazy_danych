1.SELECT * FROM `sklepy` INNER JOIN produkty ON sklepy.id_sklepu = produkty.id_produktu
2. SELECT produkty.nazwa_produktu,produkty.Rodzaj_produktu,sklepy.nazwa_sklepu FROM produkty LEFT OUTER JOIN sklepy ON produkty.id_produktu=sklepy.id_sklepu
3. SELECT dostawcy.imie,dostawcy.nazwisko,firma.nazwa_firmy,firma.adres_firmy FROM dostawcy RIGHT OUTER JOIN firma ON dostawcy.id_dostawcy = firma.id_firmy
4. SELECT pochodzenie.kraj,pochodzenie.id_pochodzenia,produkty.nazwa_produktu FROM pochodzenie LEFT JOIN produkty ON pochodzenie.id_pochodzenia = produkty.id_produktu GROUP BY id_pochodzenia
5. SELECT pochodzenie.id_pochodzenia,pochodzenie.kraj,produkty.nazwa_produktu,produkty.Rodzaj_produktu FROM `pochodzenie`RIGHT JOIN produkty ON pochodzenie.id_pochodzenia = produkty.id_produktu WHERE produkty.Rodzaj_produktu= "owoc" group by pochodzenie.id_pochodzenia ASC
6. SELECT dostawcy.imie, dostawcy.nazwisko,dostawcy.id_dostawcy,firma.nazwa_firmy FROM `firma` INNER JOIN dostawcy ON dostawcy.id_dostawcy = firma.id_firmy GROUP BY id_dostawcy DESC
7. SELECT cennik FROM `firma` WHERE cennik > any(SELECT cena from produkty)
8. SELECT produkty.id_produktu,AVG(cena) FROM `produkty` group BY produkty.id_produktu HAVING avg(cena)>30
9. DELETE FROM `dostawcy` WHERE id_dostawcy ='4'
10. UPDATE `dostawcy` SET `id_dostawcy`='4',`imie`='Patryk',`nazwisko`='Cole',`id_firmy`='3' WHERE id_dostawcy='2'
