 -- 1. T�m Kay�tlar� Listele
	-- T�m kay�tlar� g�rmek i�in temel bir sorgu.
 SELECT * FROM Movies
 SELECT * FROM Actors
 SELECT * FROM Directors
 SELECT * FROM MovieActors
 SELECT * FROM Genres
 SELECT * FROM Ratings
 SELECT * FROM Users

-- 2. 2020 Sonras� ��kan Filmleri Getir
SELECT Title, ReleaseYear
FROM Movies
WHERE ReleaseYear > 2020;

-- 3. T�r� "Dram" Olan Filmleri Listele
	-- Belirli bir t�re ait filmleri g�rmek i�in.
SELECT m.Title, g.GenreName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
WHERE g.GenreName = 'Dram';

-- 4. B�t�esi 275 Milyon �st� Filmleri S�rala
	-- Y�ksek b�t�eli yap�mlar� g�rmek i�in.
SELECT Title, Budget
FROM Movies
WHERE Budget > 275000000
ORDER BY Budget DESC;


-- 5. Kad�n Y�netmenlerin �simlerini Getir
	-- Kad�n y�netmenlerin listesini g�rmek i�in.

SELECT FirstName, LastName
FROM Directors
WHERE Gender = 'Kad�n';

-- 6. En �ok �d�l Alm�� Oyuncular� S�rala
 -- Ba�ar�l� oyuncular� �d�l say�s�na g�re s�ralamak i�in.

SELECT FirstName, LastName, AwardsCount
FROM Actors
ORDER BY AwardsCount DESC;


-- 7. Bir Kullan�c�n�n Yorumlar�n� Getir
	-- Bir kullan�c�ya ait yorumlar� g�rmek i�in.

SELECT u.UserName, r.Comment, r.RatingValue, r.RatingDate
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
WHERE u.UserName = 'hakcay';


-- 8. T�rkiye'den Oyuncular� Listele
	-- Belirli bir �lkeye ait oyuncular� filtrelemek i�in.

SELECT FirstName, LastName, Nationality
FROM Actors
WHERE Nationality = 'T�rkiye';


 -- 9. Bir Filme Ait Oyuncular� ve Rolleri Getir
	-- Bir filmin kadrosunu ve rolleri g�rmek i�in.

SELECT m.Title, a.FirstName, a.LastName, ma.Role
FROM MovieActors ma
JOIN Movies m ON ma.MovieID = m.MovieID
JOIN Actors a ON ma.ActorID = a.ActorID
WHERE m.Title = 'Tian Shan';


-- 10. En Uzun S�reli 5 Filmi Listele
	-- S�reye g�re s�ralama ile uzun filmleri g�rmek i�in.

SELECT Title, DurationMinutes
FROM Movies
ORDER BY DurationMinutes DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- A��klama:
-- SQL Server�da OFFSET-FETCH yap�s�yla ilk 5 uzun film listelenir. TOP 5 da alternatif olabilir:

SELECT TOP 5 Title, DurationMinutes
FROM Movies
ORDER BY DurationMinutes DESC;


-- 11. Kullan�c�lar�n Verdi�i Ortalama Puanlar
 -- Her kullan�c�n�n ortalama puan�n� g�rmek i�in.

SELECT u.UserName, AVG(r.RatingValue) AS AvgRating
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
GROUP BY u.UserName;


 -- 12. "Emily Jones" Taraf�ndan Y�netilen Filmleri Getir
 -- Belirli bir y�netmenin filmlerini listelemek i�in.

SELECT m.Title, m.ReleaseYear
FROM Movies m
JOIN Directors d ON m.DirectorID = d.DirectorID
WHERE d.FirstName = 'Emily' AND d.LastName = 'Jones';


-- 13. IMDb Tarz� 7.0 �zeri Puan Alan Filmleri Getir
	-- �ok y�ksek puan alm�� filmleri g�rmek i�in.

SELECT m.Title, AVG(r.RatingValue) AS AvgRating
FROM Movies m
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY m.Title
HAVING AVG(r.RatingValue) >= 7.0;

-- 14. 1950 �ncesi Do�umlu Y�netmenleri Listele
	-- Belirli ya� �st� deneyimli y�netmenleri bulmak i�in.

SELECT FirstName, LastName, BirthDate
FROM Directors
WHERE BirthDate < '1950-01-01';


-- 15. Ba�rol Oyuncular�n� ve Oynad�klar� Filmleri Getir
	-- Filmlerde ba�rol olan oyuncular�n listesini g�rmek i�in.

SELECT m.Title, a.FirstName, a.LastName, ma.Role
FROM MovieActors ma
JOIN Movies m ON ma.MovieID = m.MovieID
JOIN Actors a ON ma.ActorID = a.ActorID
WHERE ma.IsMainCharacter = 1;


-- 16. En �ok Filmde Oynayan Oyuncular
-- Oyuncular�n ka� filmde oynad���n� listeler, sekt�rde en �ok �al��anlar� g�sterir.

SELECT a.FirstName, a.LastName, COUNT(ma.MovieID) AS MovieCount
FROM Actors a
JOIN MovieActors ma ON a.ActorID = ma.ActorID
GROUP BY a.FirstName, a.LastName
ORDER BY MovieCount DESC;


-- 17. En Y�ksek Ortalama Puan Alan Y�netmenler (En Az 3 Film)
-- Ele�tirmen be�enisi y�ksek y�netmenleri ortaya ��kar�r.

SELECT d.FirstName, d.LastName, AVG(r.RatingValue) AS AvgRating, COUNT(DISTINCT m.MovieID) AS MovieCount
FROM Directors d
JOIN Movies m ON d.DirectorID = m.DirectorID
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY d.FirstName, d.LastName
HAVING COUNT(DISTINCT m.MovieID) >= 3
ORDER BY AvgRating DESC;



-- 18. En �ok Oy Alan 10 Film
-- Hangi filmler kullan�c�lar taraf�ndan en �ok oy alm��? Pop�lerli�i �l�er.

SELECT m.Title, COUNT(r.RatingID) AS TotalRatings
FROM Movies m
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY m.Title
ORDER BY TotalRatings DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- 19. Kullan�c�lar�n Puanlad��� En Son Film
-- Her kullan�c�n�n en son hangi filmi de�erlendirdi�ini g�sterir.

SELECT u.UserName, m.Title, r.RatingDate, r.RatingValue
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
JOIN Movies m ON r.MovieID = m.MovieID
WHERE r.RatingDate = (
	SELECT MAX(r2.RatingDate)
	FROM Ratings r2
	WHERE r2.UserID = r.UserID
);



-- 20. Hangi T�rde Ortalama Puan Daha Y�ksek?
-- Hangi film t�r� izleyiciden daha y�ksek puan al�yor?

SELECT g.GenreName, AVG(r.RatingValue) AS AvgRating
FROM Genres g
JOIN Movies m ON g.GenreID = m.GenreID
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY g.GenreName
ORDER BY AvgRating DESC;



-- 21. En Y�ksek Gi�e Geliri Getiren Y�netmenler
-- Gi�e ba�ar�s� en y�ksek y�netmenleri bulur.

SELECT d.FirstName, d.LastName, SUM(m.BoxOffice) AS TotalBoxOffice
FROM Directors d
JOIN Movies m ON d.DirectorID = m.DirectorID
GROUP BY d.FirstName, d.LastName
ORDER BY TotalBoxOffice DESC;



-- 22. Ya� Gruplar�na G�re Kullan�c� Da��l�m� (Dinamik Ya� Hesab� ile)
-- Kullan�c� kitlesinin ya� da��l�m�n� anlamak i�in �ok kullan��l�.

SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 18 AND 24 THEN '18-24'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 25 AND 34 THEN '25-34'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        ELSE '50+' 
    END AS AgeGroup,
    COUNT(*) AS UserCount
FROM Users
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 18 AND 24 THEN '18-24'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 25 AND 34 THEN '25-34'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        ELSE '50+' 
    END;


-- 23. Her Y�l �ekilen Film Say�s�
-- Zaman i�inde prod�ksiyon e�ilimini g�r�rs�n.

SELECT ReleaseYear, COUNT(*) AS MovieCount
FROM Movies
GROUP BY ReleaseYear
ORDER BY ReleaseYear;


-- 24. Kullan�c�lar�n En �ok Puanlad��� T�r
-- Her kullan�c�n�n en �ok puanlad��� film t�r�. Tercih analizi sa�lar.
-- Kullan�c�n�n her t�re ka� oy verdi�ini say
WITH KullaniciTurOySayilari AS (
    SELECT 
        u.UserID,
        u.UserName,
        g.GenreID,
        g.GenreName,
        COUNT(*) AS OySayisi
    FROM Ratings r
    JOIN Users u ON r.UserID = u.UserID
    JOIN Movies m ON r.MovieID = m.MovieID
    JOIN Genres g ON m.GenreID = g.GenreID
    GROUP BY u.UserID, u.UserName, g.GenreID, g.GenreName
),

--  Her kullan�c�n�n en �ok oy verdi�i t�rdeki oy say�s�n� bul
KullaniciMaxOySayilari AS (
    SELECT 
        UserID,
        MAX(OySayisi) AS MaxOy
    FROM KullaniciTurOySayilari
    GROUP BY UserID
)

--  Sadece en �ok oy verilen t�r(ler)i getir
SELECT 
    k.UserName,
    k.GenreName,
    k.OySayisi
FROM KullaniciTurOySayilari k
JOIN KullaniciMaxOySayilari m ON k.UserID = m.UserID AND k.OySayisi = m.MaxOy
ORDER BY k.UserName;

