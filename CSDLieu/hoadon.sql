create database BTTT2
go
use BTTT2
go
CREATE TABLE KHACHHANG
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	Email VARCHAR(30),
	SoDT CHAR(11),
	DiaChi VARCHAR(30)
)
CREATE TABLE DMSANPHAM
(
	MaDM VARCHAR(30) NOT NULL PRIMARY KEY,
	TenDanhMuc VARCHAR(30),
	MoTa VARCHAR(30)
)
CREATE TABLE THANHTOAN
(
	MaTT VARCHAR(30) NOT NULL PRIMARY KEY,
	PhuongThucTT  VARCHAR(30)
)
CREATE TABLE SANPHAM
(
	MaSP VARCHAR(30) NOT NULL PRIMARY KEY,
	MaDM VARCHAR(30) NOT NULL,
	TenSP VARCHAR(30),
	GiaTien DECIMAL(6,3),
	SoLuong INT,
	XuatXu VARCHAR(30)
	FOREIGN KEY (MaDM) REFERENCES DMSANPHAM(MaDM)
)
CREATE TABLE DONHANG
(
	MaDH VARCHAR(30) NOT NULL PRIMARY KEY,
	MaKH VARCHAR(30),
	MaTT VARCHAR(30),
	NgayDat DATETIME
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaTT) REFERENCES THANHTOAN(MaTT)
)
CREATE TABLE CHITIETDONHANG
(
	MaDH VARCHAR(30) NOT NULL,
	MaSP VARCHAR(30) NOT NULL,
	SoLuong INT,
	TongTien INT
	PRIMARY KEY (MaDH, MaSP),
	FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH),
	FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
)
INSERT INTO KHACHHANG VALUES  
(N'KH001',N'Tran Van An',N'antv@gmail.com','0905123564',N'Lang Son'), 
(N'KH002',N'Phan Phuoc',N'phuocp@gmail.com','0932568984',N'Da Nang'),
(N'KH003',N'Tran Huu Anh',N'anhth@gmail.com','0901865232',N'Ha Noi')
INSERT INTO DMSANPHAM VALUES  
(N'DM01',N'Thoi Trang Nu',N'vay, ao danh cho nu'), 
(N'DM02',N'Thoi Trang Nam',N'quan danh cho nam'),
(N'DM03',N'Trang suc',N'danh cho nu va nam')
INSERT INTO SANPHAM VALUES  
(N'SP001',N'DM01',N'Dam Maxi',200,195000,'VN'), 
(N'SP002',N'DM01',N'Tui Da Mỹ',50,3000000,'HK'),
(N'SP003',N'DM02',N'Lac tay Uc',300,300000,'HQ')
INSERT INTO THANHTOAN VALUES  
(N'TT01',N'Visa'), 
(N'TT02',N'Master Card'),
(N'TT03',N'JCB')
INSERT INTO DONHANG VALUES  
(N'DH001',N'KH002',N'TT01','2014-10-20'), 
(N'DH002',N'KH002',N'TT01','2015-5-15'),
(N'DH003',N'KH001',N'TT03','2015-4-20')
INSERT INTO CHITIETDONHANG VALUES  
(N'DH001',N'SP002',3,56000), 
(N'DH003',N'SP001',10,27444),
(N'DH002',N'SP002',10,67144)
--1 :Liet ke thong tin toan bo san pham
SELECT *FROM SANPHAM

--2:Xoa toan bo khach hang co dia chi 'Lang Son'
DELETE FROM KHACHHANG
WHERE DiaChi = 'LangSon';

--3:Cap nhat gia tri cua truong XuatXu trong bang SanPham thanh 'Viet Nam' 
--doi voi truong XuatXu co gia tri 'VN'
UPDATE SANPHAM SET XuatXu='VN' WHERE XuatXu='Viet Nam'

--4:Liet ke thong tin nhung san pham co Soluong lon hon 50 thuoc danh muc la 'thoi trang nu'
--va nhung san pham co SoLuong lon hon 100 thuoc danh muc la 'Thoi trang nam'
SELECT t.MaSP, t.SoLuong, m.TenDanhMuc FROM SANPHAM t
INNER JOIN DMSANPHAM m ON m.MaDM=t.MaDM
WHERE (t.SoLuong > 50 AND m.TenDanhMuc='thoi trang nu') or (t.SoLuong > 100 AND m.TenDanhMuc='thoi trang nam');

--5Liệt kê những khách hàng có tên bắt đầu là ký tự 'A' và có độ dài là 5 ký tự.
SELECT kh.MaKH FROM KHACHHANG kh
WHERE kh.TenKH LIKE 'A____' ;

--6Liệt kê toàn bộ sản phẩm, sắp xếp giảm dần theo TenSP và tăng dần theo SoLuong.
SELECT t.MaSP,t.TenSP, t.SoLuong FROM SANPHAM t
ORDER BY t.TenSP ASC, t.SoLuong DESC;

--7Đếm các sản phẩm tương ứng theo từng khách hàng đã đặt hàng, chỉ đếm những sản phẩm được khách hang đặt hàng trên 5 sản phẩm.
SELECT COUNT(DISTINCT MaSP) AS Soluong FROM CHITIETDONHANG c
WHERE c.SoLuong > 5 


--8Liệt kê tên của toàn bộ khách hàng (tên nào giống nhau thì chỉ liệt kê một lần).
SELECT DISTINCT kh.TenKH FROM KHACHHANG kh

--9Liệt kê MaKH, TenKH, TenSP, SoLuong, NgayDat, GiaTien,TongTien (của tất cả các lần đặt hàng của khách hàng).
SELECT kh.MaKH, kh.TenKH, sp.TenSP,ct.SoLuong, sp.GiaTien,dh.NgayDat,ct.TongTien 
FROM DONHANG dh
INNER JOIN CHITIETDONHANG ct ON ct.MaDH=dh.MaDH
INNER JOIN SANPHAM sp ON sp.MaSP=ct.MaSP
INNER JOIN KHACHHANG kh ON kh.MaKH= dh.MaKH


--10Liệt kê MaKH, TenKH, MaDH, TenSP, SoLuong, TongTien của tất cả các lần đặt hàng của khách hàng
--(những khách hàng chưa đặt hàng lần nào thì vẫn phải liệt kê khách hàng đó ra).
SELECT kh.MaKH, kh.TenKH, dh.MaDH, sp.TenSP, ct.SoLuong, ct.TongTien
FROM KHACHHANG KH
LEFT JOIN DONHANG dh ON dh.MaKH=kh.MaKH
LEFT JOIN CHITIETDONHANG ct ON ct.MaDH=dh.MaDH
LEFT JOIN SANPHAM sp ON sp.MaSP=ct.MaSP


--11 Liệt kê MaKH,tenkh của những khách hàng đã từng đặt hàng với thực hiện thanh toán qua 'Visa' hoặc đã thực hiện thanh toán qua 'JCB'.
SELECT kh.MaKH, kh.TenKH FROM KHACHHANG kh
WHERE EXISTS(
	SELECT * FROM DONHANG dh
	INNER JOIN THANHTOAN tt ON tt.MaTT = dh.MaTT
	WHERE (tt.PhuongThucTT = 'Visa') OR ( tt.PhuongThucTT = 'JCB') AND( dh.MaKH= kh.MaKH)
)

SELECT kh.MaKH, kh.TenKH FROM KHACHHANG kh where MaKH in
(select DONHANG.MaKH
from DONHANG join THANHTOAN on THANHTOAN.MaTT=DONHANG.MaTT 
where (PhuongThucTT = 'Visa') OR ( PhuongThucTT = 'JCB')
)

--12Liệt kê MaKH, TenKH của những khách hàng chưa từng mua bất kỳ sản phẩm nào
SELECT kh.MaKH, kh.TenKH FROM KHACHHANG kh
WHERE NOT EXISTS(
SELECT * FROM DONHANG dh 
WHERE dh.MaKH = kh.MaKH
)

GO
SELECT MaKH,TenKH  FROM KHACHHANG
WHERE MaKH NOT IN (SELECT MaKH FROM DONHANG)


--13Liệt kê MaKH, TenKH của những khách hàng từng đặt hàng đã thanh toán qua 'VISA' và chưa từng đặt hàng với việc thanh toán qua 'JCB'.
select MaKH, TenKH from KHACHHANG where MaKH  in
(select MaKH from DONHANG join THANHTOAN on DONHANG.MaTT=THANHTOAN.MaTT
where (PhuongThucTT = 'Visa'))
and MaKH not in
(select MaKH from DONHANG join THANHTOAN on DONHANG.MaTT=THANHTOAN.MaTT
where (PhuongThucTT = 'JCB'))
--14Liệt kê MaKH, TenKH, TenSP, SoLuong, GiaTien, PhuongThuc TT, NgayDat, Tong Tien của những Khách hàng có địa chỉ là 'Da Nang' và 
--mới thực hiện đặt hàng một lần duy nhất. Kết quả liệt kê được sắp xếp tăng dần của trường TenKH
SELECT kh.MaKH,TenKH,TenSP, ct.SoLuong, GiaTien,PhuongThucTT,NgayDat,TongTien
FROM KHACHHANG kh
INNER JOIN DONHANG dh ON dh.MaKH= kh.MaKH
INNER JOIN CHITIETDONHANG ct ON ct.MaDH= dh.MaDH
INNER JOIN SANPHAM sp ON sp.MaSP= ct.MaSP
INNER JOIN THANHTOAN tt ON tt.MaTT= dh.MaTT
where kh.MaKH in
(SELECT kh.MaKH
FROM KHACHHANG kh
INNER JOIN DONHANG dh ON dh.MaKH= kh.MaKH
INNER JOIN CHITIETDONHANG ct ON ct.MaDH= dh.MaDH
INNER JOIN SANPHAM sp ON sp.MaSP= ct.MaSP
INNER JOIN THANHTOAN tt ON tt.MaTT= dh.MaTT
WHERE kh.DiaChi='Da Nang'
group by kh.MaKH
having count(dh.MaDH)=1)
order by TenKH