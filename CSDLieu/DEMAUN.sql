CREATE TABLE KHACHHANG
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	Email VARCHAR(30),
	SoDT VARCHAR(30),
	DiaChi VARCHAR(30)
)
 CREATE TABLE THANHTOAN
 (
	MaTT VARCHAR(30) NOT NULL PRIMARY KEY,
	PhuongThucTT VARCHAR(30)
 )
CREATE TABLE DONHANG
(
	MaDH VARCHAR(30) NOT NULL PRIMARY KEY ,
	MaKH VARCHAR(30),
	MaTT VARCHAR(30),
	NgayDat DATETIME

	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaTT) REFERENCES THANHTOAN(MaTT)

)
 CREATE TABLE DMSANPHAM
 (
	MaDM VARCHAR(30) NOT NULL PRIMARY KEY,
	TenDanhMuc VARCHAR(30),
	MoTa VARCHAR(50)
 )

 CREATE TABLE SANPHAM
 (
	MaSP VARCHAR(30) NOT NULL PRIMARY KEY,
	MaDM VARCHAR(30),
	TenSP VARCHAR(30),
	GiaTien DECIMAL(6,3),
	SoLuong INT,
	XuatXu VARCHAR(30)

	FOREIGN KEY (MaDM) REFERENCES DMSANPHAM(MaDM)

 )
CREATE TABLE CHITIETDONHANG
(
	MaDH VARCHAR(30),
	MaSP VARCHAR(30),
	SoLuong INT ,
	TongTien DECIMAL(6,3)

	PRIMARY KEY(MaDH, MaSP),
	FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH),
	FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
)


 INSERT INTO KHACHHANG VALUES('KH001', 'Tran Van An', 'antv@gmail.com', '0905123564','Lang Son')
 INSERT INTO KHACHHANG VALUES('KH002', 'Phan Phuoc', 'phuocp@gmail.com', '0932568984','Da Nang')
 INSERT INTO KHACHHANG VALUES('KH003', 'Tran Huu Anh', 'anhth@gmail.com', '0901865232','Ha Noi')

 INSERT INTO DMSANPHAM VALUES('DM01', 'Thoi Trang Nu', 'vay, ao danh cho nu')
 INSERT INTO DMSANPHAM VALUES('DM02', 'Thoi Trang Nam',' quan danh cho nam')
 INSERT INTO DMSANPHAM VALUES('DM03','Trang Suc', 'danh cho nu va nam')

 INSERT INTO SANPHAM VALUES('SP001', 'DM01','Dam Maxi', 200, '195.00', 'VN')
 INSERT INTO SANPHAM VALUES('SP002', 'DM01','Tui Da My', 50, '3.000.000', 'QK')
INSERT INTO SANPHAM VALUES('SP003', 'DM02','Lac tay Uc',300, '300.000', 'HQ')

 INSERT INTO THANHTOAN VALUES('TT01', 'Visa')
 INSERT INTO THANHTOAN VALUES('TT02', 'Master Card')
 INSERT INTO THANHTOAN VALUES('TT03','JCB')

 INSERT INTO DONHANG VALUES('DH001', 'KH002', 'TT01', '2014/10/20')
 INSERT INTO DONHANG VALUES('DH002', 'KH002', 'TT01', '2015/5/15')
 INSERT INTO DONHANG VALUES('DH003', 'KH001', 'TT03', '2015/4/20')
 
 INSERT INTO CHITIETDONHANG VALUES('DH001', 'SP002',3,'56.000')
 INSERT INTO CHITIETDONHANG VALUES('DH003', 'SP001',10,'27.444')
INSERT INTO CHITIETDONHANG VALUES('DH002', 'SP002',10,'67.144')

--cau1:
SELECT *FROM SANPHAM

--cau2:
DELETE FROM KHACHHANG
WHERE DiaChi='Lang Son'

--Cau3:
UPDATE  SANPHAM
SET XuatXu= 'VietNam' 
Where XuatXu='VN'

--Cau4:
SELECT *FROM SANPHAM, DMSANPHAM
WHERE SoLuong>50 AND TenDanhMuc='Thoi Trang Nu'
AND SoLuong>100 AND TenDanhMuc='Thoi Trang Nam'
