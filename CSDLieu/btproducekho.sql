CREATE dbo.getALLCat
AS 
SELECT p.ProductName, p.Price, p.Amount FROM Products p
WHERE (p.Price < XXX) AND  (p.Amount>YYY) 
--2
CREATE PROCEDURE getAllProduct
@price INT ,@amount INT
AS
SELECT p.ProductName, p.Price, p.Amount from dbo.Products p
WHERE p.Price< @price and p.Amount> @amount

--1
CREATE PROCEDURE getCategory
@CategoryIdm INT ,@CategoryNamem NVARCHAR(30)
AS
 IF(SELECT c.CategoryId, c.CategoryName FROM Category c)
 WHERE @CategoryIdm  = c.CategoryId
 BEGIN
 SELECT -1;
 RETURN
 END
 ELSE
 BEGIN
 INSERT INTO Category c(c.CategoryId, c.CategoryName)
 VALUES(@CategoryIdm,@CategoryNamem)
 SELECT 1;
 RETURN
 END
 --1 THEM MOI SAN PHAM NEU TRUNG BANG 1 cua thay da giai
   CREATE PROCEDURE themDanhMuc
@id int,
@name nvarchar(255)
AS
IF EXISTS (SELECT * FROM Categories WHERE CategoryId = @id)
BEGIN
    SELECT -1;
    RETURN
END
ELSE
BEGIN
    INSERT INTO Categories(CategoryId, CategoryName)
    VALUES (@id, @name)
    SELECT 1;
    RETURN
END
 
 --2 cap nhat san pham theo produce
 CREATE PROCEDURE AddProduct
@ProductIdm INT ,@ProductNamem NVARCHAR(30), @price INT, @Amount INT, @CategoryId INT
AS
IF EXISTS (SELECT p.ProductId,p.ProductName, p.Price,p.Amount,c.CategoryId  FROM  Products p
 WHERE @ProductIdm  =  p.ProductId
 and EXISTS (SELECT * FROM Categories c WHERE c.CategoryId = @CategoryId)
BEGIN
    SELECT -1;
    RETURN
END)
ELSE
 BEGIN
	 INSERT INTO Products p(p.ProductId, p.ProductName,p.Price, p.Amount, p.CategoryId)
	 VALUES(@ProductIdm ,@ProductNamem,@price,@Amount,@CategoryId)
	 SELECT 1;
	 RETURN
 END
 --3 cap nhat khach hang
 CREATE PROCEDURE CapNhap
@CustomerId INT ,@CustomerName NVARCHAR(30)
AS
IF EXISTS (SELECT * FROM Customers)
 WHERE @CustomerId  =  CustomerId
 BEGIN
 SELECT -1;
 RETURN
END
ELSE
BEGIN
	 UPDATE Customers 
	 SET CustomerName  = @CustomerName;
	 SELECT 1;
	 RETURN
 END

 -----------------------------------baithanh
 CREATE PROCEDURE BaiTap7
@Id int,
@Name nvarchar(255),
@price int, 
@amount int,
@CateId int
AS
IF EXISTS (SELECT ProductId FROM Products WHERE ProductId=@Id)
BEGIN
  SELECT -1;
  RETURN 
END
ELSE IF EXISTS (SELECT CustomerId FROM Customers WHERE CustomerId=@Id)
BEGIN 
  SELECT -1;
  RETURN 
END
ELSE 
BEGIN
    INSERT INTO Products(ProductId,ProductName,Price,Amount,CategoryId)
VALUES (@Id,@Name,@price,@amount,@CateId)
    SELECT 1;
    RETURN
END
EXEC BaiTap7 15,N'Thanh',3546,46,10

 

CREATE PROCEDURE BaiTap8
@Id int,
@Name nvarchar(255)
AS
IF EXISTS (SELECT CustomerId FROM Customers WHERE CustomerId=@Id)
BEGIN
  SELECT -1;
  RETURN 
END
ELSE
BEGIN
UPDATE Customers SET CustomerName = @Name WHERE CustomerId = @Id
   SELECT 1;
    RETURN
END
EXEC BaiTap8 15,N'Thanh'

-------------------------------------------------------------------
CREATE PROCEDURE checkCursor
AS
BEGIN
    DECLARE @id INT
    DECLARE @total INT
    SET @total = 0
    --khai báo con trỏ
    DECLARE myCur CURSOR FOR
        SELECT ProductId FROM Products
    --
    OPEN myCur
    --lấy phần tử đầu tiên
    FETCH NEXT FROM myCur INTO @id
    --vòng lặp 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        --gán giá trị
        SET @total = @total + (SELECT Amount FROM Products WHERE ProductId = @id)
        --di chuyển con trỏ sang phần tử tiếp theo
        FETCH NEXT FROM myCur INTO @id
    END
    --đóng con trỏ
    CLOSE myCur
    --Giải phóng tài nguyên
    DEALLOCATE myCur

    SELECT @total AS TotalAmount

END

CREATE PROCEDURE conghaiso
@soA int,
@soB int
as begin
Print(@soA+@SoB)
end

exec conghaiso 1,4
go
---------------------------------------bt
--Thủ tục Thêm mới, chỉnh sửa, xóa cho các bảng: Order, OrderDetails, đúng
CREATE PROCEDURE AddOrders
@OrderId int,
@OrderDate datetime,
@CustomerId int,
@OrderStatus nvarchar(50),
@OrderNote nvarchar(500),
@ShipperId INT
AS
IF EXISTS (SELECT * FROM Orders WHERE OrderId = @OrderId)
BEGIN
    SELECT -1;
    RETURN
END
ELSE
BEGIN
    INSERT INTO Orders(OrderId, OrderDate,CustomerId,OrderStatus,OrderNote,ShipperId)
    VALUES (@OrderId,@OrderDate,@CustomerId,@OrderStatus,@OrderNote,@ShipperId)
    SELECT 1;
    RETURN
END

--Thủ tục Thêm mới OrderDetails đúng
CREATE PROCEDURE AddOrderDetails
@OrderId int,
@ProductId int,
@Amount int
AS
IF EXISTS (SELECT * FROM OrderDetails WHERE OrderId = @OrderId)
BEGIN
    SELECT -1;
    RETURN
END
ELSE
BEGIN
    INSERT INTO OrderDetails(OrderId, ProductId,Amount)
    VALUES (@OrderId,@ProductId ,@Amount)
    SELECT 1;
    RETURN
END
 --chỉnh sửa Order
 CREATE PROCEDURE EditOrder
@OrderId int,
@OrderDate datetime,
@CustomerId int,
@OrderStatus nvarchar(50),
@OrderNote nvarchar(500),
@ShipperId INT
AS
IF not EXISTS (SELECT * FROM Orders WHERE OrderId = @OrderID)
BEGIN
  SELECT -1;
  RETURN 
END
ELSE
BEGIN
UPDATE Orders SET CustomerId = @CustomerId WHERE OrderId = @OrderID
   SELECT 1;
    RETURN
END

 --chỉnh sửa OrderDetails đúng
 CREATE PROCEDURE EditOrderDetails
@OrderId int,
@ProductId int,
@Amount int
AS
IF not EXISTS (SELECT * FROM OrderDetails WHERE OrderId = @OrderId)
BEGIN
  SELECT -1;
  RETURN 
END
ELSE
BEGIN
UPDATE OrderDetails SET Amount=@Amount  WHERE OrderId = @OrderId
   SELECT 1;
    RETURN
END

drop PROCEDURE EditOrderDetails
go
exec EditOrderDetails 9,1,3

Select * from OrderDetails
go

--xóa Order
 CREATE PROCEDURE DeleteOrder
@OrderId int
AS
IF not EXISTS (SELECT * FROM Orders WHERE  OrderId = @OrderID)
BEGIN
  select -1 -- -1=error
  RETURN 
END
ELSE
BEGIN
DELETE FROM Orders WHERE OrderId = @OrderID
   SELECT 1; --1=0k
    RETURN
END
go

 --XÓA OrderDetails
 CREATE PROCEDURE DeleteOrderDetails
@OrderId int,
@ProductId int
AS
IF not EXISTS (SELECT * FROM OrderDetails WHERE OrderId = @OrderId)
BEGIN
  SELECT -1;
  RETURN 
END
ELSE
BEGIN
DELETE FROM OrderDetails WHERE OrderId = @OrderId
   SELECT 1;
    RETURN
END
go
--Xóa tất cả đơn hàng mà sản phẩm có tồn kho bằng XXX và thời gian đặt hàng trong năm YYY
--Với XXX, YYY là các tham số đầu vào. Sau khi xóa thì hiển thị tổng số bảng ghi bị xóa.

  CREATE PROCEDURE deleteEOrders
  @OrderId INT,
  @CustomerId int,
  @ShipperId int,
  @ProductId int,
  @tonkho int,
  @tgdathang  datetime
AS
IF not EXISTS (SELECT o.OrderId,c.CustomerId,s.ShipperId,p.ProductId  FROM  Orders o
INNER JOIN Customers c ON o.CustomerId=c.CustomerId
INNER JOIN Shippers s ON s.ShipperId= o.ShipperId
INNER JOIN OrderDetails d ON d.OrderId=o.OrderId
INNER JOIN Products p ON p.ProductId=d.ProductId
 WHERE @OrderId  =  o.OrderId)
 BEGIN
  select -1 -- -1=error
  RETURN 
END
ELSE
 BEGIN
	 DELETE FROM Orders
	 WHERE EXISTS
	 (
	 SELECT *FROM Products p
	 inner join OrderDetails o ON o.ProductId=p.ProductId
	 Where (p.Amount - o.Amount = @tonkho) AND (Orders.OrderDate =  @tgdathang)
	 )
	 SELECT 1;
	 RETURN
END
BEGIN
    DECLARE @totaltk INT
    SET @totaltk = 0
    DECLARE myCur CURSOR FOR
        SELECT ProductId FROM Products
    OPEN myCur
    FETCH NEXT FROM myCur INTO @totaltk
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totaltk = @totaltk + (SELECT Amount FROM Products WHERE ProductId = @totaltk)
        FETCH NEXT FROM myCur INTO @totaltk
    END
    CLOSE myCur
    DEALLOCATE myCur
    SELECT @totaltk AS TotalAmount
 END
go
------------------------------------------------------------------------------------
--duyet ds orderdetail
CREATE PROCEDURE checkCursor
AS
BEGIN
	DECLARE @Amount int
    DECLARE @totalSP INT
    SET @totalSP = 0
    --khai báo con trỏ
    DECLARE myCur CURSOR FOR
        SELECT  Amount FROM  Orderdetail
    --
    OPEN myCur
    --lấy phần tử đầu tiên
    FETCH NEXT FROM myCur INTO@Amount
    --vòng lặp 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        --gán giá trị
        SET @total = @total + (SELECT Amount FROM Orderdetail WHERE  Amount = @ Amount)
        --duy chuyển con trỏ sang phần tử tiếp theo
        FETCH NEXT FROM myCur INTO @Amount
    END
    --đóng con trỏ
    CLOSE myCur
    --Giải phóng tài nguyên
    DEALLOCATE myCur
    SELECT @total AS TotalAmount
END

---------------------------------------------------------------
--2

CREATE PROCEDURE getAddress
@address NVARCHAR(30)
AS
SELECT c.CustomerId,c.CustomerName,c.Address,c.Phone FROM Customers c
WHERE c.Address like @address

--3
CREATE PROCEDURE getBT3
@Solan INT
AS
SELECT ProductName,Price,p.Amount, CategoryId FROM Products p
LEFT JOIN OrderDetails o ON p.ProductId= o.ProductId
Group by ProductName, Price, p.Amount, CategoryId 
HAVING COUNT (o.ProductId) < @Solan
--4 
CREATE PROCEDURE getBT4
@TrangThai VARCHAR(30)
AS
SELECT  d.CustomerId,d.CustomerName,c.OrderId FROM Orders c
WHERE c.OrderStatus = @TrangThai 

--5
CREATE PROCEDURE getBT5
@NgayBatDau VARCHAR(30), @NgayKetThuc VARCHAR(30)
AS
SELECT  d.CustomerId,d.CustomerName,c.OrderId FROM Orders c
WHERE o.OrderDate BETWEEN @NgayBatDau AND @NgayKetThuc

