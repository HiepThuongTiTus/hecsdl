--cau1: so do csdl
CREATE TABLE KHACHHANG
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	DiaChi VARCHAR(30),
	SoDT CHAR(11),
	MaSoThue VARCHAR(30)
)
CREATE TABLE MUCTIENGIO
(
	MaTienGio VARCHAR(30) NOT NULL PRIMARY KEY,
	DonGia DECIMAL(6,3),
	MoTa VARCHAR(50)
)
CREATE TABLE PHONG 
(
	MaPhong VARCHAR(30) NOT NULL PRIMARY KEY,
	SoKhachToiDa INT,
	TrangThai VARCHAR(30),
	MoTa VARCHAR(30)
)
CREATE TABLE DICHVU
(
	MaDV VARCHAR(30) NOT NULL PRIMARY KEY,
	TenDV VARCHAR(30),
	DonViTinh VARCHAR(30),
	DonGia DECIMAL(6,3)
)
CREATE TABLE HOADON
(
	MaHD VARCHAR(30) NOT NULL PRIMARY KEY,
	MaKH VARCHAR(30),
	MaPhong VARCHAR(30),
	MaTienGio VARCHAR(30),
	ThoiGianBatDauSD SMALLDATETIME,
	ThoiGianKetThucSD SMALLDATETIME,
	TrangThai VARCHAR(50)
	
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong),
	FOREIGN KEY (MaTienGio) REFERENCES MUCTIENGIO(MaTienGio)
)
CREATE TABLE CHITIET_SUDUNGDV
(
	MaHD VARCHAR(30) NOT NULL,
	MaDV VARCHAR(30) NOT NULL,
	SoLuong INT
	
	PRIMARY KEY (MaHD, MaDV),
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV)
)
--cau2: chen dl

--chen khach hang
INSERT INTO KHACHHANG VALUES('KH001', 'Tran Van Nam', 'Hai Chau','0905123456', '12345678')
INSERT INTO KHACHHANG VALUES('KH002', 'Nguyen Mai Anh', 'Lien Chieu','0905123457', '12345679')
INSERT INTO KHACHHANG VALUES('KH003', 'Nguyen Hoai Lan Khue', 'Hoa Vang','0905123458', '12345680')
INSERT INTO KHACHHANG VALUES('KH004', 'Nguyen Hoai Nguyen', 'Hoa Cam','0905123459', '12345681')
INSERT INTO KHACHHANG VALUES('KH005', 'Le Truong Ngoc Anh', 'Hai Chau','0905123460', '12345682')
INSERT INTO KHACHHANG VALUES('KH006', 'Ho Hoai Anh', 'Hai Chau','0905123461', '12345683')
INSERT INTO KHACHHANG VALUES('KH007', 'Pham Thi Huong', 'Son Tra','0905123462', '12345684')
INSERT INTO KHACHHANG VALUES('KH008', 'Chau Trinh Tri', 'Hai Chau','0905123463', '12345685')
INSERT INTO KHACHHANG VALUES('KH009', 'Phan Nhu Thao', 'Hoa Khanh','0905123464', '12345686')
INSERT INTO KHACHHANG VALUES('KH010', 'Tran Thi To Tam', 'Son Tra','0905123465', '12345687')
--chen phong
INSERT INTO PHONG VALUES('VIP01', 5, 'Duoc su dung','phong vip')
INSERT INTO PHONG VALUES('PO2', 10, 'Duoc su dung','phong binh thuong')
INSERT INTO PHONG VALUES('PO3', 15, 'Duoc su dung','phong binh thuong')
INSERT INTO PHONG VALUES('VIP04', 20, 'Duoc su dung','phong vip')
INSERT INTO PHONG VALUES('P05', 25, 'Duoc su dung','phong binh thuong')
INSERT INTO PHONG VALUES('P06', 30, 'Duoc su dung','phong binh thuong')
INSERT INTO PHONG VALUES('VIP07', 35, 'Duoc su dung','phong vip')
INSERT INTO PHONG VALUES('P08', 40, 'Duoc su dung','phong binh thuong')
INSERT INTO PHONG VALUES('VIP09', 45, 'Duoc su dung','phong vip')
INSERT INTO PHONG VALUES('P10', 50, 'Duoc su dung','phong binh thuong')
--chen dich vu
INSERT INTO DICHVU VALUES('DV01', 'Hat Dua', 'Bao','5.000')
INSERT INTO DICHVU VALUES('DV02', 'Trai Cay', 'Dia','30.000')
INSERT INTO DICHVU VALUES('DV03', 'Bia', 'Lon','35.000')
INSERT INTO DICHVU VALUES('DV04', 'Nuoc Ngot', 'Chai','10.000')
INSERT INTO DICHVU VALUES('DV05', 'Ruou', 'Chai','200.000')
--chen muc tien gio
INSERT INTO MUCTIENGIO VALUES('MT01','60.000', 'Ap dung tu 6 gio den 17 gio')
INSERT INTO MUCTIENGIO VALUES('MT02','80.000', 'Ap dung sau 17 gio den 22 gio')
INSERT INTO MUCTIENGIO VALUES('MT03','100.000', 'Ap dung tu sau 22 gio den 6 gio')
--chen hoa don
INSERT INTO HOADON VALUES('HD001','KH001','VIP01', 'MT01', '11/20/2015 8:15','11/20/2015 12:30','Da thanh toan')
INSERT INTO HOADON VALUES('HD002','KH002','P02', 'MT01', '12/20/2015 13:10','12/12/2015 17:20','Chua thanh toan')
INSERT INTO HOADON VALUES('HD003','KH001','P02', 'MT01', '10/15/2014 12:12','10/15/2014 16:30','Da thanh toan')
INSERT INTO HOADON VALUES('HD004','KH003','VIP01', 'MT02', '9/20/2015 18:30','9/20/2015 21:00','Chua thanh toan')
INSERT INTO HOADON VALUES('HD005','KH001','P03', 'MT02', '11/25/2014 20:00','11/25/2014 21:45','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD006','KH002','VIP01', 'MT01', '9/12/2014 9:20','9/12/2014 10:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD007','KH006','VIP04', 'MT01', '12/22/2014 11:00','12/22/2014 14:20','Da thanh toan')
INSERT INTO HOADON VALUES('HD008','KH007','VIP04', 'MT002', '8/23/2014 20:10','8/23/2014 22:00','Chua thanh toan')
INSERT INTO HOADON VALUES('HD009','KH006','P05', 'MT03', '12/20/2015 22:30','12/21/2015 1:15','Chua thanh toan')
INSERT INTO HOADON VALUES('HD010','KH005','VIP01', 'MT03', '10/10/2015 1:30','10/10/2015 3:15','Da thanh toan')
INSERT INTO HOADON VALUES('HD011','KH004','VIP07', 'MT03', '12/25/2015 22:15','12/25/2015 2:00','Da thanh toan')
INSERT INTO HOADON VALUES('HD012','KH008','P06', 'MT03', '7/25/2014 23:45','7/26/2015 2:15','Da thanh toan')
INSERT INTO HOADON VALUES('HD013','KH007','VIP07', 'MT02', '8/21/2015 18:15','8/21/2015 20:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD014','KH004','P06', 'MT02', '12/31/2015 19:12','12/31/2015 21:15','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD015','KH001','P06', 'MT01', '6/24/2014 13:00','6/24/2014 13:15','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD016','KH003','P08', 'MT01', '5/12/2014 8:00','5/12/2014 10:45','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD017','KH003','VIP09', 'MT01', '11/12/2015 12:15','10/15/2014 14:20','Da thanh toan')
INSERT INTO HOADON VALUES('HD018','KH001','P10', 'MT01', '4/12/2015 14:45','4/12/2015 16:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD019','KH002','VIP09', 'MT03', '11/12/2015 22:12','11/13/2015 2:00','Da thanh toan')
INSERT INTO HOADON VALUES('HD020','KH004','VIP09', 'MT03', '2/25/2014 1:15','2/25/2014 4:15','Chua thanh toan')
--chi tiet su dung dv
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD001', 'DV01',5)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD002', 'DV01',8)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD002', 'DV02',5)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD002', 'DV03',2)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD003', 'DV04',1)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD003', 'DV05',6)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD004', 'DV01',5)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD005', 'DV02',3)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD005', 'DV03',10)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD005', 'DV04',2)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD006', 'DV01',5)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD007', 'DV03',8)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD007', 'DV04',10)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD007', 'DV05',4)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD013', 'DV02',9)
INSERT INTO CHITIET_SUDUNGDV VALUES ('HD011', 'DV02',8)

--cau 3: Liet ke phong chua sl toi da duoi 20 khach

SELECT a.MaPhong, a.SokhachToiDa FROM PHONG a
WHERE a.SoKhachToiDa<20

--Dua ra cac phong co nhieu hon 2 khach co dia chi HaiChau
SELECT p.MaPhong, COUNT(kh.MaKH) AS SoNV FROM KHACHHANG kh 
INNER JOIN PHONG p ON kh.MaKH=p.MaPhong
WHERE kh.DiaChi='Hai Chau'
GROUP BY p.MaPhong HAVING COUNT(kh.MaKH) > 2

--cau4:Liệt kê thông tin của các dịch vụ có đơn vị tính là "Chai" với đơn giá nhỏ hơn 20.000
--VNĐ và các dịch vụ có đơn vị tính là "Lon" với đơn giá lớn hơn 30.000 VNĐ 
SELECT a.MaDV, a.TenDV, a.DonViTinh, a.DonGia FROM DICHVU a
WHERE (a.DonViTinh LIKE 'Chai' AND a.DonGia <'20.000') OR (a.DonViTinh LIKE 'Lon' AND a.DonGia>'30.000')

--cau5:Liệt kê thông tin của các phòng karaoke có mã phòng bắt đầu bằng cụm từ "VIP" 
SELECT a.MaPhong FROM PHONG a
WHERE a.MaPhong LIKE 'VIP%'

--Cau6: Liệt kê thông tin của toàn bộ các dịch vụ, yêu cầu sắp xếp giảm dần theo đơn giá
SELECT *FROM DICHVU 
ORDER BY DonGia DESC 

--ASC: Tang dan
--DESC: Giam dan

--Câu 7: Đếm số hóa đơn có trạng thái là "Chưa thanh toán" và có thời gian bắt đầu sử
--dụng nằm trong ngày hiện tại (sai)
SELECT COUNT(MaHD) AS SoHD FROM HOADON 
JOIN CHITIET_SUDUNGDV ON HOADON.MaHD= CHITIET_SUDUNGDV.MaHD 
WHERE TrangThai='Chua thanh toan' AND
	UPDATE HOADON SET ThoiGianSuDungDV 
)
GROUP BY MaHD
--Cau 8: Liệt kê địa chỉ của toàn bộ các khách hàng với yêu cầu mỗi địa chỉ được liệt kê một
--lần duy nhất
SELECT DISTINCT kh.DiaChi FROM KHACHHANG kh

SELECT kh.DiaChi 
FROM KHACHHANG kh
GROUP BY kh.DiaChi

--Cau 9: Liệt kê MaHD, MaKH,TenKH, DiaChi, MaPhong, DonGia (Tiền giờ),
--ThoiGianBatDauSD, ThoiGianKetThucSD của tất cả các hóa đơn có trạng thái là "Đã thanh toán" 
SELECT HD.MaHD, KH.MaKH, KH.TenKH,KH.DiaChi,p.MaPhong, h.DonGia,HD.ThoiGianBatDauSD, HD.ThoiGianKetThucSD
FROM HOADON HD
INNER JOIN KHACHHANG KH ON KH.MaKH=HD.MaKH
INNER JOIN PHONG p ON p.MaPhong= HD.MaPhong
INNER JOIN MUCTIENGIO h ON h.MaTienGio=HD.MaTienGio
WHERE HD.TrangThai='Da thanh toan'

--Cau 10: Liệt kê MaKH, TenKH, DiaChi, MaHD, TrangThaiHD của tất cả các hóa đơn với
--yêu cầu những khách hàng chưa từng có một hóa đơn nào thì cũng liệt kê thông tin những khách hàng đó ra 
SELECT KH.MaKH, KH.TenKH, KH.DiaChi, HD.MaHD, HD.TrangThai
FROM HOADON HD
RIGHT JOIN KHACHHANG KH ON KH.MaKH=HD.MaKH

--Câu 11: Liệt kê thông tin của các khách hàng đã từng sử dụng dịch vụ "Trái cây" hoặc từng
--sử dụng phòng karaoke có mã phòng là "VIP07" 
SELECT KH.MaKH FROM KHACHHANG KH
WHERE EXISTS(
	SELECT * FROM DICHVU, PHONG
	WHERE (TenDV='Trai cay' OR MaPhong='VIP07')
)

--Câu 12: Liệt kê thông tin của các khách hàng chưa từng sử dụng dịch vụ hát karaoke lần nào cả 
SELECT *FROM KHACHHANG kh
WHERE NOT EXISTS(
	SELECT *FROM HOADON hd
	WHERE (kh.MaKH = hd.MaKH)
)

--Câu 13: Liệt kê thông tin của các khách hàng đã từng sử dụng dịch vụ hát karaoke và chưa
--từng sử dụng dịch vụ nào khác kèm theo 
SELECT *FROM KHACHHANG KH 
WHERE EXISTS (
SELECT *FROM HOADON hd
WHERE hd.MaKH = KH.MaKH
)
AND NOT EXISTS(
	SELECT *FROM HOADON HD
	WHERE HD.MaKH = KH.MaKH
)

--Câu 14: Liệt kê thông tin của những khách hàng đã từng hát karaoke vào năm "2014" nhưng
--chưa từng hát karaoke vào năm "2015" 
SELECT *FROM KHACHHANG KH
WHERE EXISTS (
SELECT *FROM HOADON HD
WHERE (HD.MaKH = KH.MaKH AND ThoiGianBatDauSD BETWEEN '01/01/2014' AND '1/30/2014')
) AND NOT EXISTS (
SELECT *FROM HOADON HD
WHERE (HD.MaKH = KH.MaKH AND ThoiGianBatDauSD BETWEEN '01/01/2015' AND '1/30/2015')
)

--Câu 15: Hiển thị thông tin của những khách hàng có số lần hát karaoke nhiều nhất tính từ
--đầu năm 2014 đến hết năm 2014 
SELECT *FROM KHACHHANG KH
INNER JOIN HOADON HD ON HD.MaKH= KH.MaKH
INNER JOIN CHITIET_SUDUNGDV DV ON DV.MaHD=HD.MaHD
AND DV.SoLuong =
(
	SELECT MAX(DV.SoLuong) FROM CHITIET_SUDUNGDV DV
	WHERE (HD.ThoiGianKetThucSD BETWEEN '01/01/2014' AND '1/30/2014')
)

--Câu 16: Đếm tổng số lượng loại dịch vụ đã được sử dụng trong năm 2014 với yêu cầu chỉ
--thực hiện tính đối với những loại dịch vụ có đơn giá từ 50.000 VNĐ trở lên 
SELECT COUNT(*) FROM DICHVU dv
WHERE EXISTS (
	SELECT *FROM HOADON hd
	WHERE(hd.ThoiGianBatDauSD BETWEEN '01/01/2014' AND '1/30/2014') AND (dv.DonGia>50.000)
)
--Câu 17: Liệt kê MaKH, TenKH, MaSoThue của khách hàng có địa chỉ là "Hải Châu" và
--chỉ mới hát karaoke một lần duy nhất, kết quả được sắp xếp giảm dần theo TenKH 
SELECT KH.MaKH, KH.TenKH, KH.MaSoThue FROM KHACHHANG KH
WHERE( KH.DiaChi='Hai Chau')  
AND EXISTS(
SELECT  SD.SoLuong FROM CHITIET_SUDUNGDV SD
WHERE SD.SoLuong=1
)
ORDER BY KH.TenKH DESC

--Câu 18: Cập nhật cột TrangThaiHD trong bảng HOADON thành giá trị "Đã hết hạn" đối với
--những khách hàng có địa chỉ là "Hải Châu" và có ThoiGianKetThucSD trước ngày 31/12/2015 
UPDATE HOADON  SET TrangThai='Da het han'
(
SELECT *FROM KHACHHANG KH , HOADON HD
WHERE (KH.MaKH = HD.MaKH AND KH.DiaChi='Hai Chau' AND HD.ThoiGianKetThucSD <'31/12/2015')
)

--Câu 19: Cập nhật cột MoTa trong bảng PHONG thành giá trị "Được sử dụng nhiều" cho
--những phòng được sử dụng từ 5 lần trở lên trong tháng 5 năm 2015 
UPDATE PHONG SET MoTa='Duoc su dung nhieu'
(
SELECT *FROM CHITIET_SUDUNGDV SD, HOADON HD
WHERE (SD.SoLuong>4 AND HD.ThoiGianBatDauSD='5/2015')
)

--Câu 20: Xóa những hóa đơn có ThoiGianBatDauSD trước ngày 20/11/2015
DELETE FROM HOADON 
WHERE ThoiGianBatDauSD < ('20/11/2015')