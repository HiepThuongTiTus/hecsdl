CREATE FUNCTION DEMki(
	@number1 NVARCHAR(30)
	)
RETURNS NVARCHAR(30)
AS 
BEGIN 
	RETURN LEN(@number1)
END

