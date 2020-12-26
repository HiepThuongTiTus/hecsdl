---------------------------------------bt
--Thủ tục Thêm mới, chỉnh sửa, xóa cho các bảng: Orders, OrderDetails

--Thủ tục Thêm mới Orders 
CREATE PROCEDURE Add_Orders
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
go
INSERT INTO OrderDetails(OrderId, ProductId,Amount)
--Thủ tục Thêm mới OrderDetails 
CREATE PROCEDURE Add_OrderDetails
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
go

 --chỉnh sửa Order
 CREATE PROCEDURE Edit_Orders
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
go

 --chỉnh sửa OrderDetails 
 CREATE PROCEDURE Edit_OrderDetails
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

drop PROCEDURE Edit_OrderDetails
go
exec Edit_OrderDetails 9,1,3

Select * from OrderDetails
go

--xóa Order
 CREATE PROCEDURE Delete_Order
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

--XOA tất cả đơn hàng mà sản phẩm có tồn kho bằng XXX và thời gian đặt hàng trong năm YYY
--Với XXX, YYY là các tham số đầu vào. Sau khi xóa thì hiển thị tổng số bản ghi bị xóa.

  CREATE PROCEDURE Del_EOrders
  @XXX INT,
  @YYY int
AS

 BEGIN

 SELECT count(distinct orderid) FROM Products p
	 inner join OrderDetails o ON o.ProductId=p.ProductId
	 Where (p.Amount= @xxx) AND (year(Orders.OrderDate) =  @YYY)

 delete from order where orderid in (
	SELECT orderid FROM Products p
	 inner join OrderDetails o ON o.ProductId=p.ProductId
	 Where (p.Amount= @xxx) AND (year(Orders.OrderDate) =  @YYY) )
	 SELECT 1;
	 RETURN
END

CREATE TABLE KHACHHANG
(
	MaKH NVARCHAR(10) NOT NULL PRIMARY KEY,
	HoTenKH NVARCHAR(100),
	DiaChiKH NVARCHAR(100),
	SoDienThoaiKH NVARCHAR(50),
)


INSERT INTO KHACHHANG VALUES(N'KH0001', N'Bui Le Suoi', N'Lien Chieu', '09012345')
INSERT INTO KHACHHANG VALUES(N'KH0002', N'Bui Le Man', N'Thanh Khe', '09112345')
INSERT INTO KHACHHANG VALUES(N'KH0003', N'Nguyen Thu', N'Lien Chieu', '09112346')
INSERT INTO KHACHHANG VALUES(N'KH0004',N'Nguyen Dong', N'Thanh Khe', '09012346')
INSERT INTO KHACHHANG VALUES(N'KH0005', N'Bui Ha', N'Hai Chau', '09012347')
INSERT INTO KHACHHANG VALUES(N'KH0006', N'Nguyen Xuan', N'Hai Chau', '0914987654')
INSERT INTO KHACHHANG VALUES(N'KH0007', N'Đặng Hoài Sơn', N'Liên chiểu', '0905666666')
INSERT INTO KHACHHANG VALUES(N'KH0008', N'Đặng Ngọc Chi', N'Hải Châu', '0905123456')
go
create proc xoakhachhang as begin 
(select count(*) from KHACHHANG where HoTenKH like N'Đặng%')
delete from KHACHHANG where MaKH in (select MaKH from KHACHHANG where HoTenKH like N'Đặng%')
end 

exec xoakhachhang

select * from KHACHHANG