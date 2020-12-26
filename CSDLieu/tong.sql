DECLARE @price DECIMAL(18,0)
DECLARE @total DECIMAL(18,0)
DECLARE @counter INT
SET @total=0
SET @counter = 0

--1. Khai báo  cursor tính giá tiền trung bình của các sản phẩm có ProductId trong khoảng(1-3)
DECLARE cur1 CURSOR FOR
SELECT Price FROM Products
WHERE ProductId > 1 AND ProductId <= 3
--2. Open
OPEN cur1
--3. Tro vao index 0
FETCH NEXT FROM cur1
INTO @price
--4. Duyệt qua các phan tu cua Cursor
WHILE @@FETCH_STATUS=0
BEGIN
--Xử lý 
SET @total += @price
SET @counter +=1

--do anything if you want 


--5. Lấy phần tử tiếp theo
FETCH NEXT FROM cur1
INTO @price
END

--6. close cursor
CLOSE cur1
DEALLOCATE cur1
IF @counter = 0
BEGIN
SELECT 0 AS GiaTrungBinh
END
ELSE
BEGIN
SELECT @total /@counter AS GiaTrungBinh
END


