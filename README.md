# # 🎬 SQL Film Veritabanı Projesi

Bu proje, sinema sektörünü temel alan bir SQL veritabanı oluşturarak bu yapı üzerinde detaylı veri analizleri gerçekleştirmeyi amaçlamaktadır. Python dili kullanılarak yapay fakat gerçek dünyaya yakın nitelikte veriler üretilmiş, bu veriler SQL ortamına aktarılmış ve çeşitli analiz sorguları ile anlamlı bilgiler çıkarılmıştır.

---

## 📌 Projenin Hedefi

- Veri tabanı tasarımı ve ilişkisel veri modeli oluşturma yetkinliğini artırmak
- SQL dili ile veri çekme, filtreleme, gruplayarak analiz etme ve sonuçları yorumlama becerilerini geliştirmek
- Gerçek veri analiz senaryolarını simüle ederek raporlama ve karar destek çalışmalarına temel oluşturmak
- Python ile veri üretimi yaparak veri üretimi-saklama-analiz zincirinin tüm aşamalarını kapsayan bir örnek ortaya koymak

---

## 📁 Klasör Açıklamaları

### 📂 `data/` – Yapay Veri Setleri

Bu klasör, Python kullanılarak oluşturulmuş, sinema sektörünü modelleyen yapay ancak gerçek dünyaya uygun verileri içerir. Veriler, ilişkisel veritabanı tasarım ilkelerine ve normalizasyon kurallarına uygun olarak üretilmiştir. Her bir `.csv` dosyası, SQL veritabanındaki bir tabloya karşılık gelir.

- **`actors.csv`**  
  Oyunculara ait temel bilgiler:  
  *(FirstName)Ad, (LastName)Soyad, (BirthDate)Doğum tarihi, (Gender)Cinsiyet, (Nationality)Milliyet, (AwardsCount)Aldığı ödül sayısı, (Biography)Biyografi*

- **`directors.csv`**  
  Yönetmenlere dair bilgiler:  
  *(FirstName)Ad, (LastName)Soyad, (BirthDate)Doğum tarihi, (Gender)Cinsiyet, (Nationality)Milliyet, (AwardsCount)Aldığı ödül sayısı, (Biography)Biyografi*

- **`genres.csv`**  
  Film türleri ve açıklamaları:  
  *(GenreName)Tür adı, (Description)Açıklama*

- **`movies.csv`**  
  Filmlerin temel bilgileri:  
  *(Title)Film adı, (ReleaseYear)Yayın yılı, (DurationMinutes)Süresi (dk), (Language)Dil, (Country)Ülke, (Budget)Bütçe, (BoxOffice)Hasılat, (Description)Açıklama, (GenreID)Tür ID'si, (DirectorID)Yönetmen ID'si*

- **`ratings.csv`**  
  Kullanıcıların filmlere verdiği puanlar:  
  *(RatingValue)Puan (1.0–10.0), (Comment)Yorum, (RatingDate)Puan tarihi, (UserID)Kullanıcı ID’si, (MovieID)Film ID’si*

- **`users.csv`**  
  Kullanıcı profilleri:  
  *(UserName)Kullanıcı adı, (Email)E-posta, (Gender)Cinsiyet, (BirthDate)Doğum tarihi, (Country)Ülke, (RegistrationDate)Kayıt tarihi*

- **`movie_actors.csv`**  
  Oyuncular ile filmler arasındaki ilişki:  
  *(MovieID)Film ID’si, (ActorID)Oyuncu ID’si, (Role)Rol adı, (IsMainCharacter)Başrol mü (1=Evet, 0=Hayır)*

---

### `sql/`
SQL ile ilgili yapılar ve sorgular bu klasörde yer alır:

- `SinemaDB.sql`: Tabloların oluşturulduğu, ilişkilerin tanımlandığı veritabanı yapısını içeren dosya
- `movie_db_inserts.sql`: Yukarıdaki `data/` klasöründeki verilerin Pythonda SQL INSERT komutlarına dönüştürülmüş hali
- `SQL_Veri_Analiz_Sorguları.sql`: Veri analizi için yazılmış tüm SELECT sorguları

---

### 📊 `analiz-sonuclari/` Klasörü İçeriği

Bu klasör, SQL analiz sorguları sonucunda elde edilen CSV dosyalarını içerir. Her dosya, farklı bir sorgu sonucunu temsil eder.

1. **1. Tüm Verileri Getir.csv**  
   - `SELECT * FROM` sorgusu ile tüm verilerin çekildiği sorgu.

2. **2. 2020 sonrası çıkan filmleri getirme.csv**  
3. **3. Türü Dram Olan Filmleri Listele.csv**  
4. **4. Bütçesi 275 Milyon Üstü Filmleri Sırala.csv**  
5. **5. Kadın Yönetmenlerin İsimlerini Getir.csv**  
6. **6. En Çok Ödül Almış Oyuncuları Sırala.csv**  
7. **7. Bir Kullanıcının Yorumlarını Getir.csv**  
8. **8. Türkiye'den Oyuncuları Listele.csv**  
9. **9. Bir Filme Ait Oyuncuları ve Rolleri Getir.csv**  
10. **10. En Uzun Süreli 5 Filmi Listele.csv**  
11. **11. Kullanıcıların Verdiği Ortalama Puanlar.csv**  
12. **12. Emily Jones Tarafından Yönetilen Filmleri Getir.csv**  
13. **13. IMDb Tarzı 7.0 Üzeri Puan Alan Filmleri Getir.csv**  
14. **14. 1950 Öncesi Doğumlu Yönetmenleri Listele.csv**  
15. **15. Başrol Oyuncularını ve Oynadıkları Filmleri Getir.csv**  
16. **16. En Çok Filmde Oynayan Oyuncular.csv**  
17. **17. En Yüksek Ortalama Puan Alan Yönetmenler (En Az 3 Film).csv**  
18. **18. En Çok Oy Alan 10 Film.csv**  
19. **19. Kullanıcıların Puanladığı En Son Film.csv**  
20. **20. Hangi Türde Ortalama Puan Daha Yüksek.csv**  
21. **21. En Yüksek Gişe Geliri Getiren Yönetmenler.csv**  
22. **22. Yaş Gruplarına Göre Kullanıcı Dağılımı (Dinamik Yaş Hesabı ile).csv**  
23. **23. Her Yıl Çekilen Film Sayısı.csv**  
24. **24. Kullanıcıların En Çok Puanladığı Tür.csv**


---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|----------|----------|
| **SQL** | Veritabanı oluşturma, veri analizi ve raporlama |
| **Python (pandas, faker, csv)** | Veri üretimi, dışa aktarma ve dönüştürme işlemleri |
| **CSV** | Veri saklama ve paylaşım formatı |

