# DATABASE-TOKO-BUKU
## ERD PADA TOKO BUKU
Entity Relationship Diagram (ERD) untuk sebuah toko buku bisa mencakup beberapa entitas utama seperti Buku, Pelanggan, Pesanan, dan Penerbit. Entitas Buku akan memiliki atribut seperti ISBN, judul, penulis, genre, dan harga. Entitas Pelanggan akan mencakup atribut ID pelanggan, nama, alamat, dan nomor telepon. Entitas Pesanan akan memiliki atribut ID pesanan, tanggal pesanan, dan jumlah total, serta hubungan dengan entitas Buku dan Pelanggan, dimana satu pesanan bisa terdiri dari beberapa buku dan satu pelanggan bisa membuat banyak pesanan. Entitas Penerbit akan mencakup atribut ID penerbit, nama penerbit, dan alamat penerbit, serta memiliki hubungan dengan entitas Buku, di mana satu penerbit bisa menerbitkan banyak buku. Relasi antara entitas-entitas tersebut mencerminkan bagaimana data saling terhubung dan membantu mengorganisir informasi dengan efisien di dalam sistem basis data toko buku.
## RELASI
*Buku - Penerbit:
1.Banyak buku diterbitkan oleh satu penerbit(MANY TO ONE).
2.Foreign Key: PublisherID di tabel Buku mengacu pada PublisherID di tabel Penerbit.
*Pesanan - Pelanggan:
1.Banyak pesanan dilakukan oleh satu pelanggan(MANY TO ONE).
2.Foreign Key: CustomerID di tabel Pesanan mengacu pada CustomerID di tabel Pelanggan.
*Pesanan - Buku (melalui Detail Pesanan):
1.Satu pesanan dapat mencakup banyak buku dan satu buku dapat ada di banyak pesanan(MANY TO MANY).
2.Implementasi: Menggunakan tabel OrderDetail yang memiliki Foreign Keys OrderID dan ISBN.
*Detail Pesanan - Pesanan:
1.Banyak detail pesanan terkait dengan satu pesanan(MANY TO ONE)
2.Foreign Key: OrderID di tabel Detail Pesanan mengacu pada OrderID di tabel Pesanan.
*Detail Pesanan - Buku:
1.Banyak detail pesanan terkait dengan satu buku(MANY TO ONE)
2.Foreign Key: ISBN di tabel Detail Pesanan mengacu pada ISBN di tabel Buku.
Berikut adalah diagram visual dari relasi-relasi tersebut:

#DESKRIPSI TOKO BUKU
**Latar Belakang**
Toko buku ini didirikan untuk memenuhi kebutuhan masyarakat akan literatur dan bahan bacaan berkualitas. Dengan berkembangnya teknologi dan perubahan gaya hidup, kebutuhan akan sistem manajemen toko buku yang efisien dan terorganisir semakin meningkat. Toko buku ini bertujuan untuk menyediakan berbagai jenis buku dari berbagai genre dan penulis, serta memberikan layanan yang mudah dan cepat bagi pelanggan.

**Tujuan**
1.Meningkatkan Efisiensi Operasional: Mengelola inventaris buku, pesanan pelanggan, dan hubungan dengan penerbit secara efisien.
2.Peningkatan Penjualan: Mengoptimalkan proses penjualan dan promosi untuk meningkatkan penjualan buku.
3.Pencatatan dan Pelaporan: Menyediakan sistem pelaporan yang akurat dan real-time untuk analisis bisnis dan pengambilan keputusan.
**Ruang Lingkup**
1.Manajemen Inventaris: Melacak stok buku, penerimaan barang, dan pengembalian buku.
2.Manajemen Pelanggan: Mengelola informasi pelanggan, riwayat pembelian, dan preferensi mereka.
3.Manajemen Pesanan: Memproses pesanan dari pelanggan, termasuk pemesanan, pengiriman, dan pembayaran.
4.Hubungan dengan Penerbit: Mengelola data penerbit dan buku yang diterbitkan oleh mereka.
5.Pelaporan dan Analisis: Menyediakan laporan penjualan, stok, dan kinerja toko untuk analisis lebih lanjut.
**Spesifikasi Teknis**
1.User Interface: Antarmuka yang ramah pengguna untuk pengelolaan inventaris, pesanan, dan pelanggan.
2.Authentication: Sistem login dan manajemen pengguna untuk keamanan data.
3.Reporting Tools: Modul pelaporan untuk analisis penjualan, inventaris, dan kinerja toko.
Teknologi yang Digunakan:
1.Database Management System (DBMS): MySQL atau PostgreSQL untuk manajemen data.
2.Backend Development: Menggunakan bahasa pemrograman seperti Python atau Java.
3.Frontend Development: HTML, CSS, JavaScript, dan framework seperti React atau Angular.
4.Deployment: Aplikasi di-host di server yang andal dengan dukungan backup dan pemulihan data.
Dengan pendekatan ini, toko buku dapat memastikan operasional yang lancar, meningkatkan pengalaman pelanggan, dan memaksimalkan penjualan.
## SKEMA BASIS DATA

```
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    PublisherID INT,
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address TEXT,
    Phone VARCHAR(20)
);
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY AUTO_INCREMENT,
    PublisherName VARCHAR(255) NOT NULL,
    PublisherAddress TEXT
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderID INT,
    ISBN VARCHAR(13),
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ISBN),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);
INSERT INTO Publishers (PublisherName, PublisherAddress) VALUES
('Penerbit A', 'Jl. Penerbit A No. 1'),
('Penerbit B', 'Jl. Penerbit B No. 2');

INSERT INTO Books (ISBN, Title, Author, Genre, Price, PublisherID) VALUES
('9781234567897', 'Buku A', 'Penulis A', 'Fiksi', 100000, 1),
('9781234567898', 'Buku B', 'Penulis B', 'Non-Fiksi', 150000, 2);

INSERT INTO Customers (Name, Address, Phone) VALUES
('Customer A', 'Jl. Customer A No. 1', '081234567890'),
('Customer B', 'Jl. Customer B No. 2', '081234567891');


INSERT INTO Orders (OrderDate, TotalAmount, CustomerID) VALUES
('2024-06-25', 250000, 1),
('2024-06-26', 150000, 2);

INSERT INTO OrderDetails (OrderID, ISBN, Quantity) VALUES
(1, '9781234567897', 2),
(1, '9781234567898', 1),
(2, '9781234567898', 1);
```

## TRIGGER
Trigger untuk otomatis memperbarui total pesanan setiap kali detail pesanan ditambahkan atau diubah:

```
CREATE TRIGGER update_total_amount
AFTER INSERT OR UPDATE ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(Quantity * b.Price)
    INTO total
    FROM OrderDetails od
    JOIN Books b ON od.ISBN = b.ISBN
    WHERE od.OrderID = NEW.OrderID;
    
    UPDATE Orders
    SET TotalAmount = total
    WHERE OrderID = NEW.OrderID;
END;
```


## VIEW
View untuk menampilkan informasi pesanan beserta nama pelanggan dan detail buku:

```
CREATE VIEW OrderSummary AS
SELECT o.OrderID, o.OrderDate, c.Name AS CustomerName, b.Title AS BookTitle, od.Quantity, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Books b ON od.ISBN = b.ISBN;
```


## OPERASI AGREGAT
Query untuk menghitung total jumlah buku yang terjual dari setiap buku:


```
SELECT b.Title, SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Books b ON od.ISBN = b.ISBN
GROUP BY b.Title;
```


## INDEKS
Membuat indeks pada kolom ISBN dan CustomerID untuk mempercepat pencarian:

```
CREATE INDEX idx_isbn ON Books(ISBN);
CREATE INDEX idx_customerid ON Customers(CustomerID);
```


## LEFT JOIN
Query untuk menampilkan semua pelanggan dan pesanan mereka (jika ada):

```
SELECT c.Name, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
```


## INNER JOIN
Query untuk menampilkan detail pesanan dengan informasi buku dan pelanggan:

```
SELECT o.OrderID, c.Name AS CustomerName, b.Title AS BookTitle, od.Quantity
FROM OrderDetails od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Books b ON od.ISBN = b.ISBN;
```


## SUBQUERY
Query untuk menampilkan buku yang tidak pernah dipesan:

```
SELECT ISBN, Title
FROM Books
WHERE ISBN NOT IN (SELECT DISTINCT ISBN FROM OrderDetails);
```


## HAVING
Query untuk menampilkan pelanggan yang telah memesan lebih dari 3 buku:

```
SELECT c.CustomerID, c.Name, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
HAVING COUNT(o.OrderID) > 3;
```


## WILDCARD
Query untuk mencari buku yang judulnya mengandung kata 'Fiksi':

```
SELECT ISBN, Title
FROM Books
WHERE Title LIKE '%Fiksi%';
```
Dengan elemen-elemen ini, basis data toko buku menjadi lebih lengkap dan siap untuk mendukung berbagai operasi manajemen dan analisis data.










