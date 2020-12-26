CREATE TABLE PHICONG 
(
	MaPC VARCHAR(30) NOT NULL PRIMARY KEY,
	TenPC VARCHAR(30),
	TrinhDo VARCHAR(30),
	NamKN INT
)

CREATE TABLE LOAIMAYBAY
(
	MaLoai VARCHAR(30) NOT NULL PRIMARY KEY,
	LoaiMB VARCHAR(30),
	DongCo VARCHAR(30),
	TocDoToiThieu VARCHAR(30),
	TocDoToiDa VARCHAR(30)
)

CREATE TABLE MAYBAY
(
	SoHieuMB VARCHAR(30) NOT NULL PRIMARY KEY,
	MaLoai VARCHAR(30),
	NgayBatDauSD DATETIME
	FOREIGN KEY (MaLoai) REFERENCES LOAIMAYBAY(MaLoai)
)

CREATE TABLE LICHTRINHBAY
(
	MaLT VARCHAR(30) NOT NULL PRIMARY KEY,
	SoHieuMB VARCHAR(30),
	MaPC VARCHAR(30),
	NoiDi VARCHAR(30),
	NoiDen VARCHAR(30),
	ThoiGianDi SMALLDATETIME,
	ThoiGianDen SMALLDATETIME

	FOREIGN KEY (SoHieuMB) REFERENCES MAYBAY(SoHieuMB),
	FOREIGN KEY (MaPC) REFERENCES PHICONG (MaPC)
)

INSERT INTO LOAIMAYBAY VALUES('L01','Boeing 747','tuoc bin canh quat','1000 km/h', '3000km/h')
INSERT INTO LOAIMAYBAY VALUES('L02','A321','tuoc bin phan luc','1500 km/h', '3200km/h')
INSERT INTO LOAIMAYBAY VALUES('L03','Boeing 747','tuoc bin roc ket','1100 km/h', '2500km/h')

INSERT INTO MAYBAY VALUES('VN01','L01','2015/05/20')
INSERT INTO MAYBAY VALUES('JS02','L01','2015/0/21')
INSERT INTO MAYBAY VALUES('AS01','L02','2015/05/22')

INSERT INTO PHICONG VALUES('PC01','Tran Dinh Nam','Co Pho',3)
INSERT INTO PHICONG VALUES('PC02','jonh henry','Co Truong',8)

INSERT INTO LICHTRINHBAY VALUES('LT001','VN01','PC02','Ha Noi','Da Nang','2015/05/20 14:00', '2015/05/20 16:00')
INSERT INTO LICHTRINHBAY VALUES('LT002','AS01','PC01','Da Nang','Thai Lan','2015/04/13 08:00', '2015/04/13 13:00')

--1a.Tạo khung nhìn có tên là V_MayBay để thấy được thông tin của tất cả máy bay có tốc
--độ tối thiểu lớn hơn 1100km/h và được bắt đầu sử dụng từ ngày 01/01/2014. (
CREATE VIEW V_MayBay 
as
SELECT MAYBAY.SoHieuMB, MAYBAY.MaLoai, MAYBAY.NgayBatDauSD, LOAIMAYBAY.TocDoToiThieu FROM MAYBAY
INNER JOIN LOAIMAYBAY ON MAYBAY.MaLoai = LOAIMAYBAY.MaLoai
WHERE (LOAIMAYBAY.TocDoToiThieu > '1000 km/h') AND (NgayBatDauSD = '2014/01/01')

--1b.Thông qua khung nhìn V_MayBay thực hiện việc cập ngày bắt đầu sử dụng thành
--01/31/2014 đối với những máy bay có ngày bắt đầu sử dụng là 02/28/2014
UPDATE V_MayBay
SET NgayBatDauSD = '2014/01/31' WHERE NgayBatDauSD = '2014/02/28'
--Câu 2: Tạo 2 thủ tục (Stored Procedure):
--a. Thủ tục Sp_1: Dùng để xóa thông tin của những phi công có mã phi công được truyền
--vào như một tham số của thủ tục.
CREATE proc Sp_1
(
	@MaPC NVARCHAR(50) 
)
AS
BEGIN
	DELETE FROM PHICONG WHERE MaPC=@MaPC
END
--b.Thủ tục Sp_2: Dùng để bổ sung thêm bản ghi mới vào bảng LICHTRINHBAY (Sp_2
--phải thực hiện kiểm tra tính hợp lệ của dữ liệu được bổ sung là không trùng khóa
--chính và đảm bảo toàn vẹn tham chiếu đến các bảng có liên quan). 
CREATE proc Sp_2
(
	@MaLT VARCHAR(30),
	@SoHieuMB VARCHAR(30),
	@MaPC VARCHAR(30),
	@NoiDi VARCHAR(30),
	@NoiDen VARCHAR(30),
	@ThoiGianDi SMALLDATETIME,
	@ThoiGianDen SMALLDATETIME
)
AS 
BEGIN
	IF EXISTS (SELECT SoHieuMB FROM MAYBAY WHERE SoHieuMB=@SoHieuMB)
	AND EXISTS (SELECT MaPC FROM PHICONG WHERE MaPC = @MaPC)
	BEGIN 
		IF EXISTS (SELECT SoHieuMB FROM LICHTRINHBAY WHERE SoHieuMB=@SoHieuMB)
			BEGIN
				PRINT 'Đã trùng dữ liệu từ db!'
				rollback tran
			END
			else insert into LICHTRINHBAY values(@MaLT,@SoHieuMB,@MaPC,@NoiDi,@NoiDen,@ThoiGianDi,@ThoiGianDen)
		end
		ELSE 
			BEGIN
				PRINT 'Không tồn tại đơn hàng hoặc sản phẩm update!'
				rollback tran
			END
	END
END

EXEC SP_2 'LT001','VN01','PC02', 'Ha Noi','Da Nang','2015/05/20 14:00', '2015/05/20 16:00'
--Câu 3: Viết 2 bẫy sự kiện (trigger) cho bảng LICHTRINHBAY theo yêu cầu sau:
--a. Trigger_1: Khi thực hiện thêm một lịch trình bay cho một máy bay bất kỳ thì kiểm
--tra dữ liệu nơi đi phải khác nơi đến, nếu không hợp lệ thì hiển thị thông báo "Dữ liệu
--nơi đi phải khác nơi đến của cùng một chuyến bay" và quay lui (rollback) giao tác.
--Bẫy sự kiện chỉ xử lý 1 bản ghi.
--c1
CREATE TRIGGER trig_1
ON LICHTRINHBAY
FOR INSERT
AS
BEGIN
	DECLARE @SoHieuMB NVARCHAR(30)
	DECLARE @NoiDi VARCHAR(30)
	DECLARE @NoiDen VARCHAR(30)
	SELECT @NoiDi = inserted.NoiDi FROM inserted
	SELECT @NoiDen = inserted.NoiDen FROM inserted
	SELECT @SoHieuMB = inserted.SoHieuMB FROM inserted
	begin transaction;

	IF EXISTS (SELECT SoHieuMB FROM MAYBAY WHERE SoHieuMB=@SoHieuMB)
	BEGIN 
		IF EXISTS (SELECT SoHieuMB FROM LICHTRINHBAY WHERE @NoiDen=@NoiDi)
			BEGIN
				PRINT 'Dữ liệu nơi đi phải khác nơi đến của cùng một chuyến bay'
				rollback tran
			END
		ELSE 
			BEGIN
				PRINT 'rollback'
				rollback tran
			END
	END
END
--c2
CREATE TRIGGER triger_1
ON LICHTRINHBAY
AFTER INSERT
AS
BEGIN 
	DECLARE @SoHieuMB NVARCHAR(30)
	DECLARE @NoiDi VARCHAR(30)
	DECLARE @NoiDen VARCHAR(30)
	SELECT @NoiDi =NoiDi FROM inserted
	SELECT @NoiDen =NoiDen FROM inserted
	SELECT @SoHieuMB =SoHieuMB FROM inserted
	begin transaction;

	IF EXISTS (SELECT SoHieuMB FROM MAYBAY WHERE SoHieuMB=@SoHieuMB)
	BEGIN 
		IF EXISTS (SELECT SoHieuMB FROM LICHTRINHBAY WHERE @NoiDen=@NoiDi)
			BEGIN
				PRINT 'Đã trùng dữ liệu từ db!'
				rollback tran
			END
		ELSE 
			BEGIN
				PRINT 'Dữ liệu nơi đi phải khác nơi đến của cùng một chuyến bay'
				rollback tran
			END
	END
END

--b. Trigger_2: Khi cập nhập lại thời gian đi (tức là thời gian cất cánh), kiểm tra thời gian
--cập nhật có phù hợp hay không (thời gian đi phải nhỏ hơn thời gian đến). Nếu dữ liệu
--hợp lệ thì cho phép cập nhật, nếu không hiển thị thông báo "thời gian đi phải nhỏ hơn
--thời gian đến ít nhất là 30 phút" và thực hiện quay lui giao tác
--C1
CREATE TRIGGER trig_2
ON LICHTRINHBAY
FOR UPDATE
AS
BEGIN
	DECLARE @ThoiGianDi SMALLDATETIME
	DECLARE @ThoiGianDen SMALLDATETIME
	SELECT @ThoiGianDi=inserted.ThoiGianDi from inserted
	SELECT @ThoiGianDen=inserted.ThoiGianDen from inserted
	begin transaction;
	IF(@ThoiGianDi<@ThoiGianDen) 
	UPDATE LICHTRINHBAY SET ThoiGianDi=@ThoiGianDi
	ELSE
	BEGIN
		PRINT 'thời gian đi phải nhỏ hơn thời gian đến ít nhất là 30 phút'
		rollback tran
	END
END
--C2
CREATE TRIGGER triger_2
ON LICHTRINHBAY
FOR UPDATE
AS
BEGIN
	DECLARE @ThoiGianDi SMALLDATETIME
	DECLARE @ThoiGianDen SMALLDATETIME
	SELECT @ThoiGianDi=ThoiGianDi from inserted
	SELECT @ThoiGianDen=ThoiGianDen from inserted
	begin transaction;
	IF(@ThoiGianDi<@ThoiGianDen) 
	UPDATE LICHTRINHBAY SET ThoiGianDi=@ThoiGianDi
	ELSE
	BEGIN
		PRINT 'thời gian đi phải nhỏ hơn thời gian đến ít nhất là 30 phút'
		rollback tran
	END
END

--4. Tạo hàm do người dùng định nghĩa (user-defined function) để tính chi phí bảo trì
--cho cả năm 2015. Mã máy bay sẽ được truyền vào thông qua tham số đầu vào của hàm. Cụ
--thể như sau:
-- Nếu tổng số lần bay của máy bay dưới 25 lần, thì kết quả là chi phí bảo trì được trả
--5.000.000 trên mỗi tháng trong năm
--Nếu tổng số lần bay của máy bay từ 25 lần trở lên, thì kết quả là chi phí bảo trì được
--trả 10.000.000 trên mỗi tháng trong năm
CREATE FUNCTION ser_defined(@SoHieuMB NVARCHAR(30))
RETURNS nVARCHAR(50)
AS 
BEGIN
	DECLARE @Notice NVARCHAR(50)
	IF EXISTS (SELECT MAYBAY.SoHieuMB FROM MAYBAY 
	INNER JOIN  LICHTRINHBAY ON MAYBAY.SoHieuMB=LICHTRINHBAY.SoHieuMB
	WHERE (MAYBAY.SoHieuMB = @SoHieuMB)
	AND YEAR(ThoiGianDi)=2015 
	GROUP BY MAYBAY.SoHieuMB 
	HAVING SUM(LICHTRINHBAY.MaLT)>25)
	begin
		set @Notice = 'Chi phí bảo trì được nhận 10.000.000'
	end
	else
	begin
		set @Notice ='Chi phí bảo trì được nhận 5.000.000'
	end
	return @Notice
end

--5.Tạo thủ tục Sp_PhiCong tìm những phi công đã từng thực hiện lái một chuyến bay
--bất kỳ (nghĩa là có lưu trữ thông tin của phi công trong bảng LICHTRINHBAY) để xóa
--thông tin về những phi công đó trong bảng PHICONG và xóa thông tin về những
--chuyến bay của những phi công đó (tức là phải xóa những bản ghi trong bảng
--LICHTRINHBAY có liên quan).
CREATE proc Sp_PhiCong 
AS
BEGIN 
	begin tran deletepro;
	DECLARE contro cursor FOR 
	SELECT MaPC, MaLT FROM LICHTRINHBAY
	open contro
	DECLARE @mapc NVARCHAR(30)
	DECLARE @malt NVARCHAR(30)

	FETCH NEXT FROM contro
	into @masp, @malt 
	WHILE @@FETCH_STATUS=0
	BEGIN
		DELETE FROM LICHTRINHBAY
		IF @@ERROR!=0
			BEGIN
			print 'rollback';
				rollback tran deletepro
			end

		DELETE FROM PHICONG WHERE PHICONG.MaPC= @mapc

		IF @@ERROR!=0
			BEGIN
			print 'rollback';
				rollback tran deletepro
			end

		DELETE FROM LICHTRINHBAY WHERE LICHTRINHBAY.MaLT= @malt

		if @@ERROR !=0
			begin 
				print 'rollback';
				rollback tran deletepro
			end

		FETCH NEXT FROM contro
		INTO @mapc, @malt
	end
	close contro
	deallocate contro

	commit tran deletepro;

end
exec Sp_PhiCong
