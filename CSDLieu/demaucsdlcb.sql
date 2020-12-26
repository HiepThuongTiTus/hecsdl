CREATE TABLE NHACUNGCAP
(
	MaNhaCC VARCHAR(50) NOT NULL PRIMARY KEY, 
	TenNhaCC VARCHAR(20),
	DiaChi VARCHAR(30),
	SoDT VARCHAR(50),
	MaSoThue INT
)

CREATE TABLE LOAIDICHVU
(
	MaLoaiDV VARCHAR(50) NOT NULL PRIMARY KEY,
	TenLoaiDV VARCHAR(20)
)

CREATE TABLE DONGXE
(
	DongXe VARCHAR(50) NOT NULL PRIMARY KEY,
	HangXe VARCHAR(20),
	SoChoNgoi INT
)

CREATE TABLE MUCPHI
(
	MaMP VARCHAR(50) NOT NULL PRIMARY KEY,
	DonGia DECIMAL(6,3),
	MoTa VARCHAR(30)
)

CREATE TABLE DANGKYCUNGCAP
(
	MaDKCC VARCHAR(50) NOT NULL PRIMARY KEY,
	MaNhaCC VARCHAR(50),
	MaLoaiDV VARCHAR(50),
	DongXe VARCHAR(50),
	MaMP VARCHAR(50),
	NgayBatDauCungCap DATETIME,
	NgayKetThucCungCap DATETIME, 
	SoLuongXeDangKy INT


	FOREIGN KEY (MaNhaCC) REFERENCES NHACUNGCAP(MaNhaCC),
	FOREIGN KEY (MaLoaiDV) REFERENCES LOAIDICHVU(MaLoaiDV),
	FOREIGN KEY (DongXe) REFERENCES DONGXE(DongXe),
	FOREIGN KEY (MaMP) REFERENCES MUCPHI(MaMP)
)

--CAU 2
INSERT INTO NHACUNGCAP VALUES ('NCC001','Cty TNHH Toan Phap', 'Hai Chau', '05113999888',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC002','Cty Co Phan Dong Du', 'Lien Chieu', '05113999888',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC003','Ong Nguyen Van A', 'Hoa Thuan', '05113999890',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC004','Cty Co phan Cau Xanh', 'Hai Chau', '05113658945',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC005','Cty TNHH AMA', 'Thanh Khe', '05113875466',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC006','Ba Tran Thi Bich Van', 'Lien Chieu', '05113587469',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC007','Cty TNHH Phan Thanh', 'Thanh Khe', '05113987456',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC008','Ong Phan Dinh Nam', 'Hoa Thuan', '05113532456',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC009','Tap Doan Dong Nam A', 'Lien Chieu', '05113987121',568941)
INSERT INTO NHACUNGCAP VALUES ('NCC0010','Cty Co Phan Rang Dong', 'Lien Chieu', '05113569654',568941)

INSERT INTO LOAIDICHVU VALUES('DV01', 'Dich vu xe taxi')
INSERT INTO LOAIDICHVU VALUES('DV02', 'Dich vu xe buyt cong cong theo tuyen co dinh')
INSERT INTO LOAIDICHVU VALUES('DV03', 'Dich vu xe cho thue theo hop dong')

INSERT INTO MUCPHI VALUES('MP01', 10.000, 'Ap dung tu 1/2015')
INSERT INTO MUCPHI VALUES('MP02', 15.000, 'Ap dung tu 2/2015')
INSERT INTO MUCPHI VALUES('MP03', 20.000, 'Ap dung tu 1/2010')
INSERT INTO MUCPHI VALUES('MP04', 25.000, 'Ap dung tu 2/2011')

INSERT INTO DONGXE VALUES('Hiace','Toyota',16)
INSERT INTO DONGXE VALUES('Vios','Toyota',5)
INSERT INTO DONGXE VALUES('Escape','Ford',5)
INSERT INTO DONGXE VALUES('Cerato','KIA',7)
INSERT INTO DONGXE VALUES('Forte','KIA',5)
INSERT INTO DONGXE VALUES('Starex','Huyndai',7)
INSERT INTO DONGXE VALUES('Grand-i10','Huyndai',7)

INSERT INTO DANGKYCUNGCAP VALUES('DK001','NCC001','DV01','Hiace','MP01','20/11/2015','20/11/2016',4)
INSERT INTO DANGKYCUNGCAP VALUES('DK002','NCC002','DV02','Vios','MP02','20/11/2015','20/11/2017',3)
INSERT INTO DANGKYCUNGCAP VALUES('DK003','NCC003','DV03','Escape','MP03','20/11/2017','20/11/2018',5)
INSERT INTO DANGKYCUNGCAP VALUES('DK004','NCC005','DV01','Cerato','MP04','20/11/2015','20/11/2019',7)
INSERT INTO DANGKYCUNGCAP VALUES('DK005','NCC002','DV02','Forto','MP03','20/11/2019','20/11/2020',1)
INSERT INTO DANGKYCUNGCAP VALUES('DK006','NCC004','DV03','Starex','MP04','10/11/2016','20/11/2021',2)
INSERT INTO DANGKYCUNGCAP VALUES('DK007','NCC005','DV01','Cerato','MP03','30/11/2015','25/01/2016',8)
INSERT INTO DANGKYCUNGCAP VALUES('DK008','NCC006','DV01','Vios','MP02','28/02/2016','30/04/2017',9)
INSERT INTO DANGKYCUNGCAP VALUES('DK009','NCC005','DV03','Grand-i10','MP02','27/04/2016','22/02/2016',10)
INSERT INTO DANGKYCUNGCAP VALUES('DK0010','NCC006','DV01','Forte','MP02','21/11/2015','20/02/2017',4)

--CAU 3
SELECT DX.DongXe FROM DONGXE DX
WHERE DX.SoChoNgoi >5

--cau4:
SELECT NCC.MaNhaCC, NCC.TenNhaCC FROM NHACUNGCAP NCC 
JOIN DANGKYCUNGCAP DK
on NCC.MaNhaCC= DK.MaNhaCC
JOIN MUCPHI MP
ON MP.MaMP= DK.MaMP
JOIN DONGXE DX
ON DX.DongXe = DK.DongXe
WHERE
(DX.HangXe='Toyota' AND MP.DonGia=15000) OR(DX.HangXe='KIA' AND MP.DonGia=20000)

--Cau5:
SELECT *FROM DONGXE
WHERE HangXe LIKE 'T%' and LEN(HangXe)=5

--cau6: 
SELECT *FROM dbo.NHACUNGCAP
ORDER BY TenNhaCC ASC, Masothue DESC

--cau7:
SELECT n.MaNhaCC, dk.NgayBatDauCungCap, COUNT(dk.NgayBatDauCungCap) AS Solandangki FROM NHACUNGCAP n JOIN DANGKYCUNGCAP 
dk ON dk.MaNhaCC= n.MaNhaCC WHERE dk.NgayBatDauCungCap='20/11/2015'
GROUP BY n.MaNhaCC, dk.NgayBatDauCungCap


--cau8:
SELECT DISTINCT HangXe FROM dbo.DONGXE

--cau9: 
SELECT MaDKCC, TenLoaiDV, TenNhaCC, DonGia, HangXe, NgayBatDauCungCap,
NgayKetThucCungCap, SoLuongXeDangKy FROM dbo.DANGKYCUNGCAP, dbo.LOAIDICHVU, dbo.NHACUNGCAP,dbo.MUCPHI, dbo.DONGXE
WHERE EXISTS( 
	SELECT *
	FROM dbo.DANGKYCUNGCAP
)

--Cau10: 
SELECT  NCC.MaNhaCC,MaDKCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCungCap, NgayKetThucCungCap
FROM NHACUNGCAP NCC JOIN DANGKYCUNGCAP DK
ON NCC.MaNhaCC=DK.MaNhaCC
JOIN MUCPHI MP
ON MP.MaMP = DK.MaMP
JOIN LOAIDICHVU DV
ON DV.MaLoaiDV = DK.MaLoaiDV

--cau11: 
SELECT DISTINCT  HangXe FROM DONGXE WHERE HangXe='Hiace'
UNION 
SELECT DISTINCT HangXe FROM DONGXE WHERE HangXe='Cerato'
--cach2
--SELECT NCC.MaNhaCC, NCC.TenNhaCC
--FROM NHACUNGCAP NCC
--WHERE NCC.MaNhaCC IN(
--SELECT DK.MaNhaCC
--FROM DANGKYCUNGCAP DK
--WHERE DK.DongXe='Hiace' OR DK.DongXe='Cerato';

--cau12:
SELECT MaNhaCC, TenNhaCC,DiaChi, SoDT, MaSoThue
FROM NHACUNGCAP WHERE MaNhaCC NOT IN(SELECT MaNhaCC FROM DANGKYCUNGCAP)
--c2
--SELECT NCC.MaNhaCC, NCC.TenNhaCC
--FROM NHACUNGCAP NCC
--WHERE NOT EXISTS(
--SELECT *
--FROM DANGKYCUNGCAP DK
--WHERE NCC.MaNhaCC =DK.MaNhaCC


--Cau13:
SELECT DISTINCT HangXe FROM DONGXE WHERE HangXe='Hiace'
EXCEPT
SELECT DISTINCT HangXe FROM DONGXE WHERE HangXe='Cerato'

--Cau14:Liệt kê thông tin của những dòng xe chưa được nhà cung cấp nào đăng ký cho thuê vào năm "2015"					
--nhưng đã từng được đăng ký cho thuê vào năm "2016" (0.5 điểm)					
SELECT NgayBatDauCungCap, NgayKetThucCungCap
FROM DANGKYCUNGCAP, DONGXE
EXCEPT SELECT DISTINCT MaNhaCC FROM DANGKYCUNGCAP WHERE NgayBatDauCungCap='2015'
UNION SELECT DISTINCT MaNhaCC FROM DANGKYCUNGCAP WHERE NgayBatDauCungCap='2016'

--Cau15:Hiển thị thông tin của những dòng xe có số lần được đăng ký cho thuê nhiều nhất tính từ đầu năm 2016 đến hết năm 2019 (0.5 điểm)	
SELECT DongXe FROM DANGKYCUNGCAP
WHERE YEAR(NgayBatDauCungCap)='2016'AND YEAR(NgayKetThucCungCap)='2019'  

--Cau 16: Tính tổng số lượng xe đã được đăng ký cho thuê tương ứng với từng dòng xe với yêu cầu chỉ thực hiện tính đối với những						
--lần đăng ký cho thuê có mức phí với đơn giá là 20.000 VNĐ trên 1 km (0.5 điểm)		

SELECT s.SoLuongXeDangKy, d.DongXe, m.MaMP, m.DonGia  
FROM DANGKYCUNGCAP  s
INNER JOIN DONGXE d ON d.DongXe=s.DongXe
INNER JOIN MUCPHI m ON m.MaMP=s.MaMP
WHERE m.DonGia=20.000


--cau 17:Liệt kê MaNCC, SoLuongXeDangKy với yêu cầu chỉ liệt kê những nhà cung cấp có địa chỉ là "Hai Chau" và 						
--chỉ mới thực hiện đăng ký cho thuê một lần duy nhất, kết quả được sắp xếp tăng dần theo số lượng xe đăng ký (0.5 điểm)
SELECT m.MaNhaCC, m.DiaChi, dkcc.SoLuongXeDangKy
FROM NHACUNGCAP m
INNER JOIN DANGKYCUNGCAP dkcc ON dkcc.MaNhaCC=m.MaNhaCC
WHERE m.DiaChi='Hai Chau'
(
	SELECT DISTINCT * 
	FROM DANGKYCUNGCAP dkcc
)
ORDER BY dkcc.SoLuongXeDangKy  DESC

--cau18:Cập nhật cột SoLuongXeDangKy trong bảng DANGKYCUNGCAP thành giá trị 20 đối với những dòng xe thuộc hãng "Toyota"						
--và có NgayKetThucCungCap trước ngày 30/12/2016 (0.5 điểm)						

UPDATE DANGKYCUNGCAP SET SoLuongXeDangKy=20 
WHERE 
(
SELECT d.HangXe FROM DONGXE d
WHERE d.HangXe='Toyota' AND NgayKetThucCungCap<'30/12/2016')
)

--cau 19:Cập nhật cột MoTa trong bảng MUCPHI thành giá trị "Được sử dụng nhiều" cho những mức phí được sử dụng để đăng ký cung cấp cho thuê							
--phương tiện từ 5 lần trở lên trong năm 2016 (0.5 điểm)							
UPDATE MUCPHI SET MoTa='Được sử dụng nhiều'
WHERE (
	SELECT dkcc.MaDKCC FROM DANGKYCUNGCAP dkcc
	WHERE dkcc.MaDKCC >= 5 AND dkcc.NgayBatDauCungCap='2016'
)


--cau 20:XÓA những lần đăng ký cung cấp cjo thuê phương tiên co sngayf băt sđầu cung cấp
--sau ngay 10/11/2015 va dk cho thue dong xe "vios"
 DELETE m.MaDKCC, m.NgayBatDauCungCap, n.DONGXE FROM DANGKYCUNGCAP  m
 INNER JOIN DONGXE n ON m.DongXe = n.DongXe
 WHERE (m.NgayBatDauCungCap='10/11/2015') AND (n.DongXe='vios');

