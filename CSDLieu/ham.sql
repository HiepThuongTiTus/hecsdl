CREATE FUNCTION demDonHang()
RETURNS int 
AS
BEGIN
DECLARE @total INT
SET @total = 0;

SET @total= (SELECT COUNT(OrderId) FROM Orders)
RETURN @total
END

SELECT dbo.demDonHang() 
AS Soluong

 --dem san pham cho 1 danh muc
CREATE FUNCTION demSanPham(@CatId int)
RETURNS int 
AS
BEGIN
DECLARE @tot INT
SET @tot = 0;

SET @tot = (SELECT COUNT(ProductId) FROM Products WHERE CategoryId = @tot)
RETURN @tot
END

SELECT dbo.demSanPham(2)  
AS Soluongdh

--ham hien thi ten cua 1 khach hang co ma id bat ki, 
--sau dô goi ham nay trong truuy van hien thi ds don hang+ten khach hang tuong ung
create function hienthitenkh(@CusID int)
returns nvarchar(50)
begin
declare @tennhanvien nvarchar(50);
set @tennhanvien = (select CustomerName from Customers where CustomerId = @CusID);
return @tennhanvien
end
select *,dbo.CustomerName(CustomerId) as tennhanvien  from Orders


--dem so luong khach hang o dia chi xxx bat ky
create function DemOrder(@status NVARCHAR(30), @ThoigianBatDau DATETIME, @ThoigianKetThuc DATETIME)
returns INT
AS
begin
declare @dem INT
SET @dem = 0
set @dem = (select COUNT(*) from Orders o where o.OrderStatus= @status AND  O.OrderDate BETWEEN @ThoigianBatDau AND @ThoigianKetThuc);
 RETURN @dem
 END
 SELECT dbo.DemOrder('Da ket thuc' , '03-06-2020' , '08-10-2020' )
 
 --tong tien ban duoc cua 1 san pham bat ky
 create function Tongtien(@SPID INT)
 returns int
 as
 begin
 declare @sp INT
 set @sp = 0;
 set @sp = (select SUM(o.Amount*p.Price) from PRODUCTS p
 INNER JOIN OrderDetails o ON o.ProductId = p.ProductId
 where p.ProducId = @SPID);
 return @sp
 end

 SELECT dbo.TongTien(10)


    

-- BAI 4: Dem sl khach hang
CREATE FUNCTION Demkh(@address NVARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @count INT
SET @count = (
SELECT COUNT(*) FROM Customers c
WHERE c.Address = @address
)
RETURN @count
END
 
SELECT dbo.Demkh(N'Da Nang')
SELECT dbo.Demkh(N'Hai Phong')
--HANG TON KHO
CREATE FUNCTION SPtonkho()
RETURNS INT
AS BEGIN
DECLARE @SLTK INT
SET @SLTK = (
SELECT AVG(Amount) FROM Product 
)
RETURN @SLTK
END

--Viết hàm sử dụng Cursor, để đếm số lượng khách hàng đã mua 1 sản phẩm có mã X. Với X là tham số kiểu int
DECLARE @DemSL1 INT, @X INT
DECLARE Orders_Cursor CURSOR FOR (SELECT COUNT(*) FROM Orders o
INNER JOIN Customers c ON c.CustomerId=o.CustomerId
INNER JOIN OrderDetails d ON d.OrderId=o.OrderId
INNER JOIN Products p ON p.ProductId=d.ProductId
WHERE p.ProductId = @X)
OPEN Orders_Cursor
FETCH NEXT FROM Orders_Cursor INTO @DemSL1
WHILE @@FETCH_STATUS = 0 
BEGIN PRINT @DemSL1
FETCH NEXT FROM Orders_Cursor INTO @DemSL1
END
CLOSE Orders_Cursor
DEALLOCATE Orders_Cursor



