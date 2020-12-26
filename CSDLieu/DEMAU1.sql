
CREATE TABLE MAY
(
	MaMay VARCHAR(20) NOT NULL PRIMARY KEY,
	ViTri VARCHAR(20),
	TrangThai VARCHAR(50)
)

CREATE TABLE DICHVU
(
	MaDV VARCHAR(20) NOT NULL PRIMARY KEY,
	TenDV VARCHAR(20),
	DonViTinh VARCHAR(50),
	DonGia DECIMAL(6,3)
)

CREATE TABLE KHACHHANG
(
MaKH VARCHAR(20) NOT NULL PRIMARY KEY,
TenKH VARCHAR(20),
DiaChi VARCHAR(50),
SoDienThoai CHAR(11)
)

CREATE TABLE SUDUNGMAY
(
MaKH VARCHAR(20) NOT NULL ,
MaMay VARCHAR(20) NOT NULL,
NgayBatDauSuDung DATETIME, 
GioBatDauSuDung TIME,
ThoiGianSuDung TIME

  PRIMARY KEY (MaKH, MaMay),
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
  FOREIGN KEY (MaMay) REFERENCES MAY(MaMay)
)

CREATE TABLE SUDUNGDICHVU
(
MaKH VARCHAR(20) NOT NULL ,
MaDV VARCHAR(20) NOT NULL,
NgaySuDung DATETIME, 
GioSuDung TIME,
SoLuong INT

  PRIMARY KEY (MaKH, MaDV),
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
  FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV)
)

INSERT INTO MAY VALUES ('M01', 'Trai1', 'Chua su dung')
INSERT INTO MAY VALUES ('M02', 'Trai2', 'Dang su dung')
INSERT INTO MAY VALUES ('M03', 'Phai1', 'Bi hong')

INSERT INTO KHACHHANG VALUES ('KH001','Nguyen Van 1', 'Thanh Khe', '0905778987')
INSERT INTO KHACHHANG VALUES ('KH002','Nguyen Van 2', 'Lien Chieu', '0905778988')
INSERT INTO KHACHHANG VALUES ('KH003','Nguyen Van 3', 'Hai Chau', '0905778989')

INSERT INTO DICHVU VALUES ('DV01','Nuoc suoi', 'Chai', 10.000)
INSERT INTO DICHVU VALUES ('DV02','Khan lanh', 'Cai', 5.000)
INSERT INTO DICHVU VALUES ('DV03','Ca phe', 'Ly', 6.000)
INSERT INTO DICHVU VALUES ('DV04','Dieu hoa', 'Gio', 10.000)

INSERT INTO SUDUNGDICHVU VALUES ('KH01','DV01', '15/01/2015','17:20',2)
INSERT INTO SUDUNGDICHVU VALUES ('KH01','DV02', '15/01/2015','18:00',1)

INSERT INTO SUDUNGMAY VALUES ('KH01','M01', '15/01/2015','16:00',60)
INSERT INTO SUDUNGMAY VALUES ('KH02','M02', '15/01/2015','20:00',120)

--bai1: Liet ke thong tin cua toan bo khach hang
SELECT * FROM dbo.KHACHHANG

--BAI2: Xoa toan bo cac may co trang thai bi hong
 DELETE FROM dbo.MAY
WHERE TrangThai = 'Bi hong'

--BAI3: Cap nhat gia tri cua truong DiaChi trong bang Khach Hang thanh Lien Chieu
--doi voi nhung bang ghi co truong Diachi mang gia tri la 'LC'
UPDATE dbo.KHACHHANG 
SET DiaChi= 'Lien Chieu' 
Where DiaChi='LC'

--bai4: Liet ke nhung dich vu co don vi tinh la Chai ma don gia duoi 10000 va nhung dich vu co don vi tinh la Ly ma don gia tren 20000
SELECT *FROM dbo.DICHVU 
Where (DonViTinh='Chai'AND DonGia<10000)
OR (DonViTinh='Ly' AND DonGia>20000)

--bai5: Liet ke nhung khach hang co ten ket thuc bang chuoi ky tu 'NG'
SELECT *FROM dbo.KHACHHANG 
WHERE TenKH LIKE '%NG'

--bai 6: Liet ke toan bo khach hang , sap xep theo chieu giam dan cua TenKH va tang dan cua Diachi
SELECT *FROM dbo.KHACHHANG
ORDER BY TenKH DESC, Diachi ASC

--bai 7: Dem so luong khach hang co dia chi la 'ThanhKhe'
SELECT COUNT(*) FROM dbo.KHACHHANG
WHERE DiaChi='Thanh Khe'

--bai 8: Liet ke ten toan bo khach hang, ten nao giong chi liet ke mot lan
SELECT DISTINCT TenKH FROM dbo.KHACHHANG

--bai 9: Liet ke MaKH, TenKH, MaMay, ViTri, NgayBatDauSuDung, GioBatDauSuDung, ThoiGianSuDung
SELECT MaKH , TenKH, MaMay, ViTri,NgayBatDauSuDung, GioBatDauSuDung, ThoiGianSuDung
FROM dbo.MAY JOIN dbo.KHACHHANG
ON MaMay = MaKH

--bai 10: Liet ke MaKH, TenKH, MaMay, ViTri, Thoigiansudung cua tat ca cac lan su dung may
SELECT *FROM dbo.KHACHHANG, dbo.MAY, dbo.SUDUNGMAY 
GROUP BY dbo.SUDUNGMAY
HAVING COUNT (dbo.SUDUNGMAY)>1

--bai 11: Liet ke MaKH, tenKH cua nhung khach hang da tung su dung may hoac da tung su dung dich vu
SELECT MaKH, TenKH FROM dbo.KHACHHANG, dbo.SUDUNGMAY, dbo.SUDUNGDICHVU
WHERE EXISTS( 
	SELECT *
	FROM dbo.KHACHHANG
	WHERE dbo.KHACHHANG.MaKH = dbo.SUDUNGDICHVU.MaKH OR dbo.KHACHHANG .MaKH= dbo.SUDUNGMAY.MaKH 
	)
--bai 12:  Liet ke MaKH, tenKH cua nhung khach hang chua  tung su dung dich vu
SELECT  MaKH, TenKH FROM dbo.KHACHHANG
WHERE NOT EXISTS( 
	SELECT *
	FROM dbo.KHACHHANG
	WHERE dbo.KHACHHANG.MaKH = dbo.SUDUNGDICHVU.MaKH
	)
--bai 13: Liet ke MaKH, tenKH cua nhung khach hang da tung su dung may va da tung su dung dich vu
SELECT MaKH, TenKH FROM dbo.KHACHHANG, dbo.SUDUNGMAY, dbo.SUDUNGDICHVU
WHERE EXISTS( 
	SELECT *
	FROM dbo.KHACHHANG
	WHERE dbo.KHACHHANG.MaKH = dbo.SUDUNGDICHVU.MaKH AND dbo.KHACHHANG .MaKH= dbo.SUDUNGMAY.MaKH 
	)
--bai14: 
SELECT DISTINCT MaKH , TenKH, MaMay, ViTri,NgayBatDauSuDung, GioBatDauSuDung, ThoiGianSuDung
FROM dbo.KHACHHANG , dbo.MAY, dbo.SUDUNGMAY 
WHERE DiaChi='Quang Nam'
ORDER BY ThoiGianSuDung DESC