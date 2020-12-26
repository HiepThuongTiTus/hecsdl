CREATE FUNCTION Hiepthuong(
	@So1 int,
	@So2 int
	)
RETURNS int
AS 
BEGIN 
	DECLARE @kq int
	SET @kq = @So1+@So2
	RETURN @kq
END

