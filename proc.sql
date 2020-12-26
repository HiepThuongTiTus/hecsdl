--1.Tạo thủ tục
CREATE PROC Tang_luong @PHAN_TRAM INT
AS
	DECLARE @Ty_le DECIMAL(3,1) = 1 + @PHAN_TRAM / 100
	UPDATE EMPLOYEES SET SALARY = SALARY * @Ty_le
GO
--Gọi thực hiện thủ tục
EXEC Tang_luong @PHAN_TRAM = 10
--2.Gọi thực hiện thủ tục: tạo login
USER sbc 
GO
EXEC sp_addlogin @loginname='hiep', @passwd='hiep123'
GO
--Gọi thực hiện thủ tục: Tạo user
USE HumanResource
GO
EXEC sp_adduser @loginame = 'tom', @name_in_db = 'tom'
GO

--Tạo thủ tục
CREATE PROC Tong @a int, @b int
AS
    --Khai báo biến
    DECLARE @Tong int
    --Tính tổng
    SET @Tong = @a + @b
    --In kết quả tổng
    PRINT CONCAT(N'Tổng của ', @a, N' và ', @b, N' là: ', @Tong)
GO
--Gọi thực hiện thủ tục
EXEC Tong 1, 2

--Tạo thủ tục
CREATE PROC Dem_nhan_vien @depid int
AS
    --Bỏ message (x row(s) affected)
    SET NOCOUNT ON
    --Khai báo biến
    DECLARE @Dem int
    --Đếm số nhân viên của phòng
    SELECT @Dem = COUNT(*)  FROM EMPLOYEES WHERE Department_id = @depid
    --In kết quả đếm được
    PRINT N'Tổng số nhân viên: ' + STR(@Dem)
GO
--Gọi thực hiện thủ tục
EXEC Dem_nhan_vien 80