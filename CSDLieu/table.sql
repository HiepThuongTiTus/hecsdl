
DECLARE @th2 TABLE
(
	So int,
	HoTen NVARCHAR(255)
)

insert into @th2 values (5,N'Hiep')
insert into @th2 values (24,N'Hiep1')
insert into @th2 values (12,N'Hiep2')
insert into @th2 values (15,N'Hi')

SELECT * FROM @th2
--1. Kiểu dữ liệu
--2. Khai báo biến
--3.Gán giá trị 1 biến
--4.Khai báo con trỏ
--5.Khai báo với con trỏ
--6. Cấu trúc rẽ nhánh
--7.Cấu trúc lặp
--8.Kiểu table.

