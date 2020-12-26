create database LICHMAYD
go
use LICHMAYD
go
CREATE TABLE PHICONG 
(
	MaPC VARCHAR(30) NOT NULL PRIMARY KEY,
	TenPC VARCHAR(30),
	TrinhDo VARCHAR(30),
	NamKN INT
)

CREATE TABLE LOAIMAYBAY
(
	MaLoai VARCHAR(30) NOT NULL PRIMARY KEY,
	LoaiMB VARCHAR(30),
	DongCo VARCHAR(30),
	TocDoToiThieu VARCHAR(30),
	TocDoToiDa VARCHAR(30)
)

CREATE TABLE MAYBAY
(
	SoHieuMB VARCHAR(30) NOT NULL PRIMARY KEY,
	MaLoai VARCHAR(30),
	NgayBatDauSD DATETIME
	FOREIGN KEY (MaLoai) REFERENCES LOAIMAYBAY(MaLoai)
)

CREATE TABLE LICHTRINHBAY
(
	MaLT VARCHAR(30) NOT NULL PRIMARY KEY,
	SoHieuMB VARCHAR(30),
	MaPC VARCHAR(30),
	NoiDi VARCHAR(30),
	NoiDen VARCHAR(30),
	ThoiGianDi SMALLDATETIME,
	ThoiGianDen SMALLDATETIME

	FOREIGN KEY (SoHieuMB) REFERENCES MAYBAY(SoHieuMB),
	FOREIGN KEY (MaPC) REFERENCES PHICONG (MaPC)
)

INSERT INTO LOAIMAYBAY VALUES('L01','Boeing 747','tuoc bin canh quat','1000 km/h', '3000km/h')
INSERT INTO LOAIMAYBAY VALUES('L02','A321','tuoc bin phan luc','1500 km/h', '3200km/h')
INSERT INTO LOAIMAYBAY VALUES('L03','Boeing 747','tuoc bin roc ket','1100 km/h', '2500km/h')

INSERT INTO MAYBAY VALUES('VN01','L01','2015-05-20')
INSERT INTO MAYBAY VALUES('JS02','L01','2015-05-21')
INSERT INTO MAYBAY VALUES('AS01','L02','2015-05-22')

INSERT INTO PHICONG VALUES('PC01','Tran Dinh Nam','Co Pho',3)
INSERT INTO PHICONG VALUES('PC02','jonh henry','Co Truong',8)

INSERT INTO LICHTRINHBAY VALUES('LT001','VN01','PC02','Ha Noi','Da Nang','2015/05/20 14:00', '2015/05/20 16:00')
INSERT INTO LICHTRINHBAY VALUES('LT002','AS01','PC01','Da Nang','Thai Lan','2015/04/13 08:00', '2015/04/13 13:00')

--1.Liệt kê thông tin toàn bộ máy bay.
SELECT *FROM MAYBAY

--2.Xoá toàn bộ máy bay sử dụng động cơ là 'tuoc bin rocket'
DELETE FROM MAYBAY 
WHERE MaLoai IN (SELECT MaLoai FROM LOAIMAYBAY WHERE DongCo='tuoc bin roc ket')
 
--3.Cập nhật giá trị của trường NamKN trong bảng PHICONG thành 5 nếu trường NamKN đang có giá trị là 3.
UPDATE PHICONG SET NamKN=5 WHERE NamKN=3

--4.Liệt kê thông tin của những máy bay thuộc loại 'Boeing 747' được bắt đầu sử dụng từ ngày 01/01/2014 
--và những máy bay thuộc loại 'A321' được bắt đầu sử dụng*** trước **ngày 12/31/2014.
SELECT l.LoaiMB, d.NgayBatDauSD FROM LOAIMAYBAY l
INNER JOIN MAYBAY d ON d.MaLoai=l.MaLoai
WHERE (l.LoaiMB='Boeing 747' AND d.NgayBatDauSD='2014-01-01') OR (l.LoaiMB='A321' AND d.NgayBatDauSD <'2014-12-31')

--5.Liệt kê những phi công có tên bắt đầu là ký tự 'N' và có độ dài là 7 ký tự.
SELECT t.MaPC,t.TenPC FROM PHICONG t
WHERE t.TenPC LIKE 'N______'

--6.Liệt kê toàn bộ máy bay, sắp xếp giảm dần theo MaLoai và tăng dần theo NgayBatDauSD.
SELECT MaLoai, day(NgayBatDauSD) AS ngay FROM MAYBAY 
GROUP BY MaLoai,NgayBatDauSD
ORDER BY MaLoai DESC, ngay ASC

--7.Đếm số lần bay tương ứng theo từng phi công, chỉ đếm các lần bay được thực hiện bay trong năm 2014.
SELECT phi.MaPC,phi.TenPC, COUNT(DISTINCT MaLT) AS Soluong FROM PHICONG phi
INNER JOIN LICHTRINHBAY l ON l.MaPC = phi.MaPC
WHERE year(l.ThoiGianDi) = 2014
GROUP BY phi.MaPC, phi.TenPC

--8.Liệt kê tên của toàn bộ phi công (tên nào giống nhau thì chỉ liệt kê một lần).
SELECT DISTINCT t.TenPC FROM PHICONG t

--9.Liệt kê SoHieu, MaLoai, TenPC, NoiDi, NoiDen, ThoiGianDi, ThoiGianDen (của tất cả các lần bay của các máy bay).
SELECT a.SoHieuMB, m.MaLoai, p.TenPC, a.NoiDi, a.NoiDen, a.ThoiGianDi, a.ThoiGianDen
FROM LICHTRINHBAY a
INNER JOIN PHICONG p ON p.MaPC=a.MaPC
INNER JOIN MAYBAY m ON m.SoHieuMB=a.SoHieuMB

--10.Liệt kê SoHieu, MaLoai, TenPC, NoiDi, NoiDen, ThoiGianDi, ThoiGianDen của tất cả các lần bay của máy bay
--(Liệt kê cả những máy bay chưa được bay lần nào).
SELECT m.SoHieuMB, m.MaLoai, p.TenPC, a.NoiDi, a.NoiDen, a.ThoiGianDi, a.ThoiGianDen
FROM MAYBAY m
LEFT JOIN LICHTRINHBAY a ON a.SoHieuMB =m.SoHieuMB
LEFT JOIN PHICONG p ON p.MaPC = a.MaPC
--11.Liệt kê SoHieu, MaLoai của những máy bay đã thực hiện bay với điểm xuất phát từ sân bay 'Ha noi' 
--hoặc thuộc loại máy bay là 'Boeing 747'.
SELECT s.SoHieuMB, s.MaLoai FROM MAYBAY s
INNER JOIN LICHTRINHBAY a ON s.SoHieuMB = a.SoHieuMB
INNER JOIN LOAIMAYBAY b ON b.MaLoai = s.MaLoai
WHERE (a.NoiDi='Ha noi') OR (b.LoaiMB='Boeing 747')

--12.Liệt kê SoHieu, MaLoai của những máy bay chưa từng thực hiện bay lần nào.
--c1
SELECT s.SoHieuMB, s.MaLoai FROM MAYBAY s
WHERE NOT EXISTS 
(
	SELECT *FROM LICHTRINHBAY a
	WHERE (a.SoHieuMB=s.SoHieuMB)
)
--c2
SELECT SoHieuMB, MaLoai FROM MAYBAY 
WHERE SoHieuMB NOT IN (SELECT SoHieuMB FROM LICHTRINHBAY)
--13.Liệt kê SoHieu, MaLoai của những máy bay đã từng thực hiện bay với điểm xuất phát từ sân bay 'Ha noi' 
--và chưa từng thực hiện bay lần nào với điểm xuất phát là sân bay 'Thanh pho Ho Chi Minh'.
--c1
SELECT s.SoHieuMB, s.MaLoai FROM MAYBAY s
INNER JOIN LICHTRINHBAY a ON a.SoHieuMB = s.SoHieuMB
WHERE (a.SoHieuMB = s.SoHieuMB AND a.NoiDi='Ha Noi')
AND NOT EXISTS(
	SELECT *FROM LICHTRINHBAY a
	WHERE (a.SoHieuMB = s.SoHieuMB AND a.NoiDi='Thanh pho Ho Chi Minh')
)
--c2
select SoHieuMB, MaLoai from MAYBAY where SoHieuMB in
(select SoHieuMB from LICHTRINHBAY
where NoiDi='Ha Noi')
and SoHieuMB not in
(select SoHieuMB from LICHTRINHBAY 
where NoiDi='Thanh pho Ho Chi Minh')

--14.Liệt kê SoHieu, MaLoai, TenPC, NoiDi, NoiDen, ThoiGianDi, ThoiGianDen, TenPC của những máy bay thuộc loại 'A321'
--và chỉ mới thực hiện bay một lần duy nhất. Kết quả liệt kê sắp xếp tăng dần theo ThoiGianDi.
SELECT a.SoHieuMB, a.MaLoai, b.TenPC, c.NoiDi, c.Noiden, c.ThoiGianDi, c.ThoiGianDen 
FROM MAYBAY a
INNER JOIN LICHTRINHBAY c ON c.SoHieuMB=a.SoHieuMB
INNER JOIN PHICONG b ON b.MaPC=c.MaPC
INNER JOIN LOAIMAYBAY d ON d.MaLoai=a.MaLoai
WHERE a.SoHieuMB in
(
	SELECT a.SoHieuMB FROM MAYBAY a
	INNER JOIN LICHTRINHBAY c ON c.SoHieuMB=a.SoHieuMB
	INNER JOIN PHICONG b ON b.MaPC=c.MaPC
	INNER JOIN LOAIMAYBAY d ON d.MaLoai=a.MaLoai
WHERE d.LoaiMB='A321'
group by a.SoHieuMB
having count(c.MaLT)=1)
ORDER BY c.ThoiGianDi ASC

