
CREATE TABLE KHACH_HANG1
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	DiaChi VARCHAR(30),
	SoDT CHAR(15),
)
CREATE TABLE LOAI_XE
(
	MaLoaiXe VARCHAR(30) NOT NULL PRIMARY KEY,
	MoTa VARCHAR(30),
)
CREATE TABLE XE_CHO_THUE
(
	MaXe VARCHAR(30) NOT NULL PRIMARY KEY,
	BienSoXe VARCHAR(30),
	HangXe VARCHAR(30),
	MaLoaiXe VARCHAR(30),
	DonGiaChoThue DECIMAL(6,3),
	FOREIGN KEY (MaLoaiXe) REFERENCES LOAI_XE(MaLoaiXe)
)
CREATE TABLE LOAI_DICH_VU
(
	MaLoaiDV VARCHAR(30) NOT NULL PRIMARY KEY,
	MoTa VARCHAR(30),

	
)
CREATE TABLE HOPDONGCHOTHUE
(
	MaHD VARCHAR(30) NOT NULL PRIMARY KEY,
	MaKH VARCHAR(30),
	SoTienDatCoc VARCHAR(30),
	TrangThaiHD VARCHAR(30),
	FOREIGN KEY (MaKH) REFERENCES KHACH_HANG1(MaKH)
)
CREATE TABLE CHITIETHOPDONG
(
	MaHD VARCHAR(30) NOT NULL,
	MaXe VARCHAR(30) NOT NULL,
	MaLoaiDV VARCHAR(30),
	NgayNhanXe DATE,
	NgayTraXe DATE,
	FOREIGN KEY (MaHD) REFERENCES HOPDONGCHOTHUE(MaHD),
	FOREIGN KEY (MaXe) REFERENCES XE_CHO_THUE(MaXe),
	FOREIGN KEY (MaLoaiDV) REFERENCES LOAI_DICH_VU(MaLoaiDV),
	PRIMARY KEY (MaHD, MaXe)
)
--KHACHHANG
INSERT INTO KHACH_HANG1 VALUES('KH0001', 'Bui Le Suoi', 'Lien Chieu', '09012345')
INSERT INTO KHACH_HANG1 VALUES('KH0002', 'Bui Le Man', 'Thanh Khe', '09112345')
INSERT INTO KHACH_HANG1 VALUES('KH0003', 'Nguyen Thu', 'Lien Chieu', '09112346')
INSERT INTO KHACH_HANG1 VALUES('KH0004', 'Nguyen Dong', 'Thanh Khe', '09012346')
INSERT INTO KHACH_HANG1 VALUES('KH0005', 'Bui Ha', 'Hai Chau', '09012347')
INSERT INTO KHACH_HANG1 VALUES('KH0006', 'Nguyen Xuan', 'Hai Chau', '0914987654')
INSERT INTO KHACH_HANG1 VALUES('KH0006', 'Đặng Hoài Sơn', 'Liên chiểu', '0905666666')
INSERT INTO KHACH_HANG1 VALUES('KH0006', 'Đặng Ngọc Chi', 'Hải Châu', '0905123456')

--LOAIXE
INSERT INTO LOAI_XE VALUES('LX01', 'Xe 4 cho')
INSERT INTO LOAI_XE VALUES('LX02', 'Xe 6 cho')
INSERT INTO LOAI_XE VALUES('LX03', 'Xe 7 cho')
INSERT INTO LOAI_XE VALUES('LX04', 'Xe 16 cho')
INSERT INTO LOAI_XE VALUES('LX05', 'Xe 24 cho')
INSERT INTO LOAI_XE VALUES('LX06', 'Xe 32 cho')
--XECHOTHUE
INSERT INTO XE_CHO_THUE VALUES('X001', '43A-567.28','Kia', 'LX01', 300.000)
INSERT INTO XE_CHO_THUE VALUES('X002', '43D-129.98','Honda', 'LX02', 40.000)
INSERT INTO XE_CHO_THUE VALUES('X003', '92A145676','SUZUKI', 'LX03', 500.000)
INSERT INTO XE_CHO_THUE VALUES('X004', '92A145677','Toyota', 'LX04', 60.000)
INSERT INTO XE_CHO_THUE VALUES('X005', '92A145678','YAMAHA', 'LX05', 70.000)
INSERT INTO XE_CHO_THUE VALUES('X006', '92A145679','YAMAHA', 'LX06', 80.000)
--LOAIDICHVU
INSERT INTO LOAI_DICH_VU VALUES ('DV0001', 'DU LICH')
INSERT INTO LOAI_DICH_VU VALUES ('DV0002', 'DAM CUOI')
INSERT INTO LOAI_DICH_VU VALUES ('DV0003', 'TAP LAI')
--HOPDONGTHUEXE
INSERT INTO HOPDONGCHOTHUE VALUES ('HD001', 'KH0001', '0', 'Chưa bắt đầu')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD002', 'KH0002', '100000', 'Đang cho thuê')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD003', 'KH0004', '50000', 'Đã kết thúc')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD004', 'KH0005', '100000', 'Chưa bắt đầu')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD005', 'KH0004', '100000', 'NULL')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD006', 'KH0004', '200000', 'Đã kết thúc')
INSERT INTO HOPDONGCHOTHUE VALUES ('HD007', 'KH0001', '0', 'Đã kết thúc')
--CHITIETHOPDONG
INSERT INTO CHITIETHOPDONG VALUES ('HD006','X001', 'DV0001', '2018-06-13', '2018-07-13')
INSERT INTO CHITIETHOPDONG VALUES ('HD006','X003',  'DV0002', '2019-09-23', '2019-10-13')
INSERT INTO CHITIETHOPDONG VALUES ('HD005','X002',  'DV0001', '2020-07-07', '2020-07-13')
INSERT INTO CHITIETHOPDONG VALUES ('HD003','X004', 'DV0002', '2018-06-14', '2018-07-15')
INSERT INTO CHITIETHOPDONG VALUES ('HD001','X005',  'DV0003', '2019-06-10', '2019-06-13')
INSERT INTO CHITIETHOPDONG VALUES ('HD002','X006', 'DV0003', '2018-06-13', '2018-06-15')
INSERT INTO CHITIETHOPDONG VALUES ('HD001','X005',  'DV0002', '2019-10-13', '2019-10-18')
INSERT INTO CHITIETHOPDONG VALUES ('HD003','X004',  'DV0001', '2019-08-13', '2019-10-18')
INSERT INTO CHITIETHOPDONG VALUES ('HD004','X006',  'DV0003', '2020-10-13', '2020-10-18')

--Select  *from
SELECT *FROM KHACH_HANG1

SELECT *FROM LOAI_XE

SELECT *FROM XE_CHO_THUE

SELECT *FROM LOAI_DICH_VU

SELECT *FROM HOPDONGCHOTHUE

SELECT *FROM CHITIETHOPDONG


-- Câu 1.3. Liệt kê những xe cho thuê gồm các thông tin về mã xe, biển số xe, hãng xe có đơn giá cho thuê nhỏ hơn 500.000 VND.
SELECT MaXe, BienSoXe, HangXe
FROM XE_CHO_THUE
WHERE DonGiaChoThue < 500000
--Câu 1.4. Liệt kê những khách hàng gồm thông tin mã khách hàng, họ và tên khách hàng có địa chỉ ở ‘Liên Chiểu’ 
--mà có số điện thoại bắt đầu bằng ‘090’ và những khách hàng có địa chỉ ở ‘Hải Châu’ mà có số điện thoại bắt đầu bằng ‘091’.
SELECT MaKH, TenKH
FROM KHACH_HANG1
WHERE DiaChi = ' Liên chiểu' AND SoDT = '%090%'
UNION 
SELECT MaKH, TenKH
FROM KHACH_HANG1
WHERE DiaChi = ' Hải Châu' AND SoDT = '%091%'

--Câu 1.5. Liệt kê thông tin của các khách hàng có họ (trong họ tên) là ‘Đặng
SELECT * FROM KHACH_HANG1
WHERE TenKH LIKE '%Đặng%'
--Câu 1.6. Liệt kê thông tin mã xe, hãng xe của toàn bộ các xe được thuê một lần duy nhất.
SELECT MaXe, HangXe
FROM XE_CHO_THUE
GROUP BY MaXe, HangXe

--Câu 1.7. Liệt kê các hợp đồng cho thuê gồm mã hợp đồng, số tiền đặt cọc có trạng thái hợp đồng là ‘Đã kết thúc’ của khách hàng có tên là ‘Chi’.
SELECT MaHD, SoTienDatCoc
FROM HOPDONGCHOTHUE
JOIN KHACH_HANG1 ON HOPDONGCHOTHUE.MaKH = KHACH_HANG1.MaKH
WHERE TrangThaiHD = ' Đã kết thúc' AND TenKH = 'Chi'

--Câu 1.8. Liệt kê thông tin của các khách hàng mà chưa có hợp đồng thuê xe nào
SELECT * FROM KHACH_HANG1
WHERE MaKH NOT IN ( SELECT MaKH FROM HOPDONGCHOTHUE)
--Câu 1.9. Cho biết những mã hợp đồng mà vừa sử dụng loại dịch vụ 'Đám cưới' 
--vừa sử dụng loại dịch vụ 'Du lịch'.
SELECT H.MaHD FROM HOPDONGCHOTHUE H JOIN CHITIETHOPDONG C ON C.MAHD=H.MaHD
JOIN LOAI_DICH_VU D ON D.MaLoaiDV=C.MaLoaiDV
WHERE MoTa='DAM CUOI' AND MoTa='DU LICH'

--Câu 1.10. Liệt kê họ và tên khách hàng, mã h
ợp đồng, trạng thái hợp đồng của tất cả các hợp đồng với yêu cầu những khách hàng 
--chưa có một hợp đồng nào thì cũng phải liệt kê thông tin những họ và tên khách hàng đó ra.
SELECT HOPDONGCHOTHUE.MaHD, TrangThaiHD
FROM HOPDONGCHOTHUE
LEFT JOIN CHITIETHOPDONG ON CHITIETHOPDONG.MaHD = HOPDONGCHOTHUE.MaHD
--Câu 11: Liệt kê không trùng lặp thông tin mã khách hàng, họ và tên khách hàng của các khách hàng có địa chỉ là ‘Hải Châu’ đã từng thuê xê thuộc loại xe có mô tả là ‘Xe 24 chỗ’ hoặc các khách hàng từng thuê xe có thời gian nhận xe là 07/07/2020. 
--Sắp xếp tăng dần theo mã khách hàng và giảm dần theo họ và tên khách hàng.
SELECT distinct K.MAKH, K.TenKH  FROM KHACH_HANG K JOIN HOPDONGCHOTHUE H ON H.MaKH=K.MAKH
JOIN CHITIETHOPDONG C ON C.MAHD= H.MaHD
JOIN XE_CHO_THUE X ON X.MaXe = C.MaXe 
WHERE DiaChi = 'Hải Châu' OR NGAYNHANXE = '2020-07-07'
ORDER BY MAKH ASC, TenKH DESC 
--Câu 1.12. Thống kê số lần được thuê của các xe mà xe đó có số ngày mượn lớn hơn 10 ngày gồm các thông tin mã xe, số lần thuê.
	SELECT MaXe, count (CHITIETHOPDONG.MaHD) as Solanthue from HOPDONGCHOTHUE join CHITIETHOPDONG on CHITIET_HOPDONGCHOTHUE.MaHD = HOPDONGCHOTHUE.MaHD 
	group by MaXe having count(CHITIETHOPDONG.MaHD) > 10
--Câu 1.13. Cho biết có bao nhiêu xe đã được đùng để cho thuê trong tổng số xe

--Câu 1.14. Liệt kê thông tin của những khách hàng đã từng thuê xe vào năm 2018 nhưng chưa từng thuê vào năm 2019
SELECT * FROM KHACH_HANG1
JOIN HOPDONGCHOTHUE ON HOPDONGCHOTHUE.MaKH = KHACH_HANG1.MaKH
JOIN CHITIETHOPDONG ON CHITIETHOPDONG.MaHD = HOPDONGCHOTHUE.MaHD
WHERE YEAR(NgayNhanXe) = '2018' AND YEAR(NgayNhanXe) != '2019'

--Câu 15: Liệt kê họ và tên của khách hàng mà có từ hai hợp đồng thuê xe trở lên.
SELECT COUNT(DISTINCT MaKH) AS TongSoKH FROM HOPDONGCHOTHUE HD 
JOIN CHITIETHOPDONG CT ON HD.MaHD= CT.MaHD
GROUP BY MaKH
HAVING COUNT(MaKH) >= 2
-- Câu 1.16. Cập nhật cột trạng thái hợp đồng thành ‘Bị hủy’ đối với những hợp đồng có trạng thái là ‘Chưa bắt đầu’ và có số tiền đặt cọc là 0
UPDATE HOPDONGCHOTHUE
SET TrangThaiHD = 'Bi huy '
WHERE TrangThaiHD='Chua  bat  dau' AND SoTienDatCoc=0
-- Câu 17.Xóa những loại dịch vụ chưa từng được sử dụng trong bất kỳ một hợp đồng nào.
DELETE FROM LOAI_DICH_VU
WHERE MaLoaiDV NOT IN ( SELECT MaLoaiDV FROM CHITIETHOPDONG)
