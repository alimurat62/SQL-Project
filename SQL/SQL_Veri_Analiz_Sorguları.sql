 -- 1. Tüm Kayýtlarý Listele
	-- Tüm kayýtlarý görmek için temel bir sorgu.
 SELECT * FROM Movies
 SELECT * FROM Actors
 SELECT * FROM Directors
 SELECT * FROM MovieActors
 SELECT * FROM Genres
 SELECT * FROM Ratings
 SELECT * FROM Users

-- 2. 2020 Sonrasý Çýkan Filmleri Getir
SELECT Title, ReleaseYear
FROM Movies
WHERE ReleaseYear > 2020;

-- 3. Türü "Dram" Olan Filmleri Listele
	-- Belirli bir türe ait filmleri görmek için.
SELECT m.Title, g.GenreName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
WHERE g.GenreName = 'Dram';

-- 4. Bütçesi 275 Milyon Üstü Filmleri Sýrala
	-- Yüksek bütçeli yapýmlarý görmek için.
SELECT Title, Budget
FROM Movies
WHERE Budget > 275000000
ORDER BY Budget DESC;


-- 5. Kadýn Yönetmenlerin Ýsimlerini Getir
	-- Kadýn yönetmenlerin listesini görmek için.

SELECT FirstName, LastName
FROM Directors
WHERE Gender = 'Kadýn';

-- 6. En Çok Ödül Almýþ Oyuncularý Sýrala
 -- Baþarýlý oyuncularý ödül sayýsýna göre sýralamak için.

SELECT FirstName, LastName, AwardsCount
FROM Actors
ORDER BY AwardsCount DESC;


-- 7. Bir Kullanýcýnýn Yorumlarýný Getir
	-- Bir kullanýcýya ait yorumlarý görmek için.

SELECT u.UserName, r.Comment, r.RatingValue, r.RatingDate
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
WHERE u.UserName = 'hakcay';


-- 8. Türkiye'den Oyuncularý Listele
	-- Belirli bir ülkeye ait oyuncularý filtrelemek için.

SELECT FirstName, LastName, Nationality
FROM Actors
WHERE Nationality = 'Türkiye';


 -- 9. Bir Filme Ait Oyuncularý ve Rolleri Getir
	-- Bir filmin kadrosunu ve rolleri görmek için.

SELECT m.Title, a.FirstName, a.LastName, ma.Role
FROM MovieActors ma
JOIN Movies m ON ma.MovieID = m.MovieID
JOIN Actors a ON ma.ActorID = a.ActorID
WHERE m.Title = 'Tian Shan';


-- 10. En Uzun Süreli 5 Filmi Listele
	-- Süreye göre sýralama ile uzun filmleri görmek için.

SELECT Title, DurationMinutes
FROM Movies
ORDER BY DurationMinutes DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Açýklama:
-- SQL Server’da OFFSET-FETCH yapýsýyla ilk 5 uzun film listelenir. TOP 5 da alternatif olabilir:

SELECT TOP 5 Title, DurationMinutes
FROM Movies
ORDER BY DurationMinutes DESC;


-- 11. Kullanýcýlarýn Verdiði Ortalama Puanlar
 -- Her kullanýcýnýn ortalama puanýný görmek için.

SELECT u.UserName, AVG(r.RatingValue) AS AvgRating
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
GROUP BY u.UserName;


 -- 12. "Emily Jones" Tarafýndan Yönetilen Filmleri Getir
 -- Belirli bir yönetmenin filmlerini listelemek için.

SELECT m.Title, m.ReleaseYear
FROM Movies m
JOIN Directors d ON m.DirectorID = d.DirectorID
WHERE d.FirstName = 'Emily' AND d.LastName = 'Jones';


-- 13. IMDb Tarzý 7.0 Üzeri Puan Alan Filmleri Getir
	-- Çok yüksek puan almýþ filmleri görmek için.

SELECT m.Title, AVG(r.RatingValue) AS AvgRating
FROM Movies m
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY m.Title
HAVING AVG(r.RatingValue) >= 7.0;

-- 14. 1950 Öncesi Doðumlu Yönetmenleri Listele
	-- Belirli yaþ üstü deneyimli yönetmenleri bulmak için.

SELECT FirstName, LastName, BirthDate
FROM Directors
WHERE BirthDate < '1950-01-01';


-- 15. Baþrol Oyuncularýný ve Oynadýklarý Filmleri Getir
	-- Filmlerde baþrol olan oyuncularýn listesini görmek için.

SELECT m.Title, a.FirstName, a.LastName, ma.Role
FROM MovieActors ma
JOIN Movies m ON ma.MovieID = m.MovieID
JOIN Actors a ON ma.ActorID = a.ActorID
WHERE ma.IsMainCharacter = 1;


-- 16. En Çok Filmde Oynayan Oyuncular
-- Oyuncularýn kaç filmde oynadýðýný listeler, sektörde en çok çalýþanlarý gösterir.

SELECT a.FirstName, a.LastName, COUNT(ma.MovieID) AS MovieCount
FROM Actors a
JOIN MovieActors ma ON a.ActorID = ma.ActorID
GROUP BY a.FirstName, a.LastName
ORDER BY MovieCount DESC;


-- 17. En Yüksek Ortalama Puan Alan Yönetmenler (En Az 3 Film)
-- Eleþtirmen beðenisi yüksek yönetmenleri ortaya çýkarýr.

SELECT d.FirstName, d.LastName, AVG(r.RatingValue) AS AvgRating, COUNT(DISTINCT m.MovieID) AS MovieCount
FROM Directors d
JOIN Movies m ON d.DirectorID = m.DirectorID
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY d.FirstName, d.LastName
HAVING COUNT(DISTINCT m.MovieID) >= 3
ORDER BY AvgRating DESC;



-- 18. En Çok Oy Alan 10 Film
-- Hangi filmler kullanýcýlar tarafýndan en çok oy almýþ? Popülerliði ölçer.

SELECT m.Title, COUNT(r.RatingID) AS TotalRatings
FROM Movies m
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY m.Title
ORDER BY TotalRatings DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- 19. Kullanýcýlarýn Puanladýðý En Son Film
-- Her kullanýcýnýn en son hangi filmi deðerlendirdiðini gösterir.

SELECT u.UserName, m.Title, r.RatingDate, r.RatingValue
FROM Ratings r
JOIN Users u ON r.UserID = u.UserID
JOIN Movies m ON r.MovieID = m.MovieID
WHERE r.RatingDate = (
	SELECT MAX(r2.RatingDate)
	FROM Ratings r2
	WHERE r2.UserID = r.UserID
);



-- 20. Hangi Türde Ortalama Puan Daha Yüksek?
-- Hangi film türü izleyiciden daha yüksek puan alýyor?

SELECT g.GenreName, AVG(r.RatingValue) AS AvgRating
FROM Genres g
JOIN Movies m ON g.GenreID = m.GenreID
JOIN Ratings r ON m.MovieID = r.MovieID
GROUP BY g.GenreName
ORDER BY AvgRating DESC;



-- 21. En Yüksek Giþe Geliri Getiren Yönetmenler
-- Giþe baþarýsý en yüksek yönetmenleri bulur.

SELECT d.FirstName, d.LastName, SUM(m.BoxOffice) AS TotalBoxOffice
FROM Directors d
JOIN Movies m ON d.DirectorID = m.DirectorID
GROUP BY d.FirstName, d.LastName
ORDER BY TotalBoxOffice DESC;



-- 22. Yaþ Gruplarýna Göre Kullanýcý Daðýlýmý (Dinamik Yaþ Hesabý ile)
-- Kullanýcý kitlesinin yaþ daðýlýmýný anlamak için çok kullanýþlý.

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


-- 23. Her Yýl Çekilen Film Sayýsý
-- Zaman içinde prodüksiyon eðilimini görürsün.

SELECT ReleaseYear, COUNT(*) AS MovieCount
FROM Movies
GROUP BY ReleaseYear
ORDER BY ReleaseYear;


-- 24. Kullanýcýlarýn En Çok Puanladýðý Tür
-- Her kullanýcýnýn en çok puanladýðý film türü. Tercih analizi saðlar.
-- Kullanýcýnýn her türe kaç oy verdiðini say
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

--  Her kullanýcýnýn en çok oy verdiði türdeki oy sayýsýný bul
KullaniciMaxOySayilari AS (
    SELECT 
        UserID,
        MAX(OySayisi) AS MaxOy
    FROM KullaniciTurOySayilari
    GROUP BY UserID
)

--  Sadece en çok oy verilen tür(ler)i getir
SELECT 
    k.UserName,
    k.GenreName,
    k.OySayisi
FROM KullaniciTurOySayilari k
JOIN KullaniciMaxOySayilari m ON k.UserID = m.UserID AND k.OySayisi = m.MaxOy
ORDER BY k.UserName;

