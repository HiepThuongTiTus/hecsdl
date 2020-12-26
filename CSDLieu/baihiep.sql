CREATE TABLE Categories
(
	CategoryId INT NOT NULL PRIMARY KEY,
	CategoryName NVARCHAR(255)
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

INSERT INTO Categories VALUES(2,N'TEN1')
INSERT INTO Categories VALUES(20,N'TEN2')
INSERT INTO Categories VALUES(3,N'TEN3')
INSERT INTO Categories VALUES(30,N'TEN4')
INSERT INTO Categories VALUES(4,N'TEN5')
INSERT INTO Categories VALUES(40,N'TEN6')
INSERT INTO Categories VALUES(5,N'TEN7')
INSERT INTO Categories VALUES(25,N'TEN8')
INSERT INTO Categories VALUES(24,N'TEN9')
INSERT INTO Categories VALUES(23,N'TEN10')

INSERT INTO Products VALUES(12,N'Sx1',30,15,2)
INSERT INTO Products VALUES(14,N'Sx1',50,8,30)
INSERT INTO Products VALUES(15,N'Sx1',100,4,3)
INSERT INTO Products VALUES(16,N'Sx1',40,30,4)
INSERT INTO Products VALUES(17,N'Sx1',90,35,4)
INSERT INTO Products VALUES(18,N'Sx1',180,5,25)
INSERT INTO Products VALUES(19,N'Sx1',170,8,24)
INSERT INTO Products VALUES(31,N'Sx1',200,2,23)
INSERT INTO Products VALUES(32,N'Sx1',230,5,40)
INSERT INTO Products VALUES(34,N'Sx1',300,19,2)
INSERT INTO Products VALUES(35,N'Sx1',350,15,25)

--Chọn ra 5 Product có số tồn kho (Amount) >= 10

SELECT t.Amount FROM Products t
WHERE t.Amount>=10
--Chọn ra 5 Product có giá bán cao nhất của nhóm sản phẩm 1 (CategoryId = 1)

SELECT COUNT(CategoryId) MAX(t.Price) FROM Products t
INNER JOIN Categories c ON c.CategoryId=t.CategoryId
HAVING COUNT(CategoryId)=1;
--Đếm số lượng Product theo Category

SELECT COUNT(CategoryId) AS SL FROM Product
INNER JOIN Categories c ON c.CategoryId=t.CategoryId

--Liệt kê các sản phẩm mà tên sản phẩm có chứa ký tự ‘N’

SELECT  t. ProductName FROM Products t
WHERE t.ProductName LIKE '%N%'

--Liệt kê các sản phẩm có giá trong khoản từ 100$ đến 200$ và từ 600$ đến 800$.

SELECT sp.Price FROM Products sp
WHERE sp.Price (BETWEEN 100$ AND 200$  OR BETWEEN 600$ AND 800$ )
--Liệt kê các sản phẩm có giá dưới 500$ và tồn kho trên 100

SELECT  sp.Price FROM Products sp
WHERE sp.Price <500$ AND 
--Liệt kê các danh mục chỉ có duy nhất 1 sản phẩm và đơn giá dưới 100$

SELECT DISTINCT(ProductId ) FROM Products 
WHERE Price<100$
--Cập nhật tên các sản phẩm mà tên có chứa ký tự ‘N’ thành giá trị N‘CSDL 01’

UPDATE Products SET ProductName='N‘CSDL 01’' WHERE ProductName='N'

--Xóa các sản phẩm có tồn kho dưới 100 và giá tiền trên 1000$

DELETE  FROM Products  
WHERE Price=1000$ AND 
--Cập nhật tất cả sản phẩm thuộc danh mục 1 thành danh mục 2 với điều kiện giá tiền trong khoản 600$ - 800$

UPDATE  Categories SET CategoryId ='2’ WHERE CategoryId ='1’
--Xóa các danh mục không có sản phẩm nào.

DELETE FROM Categories
WHERE (
SELECT *FROM  Products
WHERE Products.  CategoryId=  Categories.CategoryId
)

