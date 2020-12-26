--c1
CREATE FUNCTION XEP1
(@Diemtb float) 
RETURNS NVARCHAR(30)
AS
BEGIN
DECLARE @xl NVARCHAR(30)
SET @xl = CASE
WHEN @Diemtb>=9 THEN N'Xuat sac'
WHEN 6<@Diemtb AND @Diemtb<9 THEN N'Gioi'
WHEN 4<@Diemtb AND @Diemtb<=6 THEN N'Kha'
ELSE N'Hoc lai'
END
RETURN @xl
END

--c2
CREATE FUNCTION XEP2
(@Diemtb float) 
RETURNS NVARCHAR(255)
AS
BEGIN
DECLARE @xl1 NVARCHAR(255)

IF @Diemtb>=9 
BEGIN
	SET @xl1=N'Xuat sac'
END

IF 6<@Diemtb AND @Diemtb<9  
BEGIN
	SET @xl1=N'Gioi'
END

IF 4<@Diemtb AND @Diemtb<=6 
BEGIN
	SET @xl1=N'Kha' 
END

IF 4>@Diemtb 
BEGIN
	SET @xl1=N'Hoc Lai' 
END
RETURN @xl1
END
--kiem tra dung sai
declare @Diemtb  float
set @Diemtb = 7
select dbo.XEP2(@Diemtb)


