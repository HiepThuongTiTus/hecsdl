create table KHACHHANG (
   MaKH varchar(10) primary key,
   TenKH varchar(50),
   DiaChi varchar(50),
   SoDT varchar(10),
   MaSoThue varchar(10)
)
create table MUCTIENGIO (
   MaTienGio varchar(10) primary key,
   DonGia decimal(6,3),
   MoTa varchar(50)
)
create table PHONG (
   MaPhong varchar(10) primary key,
   SochHangToiDa int,
   TrangThai varchar(50),
   MoTa varchar(50)
)
create table DICHVU (
   MaDV varchar(10) primary key,
   TenDV varchar(50),
   DonViTinh varchar(10),
   DonGia decimal(6,3),
)
   CREATE TABLE HOADON
(
    MaHD VARCHAR(10) NOT NULL PRIMARY KEY,
    MaKH VARCHAR(10) NOT NULL,
    MaPhong VARCHAR(10) NOT NULL,
    MaTienGio VARCHAR(10) NOT NULL,
    ThoiGianBatDauSD SMALLDATETIME NOT NULL,
    ThoiGIanKetThucSD SMALLDATETIME NOT NULL,
    TrangThaiHD VARCHAR(50) NOT NULL
    FOREIGN KEY (MaKH) REFERENCES dbo.KHACHHANG(MaKH),
    FOREIGN KEY (MaPhong) REFERENCES dbo.PHONG(MaPhong),
    FOREIGN KEY (MaTienGio) REFERENCES dbo.MUCTIENGIO(MaTienGio)
)
create table CHITIET_SUDUNGDV (
   MaHD varchar(10),
   MaDV varchar(10),
   SoLuong int,
   foreign key (MaHD) references HOADON(MaHD),
   foreign key (MaDV) references DICHVU(MaDV)
)
insert into KHACHHANG (MaKH,TenKH,DiaChi,SoDT,MaSoThue)
values ('KH001','Tran Van Nam','Hai Chau',0905123456,'12345678')
insert into KHACHHANG (MaKH,TenKH,DiaChi,SoDT,MaSoThue)
values 
('KH002','Nguyen Mai Anh','Lien Chieu',0905123456,'12345678'),
('KH003','Phan Hoai Lan Khue','Hoa Vang',0905123456,'12345678'),
('KH004','Nguyen Hoai Nguyen','Hoa Cam',0905123456,'12345678'),
('KH005','Le Truong Ngoc Anh','Hai Chau',0905123456,'12345678'),
('KH006','Ho Hoai Anh','Hai Chau',0905123456,'12345678'),
('KH007','Pham Thij Huong','Son Tra',0905123456,'12345678'),
('KH008','Chau Trinh Tri','Hai Chau',0905123456,'12345678'),
('KH009','Phan Nhu Thao','Hoa Khanh',0905123456,'12345678'),
('KH010','Tran Thi To Tam','Son Tra',0905123456,'12345678');
insert into PHONG(MaPhong,SochHangToiDa,TrangThai,MoTa)
values 
('VIP01',5,'Duoc Su Dung','Phong vip'),
('P02',10,'Duoc Su Dung','Phong binh thuong'),
('P03',15,'Duoc Su Dung','Phong binh thuong'),
('VIP04',20,'Duoc Su Dung','Phong vip'),
('P05',25,'Duoc Su Dung','Phong binh thuong'),
('P06',30,'Duoc Su Dung','Phong binh thuong'),
('VIP07',35,'Duoc Su Dung','Phong vip'),
('P08',40,'Duoc Su Dung','Phong binh thuong'),
('VIP09',45,'Duoc Su Dung','Phong vip'),
('P10',50,'Duoc Su Dung','Phong binh thuong');
 insert into DICHVU(MaDV,TenDV,DonViTinh,DonGia)
 values 
 ('DV01','Hat Dua','Bao',5.000),
 ('DV02','Trai Cay','Dia',30.000),
 ('DV03','Bia','Lon',35.000),
 ('DV04','Nuoc Ngot','Chai',10.000),
 ('DV05','Ruou','Chai',100.000);
  insert into MUCTIENGIO(MaTienGio,DonGia,MoTa)
 values ('MT01',60.000,'Ap dung tu 6 gio den 7 gio'),
 ('MT02',80.000,'Ap dung sau 17 gio den 22 gio'),
 ('MT03',100.000,'Ap dung tu sau 22 gio den 6 gio sang')
INSERT INTO HOADON VALUES('HD001','KH001','VIP01','MT01','11/20/2015 8:15','11/20/2015 12:30','Da thanh toan')
INSERT INTO HOADON VALUES('HD002','KH002','P02','MT01','12/12/2015 13:10','12/12/2015 17:20','chua thanh toan')
INSERT INTO HOADON VALUES('HD003','KH001','P02','MT01','10/15/2014 12:12','10/15/2014 18:30','Da thanh toan')
INSERT INTO HOADON VALUES('HD004','KH003','VIP01','MT02','9/20/2015 18:30','9/20/2015 21:00','chua thanh toan')
INSERT INTO HOADON VALUES('HD005','KH001','P03','MT02','11/25/2014 20:00','11/25/2014 21:45','thanh toan mot phan')
INSERT INTO HOADON VALUES('HD006','KH002','VIP01','MT01','9/12/2014 9:20','9/12/2014 10:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD007','KH006','VIP04','MT01','12/22/2014 11:10','12/22/2014 14:20','Da thanh toan')
INSERT INTO HOADON VALUES('HD008','KH007','VIP04','MT02','8/23/2014 20:10','8/23/2014 22:00','chua thanh toan')
INSERT INTO HOADON VALUES('HD009','KH006','P05','MT03','12/20/2015 22:30','12/20/2015 1:15','chua thanh toan')
INSERT INTO HOADON VALUES('HD010','KH005','VIP01','MT03','10/10/2015 1:30','10/10/2015 3:15','Da thanh toan')
INSERT INTO HOADON VALUES('HD011','KH004','VIP07','MT03','12/25/2015 22:15','12/25/2015 2:00','Da thanh toan')
INSERT INTO HOADON VALUES('HD012','KH008','P06', 'MT03', '7/25/2014 23:45','7/26/2015 2:15','Da thanh toan')
INSERT INTO HOADON VALUES('HD013','KH007','VIP07', 'MT02', '8/21/2015 18:15','8/21/2015 20:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD014','KH004','P06', 'MT02', '12/31/2015 19:12','12/31/2015 21:15','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD015','KH001','P06', 'MT01', '6/24/2014 13:00','6/24/2014 13:15','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD016','KH003','P08', 'MT01', '5/12/2014 8:00','5/12/2014 10:45','Thanh toan mot phan')
INSERT INTO HOADON VALUES('HD017','KH003','VIP09', 'MT01', '11/12/2015 12:15','10/15/2014 14:20','Da thanh toan')
INSERT INTO HOADON VALUES('HD018','KH001','P10', 'MT01', '4/12/2015 14:45','4/12/2015 16:45','Da thanh toan')
INSERT INTO HOADON VALUES('HD019','KH002','VIP09', 'MT03', '11/12/2015 22:12','11/13/2015 2:00','Da thanh toan')
INSERT INTO HOADON VALUES('HD020','KH004','VIP09', 'MT03', '2/25/2014 1:15','2/25/2014 4:15','Chua thanh toan')
/*Câu 3: Liệt kê những phòng karaoke chứa được số lượng tối đa dưới 20 khách (0.5 điểm)
select * from PHONG*/
SELECT * FROM PHONG
where SochHangToiDa < 20
/*Câu 4: Liệt kê thông tin của các dịch vụ có đơn vị tính là "Chai" với đơn giá nhỏ hơn 20.000
VNĐ và các dịch vụ có đơn vị tính là "Lon" với đơn giá lớn hơn 30.000 VNĐ (0.5 điểm)*/
select * from DICHVU
where DonViTinh = 'Chai' and DonGia < 20.000;
/*Câu 5: Liệt kê thông tin của các phòng karaoke có mã phòng bắt đầu bằng cụm từ "VIP" (0.5
điểm)*/
select * from PHONG
where MaPhong LIKE '%VIP%';
/*Câu 6: Liệt kê thông tin của toàn bộ các dịch vụ, yêu cầu sắp xếp giảm dần theo đơn giá (0.5
điểm)*/
select * from DICHVU 
order by DonGia DESC;
/*Câu 7: Đếm số hóa đơn có trạng thái là "Chưa thanh toán" và có thời gian bắt đầu sử
dụng nằm trong ngày hiện tại (0.5 điểm)*/
select count (*) from HOADON
where (TrangThaiHD ='Chua thanh toan' and ThoiGianBatDauSD = 'DATE()' );
/*Câu 8: Liệt kê địa chỉ của toàn bộ các khách hàng với yêu cầu mỗi địa chỉ được liệt kê một
lần duy nhất (0.5 điểm)*/
select Distinct kh.DiaChi from KHACHHANG kh 
/*Câu 9: Liệt kê MaHD, MaKH, TenKH, DiaChi, MaPhong, DonGia (Tiền giờ),
ThoiGianBatDauSD, ThoiGianKetThucSD của tất cả các hóa đơn có trạng thái là "Đã thanh
toán" (0.5 điểm)*/
select hd.MaHD, hd.ThoiGianBatDauSD ,hd.ThoiGianKetThucSD, kh.MaKH, kh.TenKH, kh.DiaChi, p.MaPhong, d.DonGia
from HOADON hd
INNER JOIN KHACHHANG kh on kh.MaKH = hd.MaKH
inner join PHONG p on p.MaPhong = hd.MaPhong
inner join MUCTIENGIO d on d.MaTienGio = hd.MaTienGio
where hd.TrangThaiHD = 'Da thanh toan'
/*Câu 11: Liệt kê thông tin của các khách hàng đã từng sử dụng dịch vụ "Trái cây" hoặc từng
sử dụng phòng karaoke có mã phòng là "VIP07" (0.5 điểm)*/
select * from KHACHHANG kh
where exists (
      select * from DICHVU kh, PHONG p 
	  where kh.TenDV ='Trai cay' and p.MaPhong ='VIP07'
)
/*Câu 12: Liệt kê thông tin của các khách hàng chưa từng sử dụng dịch vụ hát karaoke lần nào
cả (0.5 điểm)*/
select * from KHACHHANG kh
where not exists(
      select * from HOADON hd
	  where (kh.MaKH=hd.MaKH)
)