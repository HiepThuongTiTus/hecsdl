DECLARE @id INT
DECLARE @name NVARCHAR(255)
DECLARE @price DECIMAL(18,0)

--1. Khai báo 
DECLARE myCur CURSOR FOR
SELECT ProductId, ProductName, Price FROM Products
--2. Open
OPEN myCur
--3. Tro vao index 0
FETCH NEXT FROM myCur
INTO @id, @name, @price
--4. Duyệt qua các phan tu cua Cursor
WHILE @@FETCH_STATUS=0
BEGIN
--Xử lý 
--do anything if you want 
print @name
print '\n'
print '---------'
print '\n'

--5. Lấy phần tử tiếp theo
FETCH NEXT FROM myCur
INTO @id, @name, @price
END

--6. close cursor
CLOSE myCur

--7.Release cursor
DEALLOCATE myCur