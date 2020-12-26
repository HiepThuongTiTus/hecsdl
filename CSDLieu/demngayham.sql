--c1
CREATE FUNCTION Doc1
		(@thu int) 
		RETURNS NVARCHAR(255)
		AS
		BEGIN
		DECLARE @xl2 NVARCHAR(255)

		IF @thu = 0
		BEGIN
			SET @xl2=N'Chu nhat'
		END

		IF @thu = 1
		BEGIN
			SET @xl2=N'Hai'
		END

		IF @thu = 2
		BEGIN
			SET @xl2=N'Ba'
		END

		IF @thu = 3
		BEGIN
			SET @xl2=N'Bốn'
		END

		IF @thu = 4
		BEGIN
			SET @xl2=N'Năm'
		END

		IF @thu = 5
		BEGIN
			SET @xl2=N'Sáu'
		END

		IF @thu = 6
		BEGIN
			SET @xl2=N'Bảy'
		END

RETURN @xl2
END

--kiem tra dung sai
declare @thu int
set @thu = 2
select dbo.Doc1(@thu)


