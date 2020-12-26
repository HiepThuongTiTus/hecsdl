--Viết hàm đọc điểm 1 chữ số thập phân ra thành chữ tương ứng 
CREATE FUNCTION DOC_DIEMTP(@Diemtp numeric(4,1))
RETURNS NVARCHAR(30)
AS
BEGIN
	DECLARE @pn tinyint,@ptp tinyint, @kq NVARCHAR(20)
	SET @pn = FLOOR(@Diemtp)
	SET @ptp = (@Diemtp*10)%10
	SET @kq= dbo.DOC_DIEMTP(@pn)+N'phẩy'+dbo.DOC_DIEMTP(@ptp)
RETURN @kq
END
--Tính điểm tb chung của sv có mã học kì bất kì
CREATE FUNCTION DIEM_SV(@MaSV NVARCHAR(11), @Hocky CHAR(2))
RETURNS numeric(4,1)
BEGIN 
DECLARE @DiemTBC numeric(4,1)
IF NOT EXISTS(SELECT *FROM DIEMHP WHERE MaSV = @MaSV)
RETURN 0
ELSE 
SET @DiemTBC=(SELECT SUM(DiemHP*Sodvht)/SUM(Sodvht)
FROM DMHOCPHAN INNER JOIN DIEMHP ON DMHOCPHAN.MaHP = DIEMHP.MaHP
WHERE HocKy = @HocKy AND MaSV = @MaSV)
RETURN @DiemTBC
END

--viet ham TACHHODEM dung de tach ho dem tu chuoi ho ten
CREATE FUNCTION TACHHODEM(@ht NVARCHAR(30))
RETURNS NVARCHAR(30)
AS
BEGIN
DECLARE @hodem NVARCHAR(30), @L INT, @i INT, @j INT, @kt NVARCHAR(30)
SET @L = LEN(@ht)
SET @i = 1
WHILE @i>=@L
BEGIN
SET @kt=SUBSTRING(@ht,@i,1)
IF @kt='' SET @j=@i
SET @i=@i-1
END
SET @hodem=SUBSTRING(@ht,@j-1,10)
RETURN @hodem
END
--