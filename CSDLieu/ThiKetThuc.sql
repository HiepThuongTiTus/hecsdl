CREATE TABLE MAY
(
	MaMay VARCHAR(30) NOT NULL PRIMARY KEY,
	ViTri VARCHAR(30),
	TrangThai VARCHAR(30)
)

CREATE TABLE KHACHHANG
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	DiaChi VARCHAR(30),
	SoDienThoai CHAR(11)
)

CREATE TABLE DICHVU
(
	MaDV VARCHAR(30) NOT NULL PRIMARY KEY,
	TenDV VARCHAR(30),
	DonViTinh VARCHAR(30),
	DonGia DECIMAL(6,3)
)	

CREATE TABLE SUDUNGMAY
(
	MaKH VARCHAR(30),
	MaMay VARCHAR(30),
	NgayBatDauSuDung DATETIME,
	GioBatDauSuDung DATETIME,
	ThoiGianSuDung DATETIME

	PRIMARY KEY (MaKH, MaMay),
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaMay) REFERENCES MAY(MaMay),
)

CREATE TABLE SUDUNGDICHVU
(
	MaKH VARCHAR(30),
	MaDV VARCHAR(30),
	NgaySuDung DATETIME,
	GioSuDung DATETIME,
	SoLuong INT

	PRIMARY KEY (MaKH, MaDV),
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV)
)

INSERT INTO MAY VALUES('M01','Trai1','Chua su dung')
INSERT INTO MAY VALUES('M02','Trai2','Dang su dung')
INSERT INTO MAY VALUES('M03','Phai1','Bi hong')

INSERT INTO KHACHHANG VALUES('KH001','Nguyen Van 1','Thanh Khe', 0905778987)
INSERT INTO KHACHHANG VALUES('KH002','Nguyen Van 2','Lien Chieu', 0905778988)
INSERT INTO KHACHHANG VALUES('KH003','Nguyen Van 3','Hai Chau', 0905778989)

INSERT INTO DICHVU VALUES('DV01','Nuoc suoi','Chai', 10.000)
INSERT INTO DICHVU VALUES('DV02','Khan lanh','Cai', 5.000)
INSERT INTO DICHVU VALUES('DV03','Ca phe','Ly', 6.000)
INSERT INTO DICHVU VALUES('DV04','Dieu hoa','Gio', 10.000)

INSERT INTO SUDUNGDICHVU VALUES('KH01','DV01','15/01/2015', '17:20',2)
INSERT INTO SUDUNGDICHVU VALUES('KH01','DV02','15/01/2015', '18:00',1)

INSERT INTO SUDUNGMAY VALUES('KH01','M01','15/01/2015', '16:00',60)
INSERT INTO SUDUNGMAY VALUES('KH01','M02','15/01/2015', '20:00',120)

-- Liet ke thong tin cua toan bo khach hang
SELECT *FROM KHACHHANG

--Xoa toan bo cac may co trang thai "Bi Hong"
DELETE FROM MAY
WHERE TrangThai='Bi hong';

--Cap nhat giá tri cua truong DiaChi trong bang KHACHHANG thành 'Lien Chieu'			
--doi voi nhung bang ghi DiaChi mang giá tri là 'LC'	
UPDATE KHACHHANG SET DiaChi='LC' 
WHERE DiaChi='Lien Chieu';

--Li?t kê nh?ng d?ch v? có ??n v? tính là Chai mà ??n giá d??i 10000 và nh?ng d?ch v?			
--có ??n v? tính là Ly mà ??n giá trên 20000	
SELECT *FROM DICHVU DV
WHERE (DV.DonViTinh='Chai' AND DV.DonGia <10000) AND (DV.DonViTinh='Ly' AND DV.DonGia >20000);

--Li?t kê nh?ng khách hàng có tên k?t thúc b?ng chu?i ký t? 'NG'			
SELECT KH.TenKH FROM KHACHHANG KH
WHERE KH.TenKH LIKE 'NG%'

--Li?t kê toàn b? khách hàng, s?p x?p theo chi?u gi?m d?n c?a TenKH và t?ng d?n c?a DiaChi				
SELECT kh.TenKH, kh.Diachi FROM KHACHHANG kh
ORDER BY kh.TenKH ASC, kh.DiaChi DESC;

--??m s? l??ng khách hàng có ??a ch? là 'Thanh Khe'		
SELECT k.MaKH,k.DiaChi,COUNT(MaKH) AS SoKhachHang FROM KHACHHANG k
WHERE k.DiaChi='Thanh Khe'
GROUP BY k.MaKH,k.DiaChi;

--Li?t kê tên c?a toàn b? khách hàng (tên nào gi?ng nhau thì ch? li?t kê m?t l?n)			
SELECT DISTINCT h.TenKH FROM KHACHHANG h

--Li?t kê MaKH, TenKH, MaMay, ViTri, NgayBatDauSuDung, GioBatDauSuDung, ThoiGianSuDung				
--c?a t?t c? các l?n s? d?ng máy				
SELECT m.MaKH, m.TenKH, n.MaMay, n.ViTri, a.GioBatDauSuDung, a.ThoiGianSuDung FROM SUDUNGMAY a
INNER JOIN KHACHHANG m ON a.MaKH=m.MaKH
INNER JOIN MAY n ON a.MaMay=n.MaMay;

--Li?t kê MaKH, TenKH, MaMay, ViTri, ThoiGianSuDung c?a t?t c? các l?n s? d?ng máy				
--(n?u khách hàng ch?a s? d?ng máy l?n nào thì v?n ph?i li?t kê khách hàng ?ó ra)				
SELECT h.MaKH, h.TenKH, y.MaMay, y.ViTri, s.ThoiGianSuDung FROM SUDUNGMAY s
RIGHT JOIN KHACHHANG h ON s.MaKH=h.MaKH
LEFT JOIN MAY y ON s.MaMay=y.MaMay;

--Li?t kê MaKH, TenKH c?a nh?ng khách hàng dã tung su dung máy hoac ?ã t?ng s? d?ng d?ch v? nào ?ó				
SELECT DISTINCT kh.MaKH, kh.TenKH FROM KHACHHANG kh
INNER JOIN SUDUNGMAY m ON kh.MaKH=m.MaKH
INNER JOIN SUDUNGDICHVU n ON kh.MaKH=n.MaKH
WHERE (kh.MaKH = m.MaKH) OR (kh.MaKH=n.MaKH)

--Li?t kê MaKH, TenKH c?a nh?ng khách hàng ch?a t?ng s? d?ng b?t k? d?ch v? nào				
SELECT kh.MaKH, kh.TenKH FROM KHACHHANG kh
WHERE NOT EXISTS(
	SELECT *
	FROM SUDUNGDICHVU sddv
	WHERE kh.MaKH = sddv.MaKH
)

--Câu 14:	Liệt kê MaKH, TenKH, MaMay, ViTri, NgayBatDauSuDung, GioBatDauSuDung, ThoiGianSuDung				
	--của những khách hàng có địa chỉ ở 'Quang Nam' và chỉ mới sử dụng máy 1 lần duy nhất.				
	--Kết quả liệt kê cần được sắp xếp theo chiều giảm dần của trường ThoiGianSuDung				
SELECT  kh.MaKH, kh.TenKH,kh.DiaChi, m.MaMay, m.Vitri, t.NgayBatDauSuDung, t.GioBatDauSuDung, t.ThoiGianSuDung
FROM KHACHHANG kh
WHERE kh.DiaChi = 'Quang Nam' 
 (
	SELECT DISTINCT
	*FROM SUDUNGMAY t
	WHERE kh.MaKH = t.MaKH
	)
ORDER BY ThoiGianSuDung ASC;






