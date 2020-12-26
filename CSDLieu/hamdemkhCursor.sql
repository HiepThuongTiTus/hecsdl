--Viết hàm sử dụng Cursor, để đếm số lượng/lượt khách hàng đã mua 1 sản phẩm có mã X. Với X là tham số kiểu int

CREATE FUNCTION countCustomer1 ( @productid INT )
 RETURNS int AS
 BEGIN
 
 DECLARE @kq int;
 Declare @temp int;
 set @kq=0;

 DECLARE Orders_Cursor CURSOR FOR
 (SELECT p.ProductId FROM Orders o 
 INNER JOIN Customers c ON c.CustomerId=o.CustomerId 
 INNER JOIN OrderDetails d ON d.OrderId=o.OrderId 
 INNER JOIN Products p ON p.ProductId=d.ProductId
 WHERE p.ProductId = @productid)

OPEN Orders_Cursor  --open con tro
FETCH NEXT FROM Orders_Cursor into @temp;
while (@@FETCH_STATUS = 0 )
BEGIN 
set @kq=@kq+1;
FETCH NEXT FROM Orders_Cursor into @temp
END

CLOSE Orders_Cursor --close
DEALLOCATE Orders_Cursor---giaiphong bo nho
 RETURN @kq;
 END;
 go

 select dbo.countCustomer1(1)  as 'dem'

