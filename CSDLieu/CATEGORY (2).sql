--1. Tạo các bảng và thiết lập mối quan hệ như trên hình
CREATE TABLE Categories
(
CategoryId INT  PRIMARY KEY  NOT NULL,
	CategoryName NVARCHAR(255) NOT NULL
)

CREATE TABLE Products
(
	ProductId INT NOT NULL PRIMARY KEY,
	ProductName NVARCHAR(255),
	Price INT,
	Amount INT,
	CategoryId INT
	FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
)

create table Customers
(
CustomerId int not null primary key,
CustomerName nvarchar(50),
Address nvarchar(50),
Phone nvarchar(50)
)

create table Shippers
(
ShipperId int not null primary key,
CompanyName nvarchar(255),
Phone nvarchar(50)
)

create table Orders 
(
OrderId int not null primary key,
OrderDate datetime,
CustomerId int,
OrderStatus nvarchar(50),
OrderNote nvarchar(500),
ShipperId int
foreign key (CustomerId) references Customers(CustomerId),
foreign key (ShipperId) references Shippers(ShipperId)
)

create table OrderDetails
(
OrderId int,
ProductId int,
Amount int
primary key(OrderId, ProductId)
foreign key (OrderId) references Orders(OrderId),
foreign key (ProductId) references Products(ProductId)
)

--2. Thêm mỗi bảng ít nhất 10 dòng dữ liệu
--chen Categories
INSERT INTO Categories VALUES 
('1','ABC'), ('2','DEF')
,('3','GHI'), ('4','JKL')
,('5','MNO'), ('6','PQR')
,('7','STU'), ('8','VWX')
,('9','YZZ'),('10','RAM')

--chen Products
INSERT INTO Products  VALUES  
('100','vivo','100','10','1'), ('200','xiaomi','200','6','1')
,('300','iphone','300','20','10'),  ('400','sony','400','40','2')
,  ('500','ipad','500','50','5'), ('600','huawei','600','10','2')
, ('700','oppo','200','15','7'), ('800','nokia','50','550','1')
, ('900','apple','400','4','10'),  ('1000','samsung','100','30','6')

--chen Shippers
insert into Shippers values
('5051','cty VNPOST','0943185382'),('5052','cty VNPOST','0943145322')
,('5053','cty GHN','0943185382'),('5054','cty VNPOST','03147584931')
,('5055','cty GHTK','09147584567'),('5056','cty GHTK','09147545231')
,('5057','cty GHN','03147765643'),('5058','cty VNPOST','03147598643')
,('5059','cty GHTK','09747583121'),('50510','cty GHN','0319876444')

--chen Customers
insert into Customers values
('9001','Nguyen Van Vuong','Da Nang','0909001000'),('9002','Nguyen Trung Truc','Ha Noi','09094343434')
,('9003','Phan Ba Hai','HCM','09090014325'),('9004','Ho Dac Di','Da Nang','0909142000')
,('9005','Nguyen Van Hung','Da Nang','0904356320'),('9006','Nguyen Van Vuong','Ha Noi','0923001434')
,('9007','Vo Van Kiet','Hai Phong','0909035712'),('9008','Luong Van Can','Da Nang','0909345621')
,('9009','Vuong Nguyen','KomTum','0909003213'),('9010','Le Thi Thuy Trinh','Hue','0909007654')

insert into Orders values
('0001','02-07-2020','9001','Da ket thuc','Da nhan','5051'),('0002','08-10-2020','9002','Dang giao hang','Chua nhan','5052')
,('0003','01-01-2020','9003','Da ket thuc','Da nhan','5053'),('0004','07-01-2020','9004','Da ket thuc','Da nhan','5054')
,('0005','04-30-2020','9005','Dang giao hang','Chua nhan','5055'),('0006','05-10-2020','9006','Da ket thuc','Da nhan','5056')
,('0007','03-06-2020','9007','Da ket thuc','Da nhan','5057'),('0008','07-01-2020','9008','Da ket thuc','Da nhan','5058')
,('0009','07-01-2020','9009','Dang giao hang','Chua nhan','5059'),('0010','04-30-2020','9010','Da ket thuc','Da nhan','50510')

-- chen OrderDetails
insert into OrderDetails values
('0001','100','10'),('0002','200','200')
,('0003','300','20'),('0004','400','40')
,('0005','500','50'),('0006','600','10')
,('0007','700','15'),('0008','800','550')
,('0009','900','4'),('0010','1000','30')

---3. Liệt kê thông tin sản phẩm gồm: name, price, amount có price dưới 100$ và amount trên 500
select ProductName,Price,Amount from Products
where (Price<100) and (Amount>500)

--4. Liệt kê các khách hàng có địa chỉ ở Hà Nội mà có số điện thoại kết thúc bởi số ‘434’ và các khách hàng ở Hồ Chí Minh mà số điện thoại có số ‘000’
select c.CustomerId,c.CustomerName,c.Address,c.Phone from Customers c
where (c.Address like 'Ha Noi' and c.Phone like '%434') or (c.Address like 'HCM' and c.Phone like '%000%')

--5. Liệt kê tất cả sản phẩm chỉ bán được dưới 2 lần.
SELECT ProductName,Price,p.Amount, CategoryId FROM Products p
LEFT JOIN OrderDetails o ON p.ProductId= o.ProductId
Group by ProductName, Price, p.Amount, CategoryId 
HAVING COUNT (o.ProductId)<2

--6. Liệt kê tất cả đơn hàng có trạng thái là đã kết thúc của khách hàng có tên là ‘Vương’
SELECT  d.CustomerId,d.CustomerName,c.OrderId FROM Orders c
INNER JOIN Customers d ON d.CustomerId=c.CustomerId
WHERE (c.OrderStatus='Da ket thuc' AND d.CustomerName LIKE '%Vuong')

--7. Cho biết những khách hàng nào có đơn hàng được ship bởi công ty VNPOST và công ty Giao hàng nhanh.
SELECT c.CustomerId,c.CustomerName FROM Customers c
LEFT JOIN Orders o ON o.CustomerId=c.CustomerId
INNER JOIN Shippers s ON s.ShipperId=o.ShipperId
WHERE (s.CompanyName='cty VNPOST' and s.CompanyName='cty GHN')

---72/; chi do 2 cong ty
select *
from Customers as c join Orders as o on c.CustomerId=o.CustomerId
join Shippers as s on s.ShipperId=o.ShipperId
where s.ShipperId IN (1,2)
AND c.CustomerId NOT IN
(
    select c.CustomerId
    from Customers as c join Orders as o on c.CustomerId=o.CustomerId
    join Shippers as s on s.ShipperId=o.ShipperId
    where s.ShipperId NOT IN (1,2)
)

--8. Liệt kê danh sách khách hàng không có đơn hàng nào
SELECT c.CustomerId, c.CustomerName FROM Customers c
WHERE NOT EXISTS(
      SELECT*FROM Orders o 
	  WHERE (c.CustomerId = o.CustomerId)
)

--9. Liệt kê không lặp danh sách khách hàng có địa chỉ ở Đà Nẵng và từng mua Sản phẩm iphone hoặc các khách hàng 
--có đơn hàng trong giai đoạn 01/07/2020 đến ngày 10/08/2020.
SELECT DISTINCT c.CustomerId,c.CustomerName,c.Address FROM Customers c
INNER JOIN Orders o ON o.CustomerId=c.CustomerId
INNER JOIN OrderDetails d ON d.OrderId=o.OrderId
INNER JOIN Products p ON p.ProductId=d.ProductId
where (c.Address like 'Da Nang' and p.ProductName like 'iphone') or o.OrderDate BETWEEN '07-01-2020' AND '08-10-2020'

--10. Thống kê tổng doanh thu bán được trong giai đoạn từ 01/01/2020 đến ngày 10/08/2020.
SELECT SUM(p.Price*Amount) AS DOANHTHU
FROM Products p
INNER JOIN OrderDetails d ON d.ProductId=p.ProductId
INNER JOIN Orders o ON o.OrderId=d.OrderId
WHERE o.OrderDate BETWEEN '07-01-2020' AND '08-10-2020'
GROUP BY ProductName

--tai thoi diem ban dau

--11. Liệt kê TOP 5 danh mục sản phẩm có doanh thu bán hàng cao nhất trong giai đoạn từ 30/04/2020 đến ngày 01/07/2020.
SELECT TOP 5 c.CategoryId,p.ProductId, p.ProductName AS DOANHSO_MAX
FROM Products p
INNER JOIN Categories c ON c.CategoryId=p.CategoryId
INNER JOIN OrderDetails d ON d.ProductId=p.ProductId
INNER JOIN Orders o ON o.OrderId=d.OrderId
WHERE o.OrderDate BETWEEN '04-30-2020' AND '07-01-2020'
group by p.ProductId,p.ProductName
Order by sum(p.Price*d.Amount) desc