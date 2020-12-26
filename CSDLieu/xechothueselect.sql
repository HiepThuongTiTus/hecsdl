--cau1: 
CREATE TABLE KHACHHANG
(
	MaKH NVARCHAR(10) NOT NULL PRIMARY KEY,
	HoTenKH NVARCHAR(100),
	DiaChiKH NVARCHAR(100),
	SoDienThoaiKH NVARCHAR(50),
)
CREATE TABLE LOAIXE
(
	MaLoaiXe NVARCHAR(10) NOT NULL PRIMARY KEY,
	MoTa NVARCHAR(100),
)
CREATE TABLE XECHOTHUE
(
	MaXe NVARCHAR(10) NOT NULL PRIMARY KEY,
	BienSoXe NVARCHAR(50),
	HangXe NVARCHAR(50),
	MaLoaiXe NVARCHAR(10),
	DonGiaChoThue NVARCHAR(50),
	FOREIGN KEY (MaLoaiXe) REFERENCES LOAIXE(MaLoaiXe)
)
CREATE TABLE LOAIDICHVU
(
	MaLoaiDV NVARCHAR(10) NOT NULL PRIMARY KEY,
	MoTaLoaiDV NVARCHAR(50),

	
)
CREATE TABLE HOPDONGTHUEXE
(
	MaHopDong NVARCHAR(10) NOT NULL PRIMARY KEY,
	MaKH NVARCHAR(10),
	SoTienDatCoc NVARCHAR(50),
	TrangThaiHopDong NVARCHAR(100),
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
)
CREATE TABLE CHITIETHOPDONG
(
	MaHopDong NVARCHAR(10) NOT NULL,
	MaXe NVARCHAR(10) NOT NULL,
	MaLoaiDV NVARCHAR(10),
	NgayNhanXe DATE,
	NgayTraXe DATE,
	FOREIGN KEY (MaHopDong) REFERENCES HOPDONGTHUEXE(MaHopDong),
	FOREIGN KEY (MaXe) REFERENCES XECHOTHUE(MaXe),
	FOREIGN KEY (MaLoaiDV) REFERENCES LOAIDICHVU(MaLoaiDV),
	PRIMARY KEY (MaHopDong, MaXe)
)
--KHACHHANG
INSERT INTO KHACHHANG VALUES(N'KH0001', N'Bui Le Suoi', N'Lien Chieu', '09012345')
INSERT INTO KHACHHANG VALUES(N'KH0002', N'Bui Le Man', N'Thanh Khe', '09112345')
INSERT INTO KHACHHANG VALUES(N'KH0003', N'Nguyen Thu', N'Lien Chieu', '09112346')
INSERT INTO KHACHHANG VALUES(N'KH0004',N'Nguyen Dong', N'Thanh Khe', '09012346')
INSERT INTO KHACHHANG VALUES(N'KH0005', N'Bui Ha', N'Hai Chau', '09012347')
INSERT INTO KHACHHANG VALUES(N'KH0006', N'Nguyen Xuan', N'Hai Chau', '0914987654')
INSERT INTO KHACHHANG VALUES(N'KH0006', N'Đặng Hoài Sơn', N'Liên chiểu', '0905666666')
INSERT INTO KHACHHANG VALUES(N'KH0006', N'Đặng Ngọc Chi', N'Hải Châu', '0905123456')

--LOAIXE
INSERT INTO LOAIXE VALUES(N'LX01', N'Xe 4 cho')
INSERT INTO LOAIXE VALUES(N'LX02', N'Xe 6 cho')
INSERT INTO LOAIXE VALUES(N'LX03', N'Xe 7 cho')
INSERT INTO LOAIXE VALUES(N'LX04', N'Xe 16 cho')
INSERT INTO LOAIXE VALUES(N'LX05', N'Xe 24 cho')
INSERT INTO LOAIXE VALUES(N'LX06', N'Xe 32 cho')
--XECHOTHUE
INSERT INTO XECHOTHUE VALUES(N'X001', N'43A-567.28',N'Kia', N'LX01', 300.000)
INSERT INTO XECHOTHUE VALUES(N'X002', N'43D-129.98',N'Honda', N'LX02', 40.000)
INSERT INTO XECHOTHUE VALUES(N'X003', N'92A145676',N'SUZUKI', N'LX03', 500.000)
INSERT INTO XECHOTHUE VALUES(N'X004', N'92A145677',N'Toyota', N'LX04', 60.000)
INSERT INTO XECHOTHUE VALUES(N'X005', N'92A145678',N'YAMAHA', N'LX05', 70.000)
INSERT INTO XECHOTHUE VALUES(N'X006', N'92A145679',N'YAMAHA', N'LX06', 80.000)
--LOAIDICHVU
INSERT INTO LOAIDICHVU VALUES (N'DV0001', N'DU LICH')
INSERT INTO LOAIDICHVU VALUES (N'DV0002', N'DAM CUOI')
INSERT INTO LOAIDICHVU VALUES (N'DV0003', N'TAP LAI')
--HOPDONGTHUEXE
INSERT INTO HOPDONGTHUEXE VALUES (N'HD001', N'KH0001', '0', N'CHUA BAT DAU')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD002', N'KH0002', '100000', N'DANG CHO THUE')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD003', N'KH0004', '50000', N'DA KET THUC')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD004', N'KH0005', '100000', N'CHUA BAT DAU')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD005', N'KH0004', '100000', N'NULL')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD006', N'KH0004', '200000', N'DA KET THUC')
INSERT INTO HOPDONGTHUEXE VALUES (N'HD007', N'KH0001', '0', N'DA KET THUC')
--CHITIETHOPDONG
INSERT INTO CHITIETHOPDONG VALUES (N'HD006',N'X001', N'DV0001', '2018-06-13', '2018-07-13')
INSERT INTO CHITIETHOPDONG VALUES (N'HD006',N'X003',  N'DV0002', '2019-09-23', '2019-10-13')
INSERT INTO CHITIETHOPDONG VALUES (N'HD005',N'X002',  N'DV0001', '2020-07-07', '2020-07-13')
INSERT INTO CHITIETHOPDONG VALUES (N'HD003',N'X004', N'DV0002', '2018-06-14', '2018-07-15')
INSERT INTO CHITIETHOPDONG VALUES (N'HD001',N'X005',  N'DV0003', '2019-06-10', '2019-06-13')
INSERT INTO CHITIETHOPDONG VALUES (N'HD002',N'X006', N'DV0003', '2018-06-13', '2018-06-15')
INSERT INTO CHITIETHOPDONG VALUES (N'HD001',N'X005',  N'DV0002', '2019-10-13', '2019-10-18')
INSERT INTO CHITIETHOPDONG VALUES (N'HD003',N'X004',  N'DV0001', '2019-08-13', '2019-10-18')
INSERT INTO CHITIETHOPDONG VALUES (N'HD004',N'X006',  N'DV0003', '2020-10-13', '2020-10-18')
-- Câu 1.3. Liệt kê những xe cho thuê gồm các thông tin về mã xe, biển số xe, hãng xe có đơn giá cho thuê nhỏ hơn 500.000 VND.
SELECT MaXe, BienSoXe, HangXe
FROM XECHOTHUE
WHERE DonGiaChoThue < 500000
--Câu 1.4. Liệt kê những khách hàng gồm thông tin mã khách hàng, họ và tên khách hàng có địa chỉ ở ‘Liên Chiểu’ mà có số điện thoại bắt đầu bằng ‘090’ và những khách hàng có địa chỉ ở ‘Hải Châu’ mà có số điện thoại bắt đầu bằng ‘091’.
SELECT MaKH, HoTenKH
FROM KHACHHANG
WHERE (DiaChiKH LIKE N'Liên chiểu' AND SoDienThoaiKH LIKE '%090%') OR (DiaChiKH LIKE N'Hải Châu' AND SoDienThoaiKH LIKE '%091%')
--Câu 1.5. Liệt kê thông tin của các khách hàng có họ (trong họ tên) là ‘Đặng
SELECT * FROM KHACHHANG
WHERE HoTenKH LIKE N'Đặng%'
--Câu 1.6. Liệt kê thông tin mã xe, hãng xe của toàn bộ các xe được thuê một lần duy nhất.
SELECT x.MaXe, HangXe
FROM HOPDONGTHUEXE a
INNER JOIN CHITIETHOPDONG c ON a.MaHopDong=c.MaHopDong
INNER JOIN XECHOTHUE x ON x.MaXe= c.MaXe
GROUP BY x.MaXe, HangXe
HAVING COUNT(c.MaHopDong)=1;

--Câu 1.7. Liệt kê các hợp đồng cho thuê gồm mã hợp đồng, số tiền đặt cọc có trạng thái hợp đồng là ‘Đã kết thúc’ của khách hàng có tên là ‘Chi’.
SELECT MaHopDong, SoTienDatCoc
FROM HOPDONGTHUEXE
JOIN KHACHHANG ON HOPDONGTHUEXE.MaKH = KHACHHANG.MaKH
WHERE TrangThaiHopDong LIKE N' Da ket thuc' AND HoTenKH LIKE N'%Chi'

--Câu 1.8. Liệt kê thông tin của các khách hàng mà chưa có hợp đồng thuê xe nào
SELECT * FROM KHACHHANG
WHERE MaKH NOT IN ( SELECT MaKH FROM HOPDONGTHUEXE)
--Câu 1.9. Cho biết những mã hợp đồng mà vừa sử dụng loại dịch vụ 'Đám cưới' vừa sử dụng loại dịch vụ 'Du lịch'.
SELECT H.MaHopDong 
FROM HOPDONGTHUEXE H JOIN CHITIETHOPDONG C ON C.MAHOPDONG=H.MaHopDong
JOIN LOAIDICHVU D ON D.MaLoaiDV=C.MaLoaiDV
WHERE MoTaLoaiDV LIKE N'DAM CUOI' AND MoTaLoaiDV LIKE N'DU LICH'
--Câu 1.10. Liệt kê họ và tên khách hàng, mã hợp đồng, trạng thái hợp đồng của tất cả các hợp đồng với yêu cầu những khách hàng chưa có một hợp đồng nào thì cũng phải liệt kê thông tinh những họ và tên khách hàng đó ra.
SELECT  k.HoTenKH,h.MaHopDong, TrangThaiHopDong
FROM HOPDONGTHUEXE h
RIGHT JOIN KHACHHANG k ON h.MaKH=k.MaKH
--Câu 11: Liệt kê không trùng lặp thông tin mã khách hàng, họ và tên khách hàng của các khách hàng có địa chỉ là ‘Hải Châu’ đã từng thuê xê thuộc loại xe có mô tả là ‘Xe 24 chỗ’ hoặc các khách hàng từng thuê xe có thời gian nhận xe là 07/07/2020. Sắp xếp tăng dần theo mã khách hàng và giảm dần theo họ và tên khách hàng.
SELECT distinct K.MAKH, K.HoTenKH  
FROM KHACHHANG K JOIN HOPDONGTHUEXE H ON H.MaKH=K.MAKH
JOIN CHITIETHOPDONG C ON C.MAHOPDONG = H.MaHopDong
JOIN XECHOTHUE X ON X.MaXe = C.MaXe 
JOIN LOAIXE l ON l.MaLoaiXe = X.MaLoaiXe
WHERE (DiaChiKH = N'HAI CHAU' AND l.MoTa LIKE N'Xe 24 cho') OR C.NgayNhanXe = '2020-07-07'
ORDER BY K.MAKH ASC, K.HoTenKH DESC 
--Câu 1.12. Thống kê số lần được thuê của các xe mà xe đó có số ngày mượn lớn hơn 10 ngày gồm các thông tin mã xe, số lần thuê.
	SELECT MaXe, count (MaHopDong) as Solanthue 
	from  CHITIETHOPDONG 
	WHERE DATEDIFF(day, NgayNhanXe, NgayTraXe) > 10
	group by MaXe 
--Câu 1.13. Cho biết có bao nhiêu xe đã được đùng để cho thuê trong tổng số xe
SELECT COUNT(DISTINCT MaXe)
FROM CHITIETHOPDONG
--Câu 1.14. Liệt kê thông tin của những khách hàng đã từng thuê xe vào năm 2018 nhưng chưa từng thuê vào năm 2019
SELECT * FROM KHACHHANG
JOIN HOPDONGTHUEXE ON HOPDONGTHUEXE.MaKH = KHACHHANG.MaKH
JOIN CHITIETHOPDONG ON CHITIETHOPDONG.MaHopDong = HOPDONGTHUEXE.MaHopDong
WHERE YEAR(NgayNhanXe) = '2018' AND YEAR(NgayNhanXe) != '2019'

--Câu 15: Liệt kê họ và tên của khách hàng mà có từ hai hợp đồng thuê xe trở lên.
SELECT k.HoTenKH
FROM KHACHHANG k 
INNER JOIN HOPDONGTHUEXE h ON k.MaKH = h.MaKH
GROUP BY k.HoTenKH
HAVING COUNT(h.MaHopDong) > = 2
-- Câu 1.16. Cập nhật cột trạng thái hợp đồng thành ‘Bị hủy’ đối với những hợp đồng có trạng thái là ‘Chưa bắt đầu’ và có số tiền đặt cọc là 0
UPDATE HOPDONGTHUEXE
SET TrangThaiHopDong = N'Bi huy'
WHERE TrangThaiHopDong=N'Chua bat dau' AND SoTienDatCoc=0
-- Câu 17.Xóa những loại dịch vụ chưa từng được sử dụng trong bất kỳ một hợp đồng nào.
DELETE FROM LOAIDICHVU
WHERE MaLoaiDV NOT IN ( SELECT MaLoaiDV FROM CHITIETHOPDONG)
