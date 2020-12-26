DECLARE @i INT
SET @i = 10
SELECT @i

--vd2
DECLARE @k INT
DECLARE @j INT
DECLARE @total INT
SET @k = 10
SET @j = 20
SET @total = @k + @j
SELECT @total

--vd3
--sua vao category 
DECLARE @pId INT
SET @pId=(SELECT TOP 1 ProductId FROM Products)
--SELECT @pId AS ProductId 

--theo bang 
SELECT *FROM Products WHERE ProductId = @pId

--vd3: if else
SET @j=8
If @i < @j
Begin 
	Set @total = @j - @i
End
Begin 
	Set @total = @i - @j
End

--vd
DECLARE @pId INT
SET @pId =10
If EXISTS (SELECT* FROM Products WHERE ProductId=@pId)
BEGIN
--do update
END
ELSE 
BEGIN
--do insert
END

--vd
DECLARE @p INT
DECLARE @s INT
DECLARE @total1 INT
SET @p = 10
SET @s = 20

SELECT CASE @i
WHEN 10 THEN N'Muoi'
WHEN 20 THEN N'Hai Muoi'
ELSE N'Khong'
ENS

--WHILE
DECLARE @y Int
DECLARE @r Int
DECLARE @total3 Int
	SET @y=10
	SET @r=5
WHILE @y > @r
BEGIN 
	SET @y = @y-1
	print 'abc'
END

--keyword
--DECLARE
--SET
--IF...ELSE
--BEGIN...END
--CASE WHEN THEN ELSE END
--WHILE

