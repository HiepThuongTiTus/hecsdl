CREATE DATABASE LAYLOIHOI_DB
 
CREATE TABLE KHACH_HANG(
    MAKH INT PRIMARY KEY, 
    TENKH VARCHAR(30),
    DIACHI VARCHAR(50),
    SODT CHAR(11)
) 
CREATE TABLE PHONG(
    MAPHONG INT PRIMARY KEY,
    LOAIPHONG VARCHAR(20),
    SOKHACHTOIDA INT,
    GIAPHONG DECIMAL(6,3),
    MOTA VARCHAR(255)
)
CREATE TABLE DAT_PHONG(
    MADATPHONG INT PRIMARY KEY,
    MAPHONG INT,
    MAKH INT,
    NGAYDAT DATE,
    GIOBATDAU TIME,
    GIOKETTHUC TIME,
    TIENDATCOC DECIMAL(6,3),
    GHICHU VARCHAR(255),
    TRANGTHAIDAT VARCHAR(30),
    FOREIGN KEY (MAPHONG) REFERENCES PHONG(MAPHONG),
    FOREIGN KEY (MAKH) REFERENCES khach_hang(MAKH)
)
CREATE TABLE DICH_VU_DI_KEM(
    MADV INT PRIMARY KEY,
    TENDV VARCHAR(255),
    DONVITINH VARCHAR(30),
    DONGIA DECIMAL(6,3)
)
CREATE TABLE CHI_TIET_SU_DUNG_DV(
    MADATPHONG INT,
    MADV INT,
    SOLUONG INT,
    PRIMARY KEY (MADATPHONG, MADV),
    FOREIGN KEY (MADATPHONG) REFERENCES dat_phong(MADATPHONG)
)
 
-- INSERT DATA 
 
INSERT INTO PHONG  VALUES
(1, 'LOAI 1', 20, '60.000', ''),
(2, 'LOAI 1', 25, '80.000', ''),
(3, 'LOAI 2', 15, '50.000', ''),
(4, 'LOAI 3', 20, '50.000', '');
 
INSERT INTO KHACH_HANG VALUES
(1, 'MARIA OZAWA', 'HOA XUAN', '11111111111'),
(2, 'TOKUDA', 'HOA XUAN', '11111111112'),
(3, 'MIKAMI YUA', 'HOA XUAN', '11111111113'),
(4, 'NGUYEN VAN D', 'HOA XUAN', '11111111114');
 
INSERT INTO DICH_VU_DI_KEM VALUES
(1, 'HOT GIRL', 'EM', '10.000'),
(2, 'HOA HAU', 'EM', '20.000'),
(3, 'BEER', 'LON', '10.000'),
(4, 'TRAI CAY', 'DIA', '35.000');
 
 
INSERT INTO DAT_PHONG VALUES
(1, 1, 2, '2018-03-26', '11:00:00', '13:00:00', '100.000', '', 'DA DAT'),
(2, 1, 3, '2018-03-27', '17:15:00', '19:15:00', '50.000', '', 'DA HUY'),
(3, 2, 2, '2018-03-26', '20:30:00', '22:15:00', '100.000', '', 'DA DAT'),
(4, 3, 1, '2018-04-01', '19:30:00', '21:15:00', '200.000', '', 'DA DAT');
 
INSERT INTO CHI_TIET_SU_DUNG_DV VALUES
(1, 1, 20),
(1, 2, 10),
(1, 3, 3),
(2, 2, 10),
(2, 3, 1),
(3, 3, 2),
(3, 4, 10);

--Cau1: Liet ke MaDatPhong,MaDV, SoLuong >3 va <10
SELECT MADATPHONG,MADV,SOLUONG FROM CHI_TIET_SU_DUNG_DV
WHERE SOLUONG BETWEEN 4 AND 10

--Cau2:  Cập nhật dữ liệu trên trường GiaPhong thuộc bảng PHONG tăng lên 10,000 VNĐ so với giá phòng 
--hiện tại, chỉ cập nhật giá phòng của những phòng có số khách tối đa lớn hơn 10.
UPDATE PHONG SET GIAPHONG = GIAPHONG + 10 
WHERE SOKHACHTOIDA>10

--Cau3:Xóa tất cả những đơn đặt phòng (từ bảng DAT_PHONG) có trạng thái đặt (TrangThaiDat) là “Da huy”.
DELETE FROM DAT_PHONG
WHERE TRANGTHAIDAT='Da huy'

--Cau4: Hiển thị TenKH của những khách hàng có tên bắt đầu là một trong các ký tự “H”, “N”, “M” và
--có độ dài tối đa là 20 ký tự.
SELECT m.TENKH FROM KHACH_HANG m
WHERE TENKH LIKE 'HNM%' AND LEN(TENKH) <=20

--Cau5: Hiển thị TenKH của tất cả các khách hàng có trong hệ thống, TenKH nào trùng nhau thì chỉ
--hiển thị một lần. Sinh viên sử dụng hai cách khác nhau để thực hiện yêu cầu trên, mỗi cách sẽ được 0,5 điểm.
SELECT DISTINCT TENKH FROM KHACHHANG

SELECT TENKH FROM KHACH_HANG
GROUP BY TENKH 

--Cau6: Hiển thị MaDV, TenDV,DonViTinh, DonGia của những dịch vụ đi kèm có DonViTinh là “lon” và có DonGia 
--lớn hơn 10,000 VNĐ hoặc những dịch vụ đi kèm có DonViTinh là “Cai” và có DonGia nhỏ hơn 5,000 VNĐ.
SELECT MaDV, TENDV, DONVITINH, DONGIA FROM DICH_VU_DI_KEM
WHERE (DONVITINH LIKE 'LON' AND DONGIA>10) OR (DONVITINH LIKE 'CAI' AND DONGIA<5)

--Cau7:  Hiển thị MaDatPhong, MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, MaKH, TenKH, SoDT, NgayDat,
--GioBatDau, GioKetThuc, MaDichVu,SoLuong, DonGia của những đơn đặt phòng có năm đặt phòng là “2016”,
--“2017” và đặt những phòng có giá phòng > 50,000 VNĐ/ 1 giờ
SELECT dp.MADATPHONG, dp.MAPHONG,p.LOAIPHONG,p.SOKHACHTOIDA,p.GIAPHONG,kh.MAKH,kh.TENKH,kh.SODT,dp.NGAYDAT, dp.GIOBATDAU, dp.GIOKETTHUC, dv.MaDV,
ct.SOLUONG,dv.DONGIA FROM DAT_PHONG dp
INNER JOIN PHONG p ON p.MAPHONG=dp.MAPHONG
INNER JOIN KHACH_HANG kh ON kh.MAKH=dp.MAKH
INNER JOIN CHI_TIET_SU_DUNG_DV ct ON dp.MADATPHONG=ct.MADATPHONG
INNER JOIN DICH_VU_DI_KEM dv ON ct.MADV=dv.MADV
WHERE (YEAR(NGAYDAT) =2016 OR YEAR(NGAYDAT)=2018) AND p.GIAPHONG>50

--Cau8:Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH, NgayDat, TongTienHat,
--TongTienSuDungDichVu, TongTienThanhToan tương ứng với từng mã đặt phòng có trong bảng DAT_PHONG.
--Những đơn đặt phòng nào không sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin của đơn đặt phòng đó ra. 
	
	--(TongTienHat = GiaPhong * (GioKetThuc – GioBatDau)
		--TongTienSuDungDichVu = SoLuong * DonGia
		--TongTienThanhToan = TongTienHat + sum (TongTienSuDungDichVu))
SELECT dp.MADATPHONG, p.MAPHONG,p.LOAIPHONG,p.GIAPHONG,kh.TENKH,dp.NGAYDAT,p.GIAPHONG * (GIOKETTHUC-GIOBATDAU) 
AS TONGTIENHAT, SUM(ct.SOLUONG * dv.DONGIA) AS TongTienSuDungDichVu, (p.GIAPHONG*(GIOKETTHUC-GIOBATDAU)+SUM(CT.SOLUONG*dv.DONGIA))
FROM DAT_PHONG dp
JOIN KHACHHANG kh ON dp.MAKH=kh.MAKH
JOIN PHONG p ON p.MAPHONG=dp.MAPHONG
JOIN CHI_TIET_SU_DUNG_DV ct ON dp.MADATPHONG=ct.MADATPHONG
JOIN DICH_VU_DI_KEM dv ON ct.MADV = dv.MADV
GROUP BY dp.MADATPHONG

--Cau 9:Hiển thị MaKH, TenKH, DiaChi, SoDT của những khách hàng đã từng đặt phòng karaoke 
--có địa chỉ ở “Hoa xuan”.
SELECT KH.MAKH, KH.TENKH, KH.DIACHI,KH.SODT FROM KHACH_HANG KH
WHERE KH.DIACHI='Hoa Xuan' AND EXISTS(
	SELECT * FROM DAT_PHONG dp 
	WHERE KH.MAKH = dp.MAKH
)
--Cau10: Hiển thị MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, SoLanDat của những phòng được
--khách hàng đặt có số lần đặt lớn hơn 2 lần và trạng thái đặt là “Da dat”. 
SELECT p.MAPHONG, p.LOAIPHONG, p.SOKHACHTOIDA, p.GIAPHONG, COUNT(dp.MAPHONG) AS SOLUONGDAT  FROM PHONG p
JOIN DAT_PHONG dp ON p.MAPHONG=dp.MAPHONG
WHERE dp.TRANGTHAIDAT='DA DAT'
GROUP BY p.MAPHONG HAVING COUNT(dp.MAPHONG)>2