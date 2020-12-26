CREATE TABLE NHANVIEN
(
	MaNV NVARCHAR(30) NOT NULL PRIMARY KEY,
	TenNV NVARCHAR(30),
	Email NVARCHAR(30),
	SoDT VARCHAR(30),
	DiaChi VARCHAR(30),
	Tinhtrang VARCHAR(30),
)

CREATE TABLE THANHTOAN
(
	MaTT VARCHAR(30) NOT NULL PRIMARY KEY,
	PhuongThucTT  VARCHAR(30)
)

CREATE TABLE HOADON
(
	MaHD NVARCHAR(30) NOT NULL PRIMARY KEY,
	MaNV NVARCHAR(30),
	MaTT VARCHAR(30),
	NgayHD NVARCHAR(30)

	FOREIGN KEY (MaTT) REFERENCES THANHTOAN(MaTT),
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

CREATE TABLE LOAIHANG
(
	MaLH NVARCHAR(30) NOT NULL PRIMARY KEY,
	TenLoaiHang NVARCHAR(30) NOT NULL,
	MoTa NVARCHAR(30) NOT NULL
)

CREATE TABLE MATHANG
(
	MaMH NVARCHAR(30) NOT NULL PRIMARY KEY,
	MaLH NVARCHAR(30) NOT NULL,
	TenSP NVARCHAR(30) NOT NULL,
	GiaTien FLOAT,
	SoLuong INT,
	XuatXu NVARCHAR(30)

	FOREIGN KEY (MaLH) REFERENCES LOAIHANG(MaLH)
)

CREATE TABLE CHITIETDONHANG
(
	MaHD NVARCHAR(30) NOT NULL,
	MaMH NVARCHAR(30) NOT NULL,
	SoLuong INT,
	ThanhTien FLOAT
	PRIMARY KEY (MaHD, MaMH),
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	FOREIGN KEY (MaMH) REFERENCES MATHANG(MaMH)
)
CREATE TABLE NCC
(
	MaCT NVARCHAR(30) NOT NULL PRIMARY KEY
)
--4.1 Bổ sung giá trị mặc định bằng 1 cho cột SOLUONG và bằng 0 cho cột MUCGIAMGIA trong bảng CHITIETDONHANG
ALTER TABLE CHITIETDONHANG
ADD
CONSTRAINT df_chitiet_soluong
DEFAULT(1) FOR Soluong,
CONSTRAINT df_chitiet_mucgiamgia
DEFAULT(0) FOR Mucgiamgia
--4.2 Bổ sung cho bảng DONDATHANG ràng buộc kiểm tra ngày giao hàng và ngày chuyển hàng phải sau hoặc bằng với ngày đặt hàng.

ALTER TABLE DONDATHANG
ADD
CONSTRAINT df_dondathang_ngay
CHECK  (ngaygiaohang >= ngaydathang AND ngaychuyenhang>=ngaydathang)

--4.3.Bổ sung ràng buộc cho bảng NHANVIEN để đảo bảo rằng một nhân viên chỉ có thể làm việc trong công ty khi đủ 18 tuổi và không quá 60 tuổi.
ALTER TABLE nhanvien
ADD
CONSTRAINT chk_nhanvien_ngaylamviec
CHECK (DATEDIFF(yy, ngaysinh,ngaylamviec) BETWEEN 18 AND 60)

--5.1. Tạo thủ tục lưu trữ để thông qua thủ tục này có thể bổ sung thêm một bản ghi mới cho bảng MATHANG
--(thủ tục phải thực hiện kiểm tra tính hợp lệ của dữ liệu cần bổ sung, không trùng khóa chính và đảm bảo toàn vẹn tham chiếu).

	CREATE PROC sp_mh
	(
		@MaMH NVARCHAR(30),
		@TenSP NVARCHAR(30) NOT NULL,
		@GiaTien FLOAT,
		@SoLuong INT,
		@XuatXu NVARCHAR(30),
		@MaLH NVARCHAR(30) NOT NULL,
		@MaCT NVARCHAR(30)
	)
	AS
	IF NOT EXISTS ( SELECT MaMH FROM MATHANG WHERE MaMH = @MaMH)
	IF(@MaCT IS NULL OR EXISTS(SELECT @MaCT FROM NCC 
	WHERE MaCT = @MaCT))
	AND 
	(@MaLH IS NULL OR EXISTS (SELECT MaLH FROM LOAIHANG WHERE MaLH = @MaLH))
	INSERT INTO MATHANG
	VALUES(@MaMH,@TenSP,@GiaTien,@SoLuong,@XuatXu,@MaLH,@MaCT)
exec sp_mh '005','Bom B52','ct03',2,34,'VND',$500000

--5.2. Tạo thư mục lưu trữ có chức năng thống kê tổng số lượng hàng bán được của một mặt hàng có mã bất kỳ(mã mặt hàng cần thống kê là tham số của thủ tục).
CREATE PROCEDURE sp_thongkedonhang(@MAHANG NVARCHAR(30)) 
AS
SELECT MATHANG.MaMH, TenSP, SUM(CHITIETDONHANG.SoLuong) AS tongsoluong
FROM MATHANG m
LEFT JOIN CHITIETDONHANG c ON m.MaMH = c.MaMH
WHERE MATHANG.MaMH = @MAHANG
GROUP BY MATHANG.MaMH, TenSP

--c2.
Create PROCEDURE sp_thongkebanhang(@mahang NVARCHAR(10))

      AS

            SELECT mathang.mahang,tenhang,

                   SUM(chitietdathang.soluong) AS 'Tong so luong'

            FROM mathang LEFT JOIN chitietdathang

                  ON mathang.mahang=chitietdathang.mahang

            WHERE mathang.mahang=@mahang

            GROUP BY mathang.mahang,tenhang
			exec sp_thongkebanhang '001'

an> EXISTS(SELECT macongty
                              FROM nhacungcap

                              WHERE macongty=@macongty))

                        AND

                              (@maloaihang IS NULL OR

                              EXISTS(SELECT maloaihang FROM loaihang

                              WHERE maloaihang=@maloaihang))     

                        INSERT INTO mathang

                        VALUES(@mahang,@tenhang,

                                @macongty,@maloaihang,

                                @soluong,@donvitinh,@giahang)

 

exec sp_insert_mathang '005','Bom B52','ct03',2,34,'VND',$500000

--5.3. Viết hàm trả về một bảng trong đó cho biết tổng số lượng hàng bán của mỗi mặt hàng.
--Sử dụng hàng này thống kê xem tổng số lượng hàng(hiện có và đã làm) của mỗi mặt hàng là bao nhiêu.
CREATE FUNCTION func_banhag()
RETURNS TABLE 
AS
RETURN (SELECT MATHANG.MaMH,TenSP, CASE WHEN  SUM(CHITIETDONHANG.SoLuong) IS NULL THEN 0
ELSE  SUM(CHITIETDONHANG.SoLuong)
END AS tongsl
FROM MATHANG  m
LEFT JOIN CHITIETDONHANG c ON c.MaMH=m.MaMH
GROUP BY MATHANG.MaMH, TenSP

--Ham chinh nghia
SELECT a.MAHANG, a.TenSP, Soluong + tongsl FROM MATHANG 
AS a INNER JOIN dbo.func_banhang() AS b ON a.MaMH=b.MaMH

--5.4 Viết trigger cho bảng CHITIETDATHANG theo yêu cầu sau:
--Khi một bản ghi mới được bổ sung vào bảng này thì giảm số lượng hàng hiện có, nếu số lượng hàng hiện có lớn hơn 
--hoặc bằng số lượng hàng được bán ra.Ngược lạ thì hủy bỏ thao tác bổ sung.
--c1.
create trigger trg_chitietdathang_insert

on chitietdathang

for insert

as

begin

declare @mahang nvarchar(10)

declare @soluongban int

declare @soluongcon int

select @mahang=mahang, @soluongban=soluong

from inserted

select @soluongcon=soluong from mathang

where mahang=@mahang

if @soluongcon>=@soluongban

update mathang set soluong=soluong-@soluongban

where mahang=@mahang

else

rollback transaction

end
--Khi cập nhật lại số lượng hàng được bán, kiểm tra số lượng hàng được cập nhật lại có phù hợp hay không
--(số lượng hàng bán ra không được vượt quá số lượng bán hiện có và không được nhỏ hơn 1). nếu dữ liệu hợp lệ thì giảm(hoặc tăng), số lượng hàng hện có trong công ty, ngược lại thì huỷu bỏ thao tác cập nhật.
create trigger trg_chitietdathang_update

on chitietdathang

for update

as

if update(soluong)

begin

if exists(select sohoadon from inserted where soluong<0)

rollback transaction

else       

begin

update mathang

set soluong=soluong-

(select sum(inserted.soluong-deleted.soluong)

from inserted INNER JOIN deleted

on inserted.sohoadon=deleted.sohoadon AND

inserted.mahang=deleted.mahang

where inserted.mahang=mathang.mahang

group by inserted.mahang)

where mahang in (select DISTINCT mahang

                                 from inserted)

if exists(select mahang from mathang

where soluong<0)

rollback transaction

end

end

--c2.
CREATE TRIGGER trg_chitietdathang_insert
ON CHITIETDONHANG
FOR INSERT 
AS 
BEGIN
DECLARE @MaMH NVARCHAR(30)
DECLARE @Soluongban INT
DECLARE @Soluongcon INT
SELECT @MaMH = MaMH, @Soluongban=soluong FROM inserted
SELECT @Soluongcon= soluong FROM MATHANG
WHERE MaMH = @MaMH
IF @Soluongcon>=@Soluongban
UPDATE MATHANG SET SoLuong = SoLuong - @Soluongban
WHERE MaMH=@MaMH
ELSE
ROLLBACK TRANSACTION
END

CREATE TRIGGER trg_CHITIETDONHANG_update_Soluong 
ON CHITIETDONHANG
FOR UPDATE
AS
IF UPDATE(SoLuong)
BEGIN
IF EXISTS( SELECT MaHD FROM inserted WHERE soluong <0)
ROLLBACK TRANSACTION
ELSE 
BEGIN
IF EXISTS(SELECT MaHD FROM inserted WHERE SoLuong<0)
ROLLBACK TRANSACTION
ELSE
BEGIN UPDATE MATHANG
SET SoLuong= SoLuong-(SELECT SUM(inserted.soluong-deleted.soluong)
FROM inserted INNER JOIN deleted
ON inserted.MaHD = deleted.MaHD AND inserted.MaMH = deleted.MaMH
WHERE inserted.MaMH = MATHANG.MaMH
GROUP BY inserted.MaMH)
WHERE MaMH IN(SELECT DISTINCT MaMH FROM inserted)
IF EXISTS (SELECT MaMH FROM MATHANG WHERE SoLuong<0)
ROLLBACK TRANSACTION
END
END



--5.5. Viết trigger cho bảng CHITIETDATHANG sao cho chỉ chấp nhận giá hàng bán ra phải nhỏ hơn hoặc bàng giá gốc(giá của mặt hàng trong bảng MATHANG)
CREATE  TRIGGER trg_CHITIETDH_giaban
ON CHITIETDONHANG
FOR INSERT, UPDATE
AS
IF UPDATE(giaban) 
	IF EXISTS(SELECT inserted.MaMH FROM MATHANG 
	INNER JOIN inserted ON MATHANG.MaMH= inserted.MaMH
WHERE MATHANG.GiaTien>inserted.giaban)
ROLLBACK TRANSACTION
