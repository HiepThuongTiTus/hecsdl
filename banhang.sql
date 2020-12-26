CREATE TABLE KHACHHANG
(
	MaKH VARCHAR(30) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(30),
	Email VARCHAR(30),
	SoDT CHAR(11),
	DiaChi VARCHAR(30)
)
CREATE TABLE DMSANPHAM
(
	MaDM VARCHAR(30) NOT NULL PRIMARY KEY,
	TenDanhMuc VARCHAR(30),
	MoTa VARCHAR(30)
)
CREATE TABLE THANHTOAN
(
	MaTT VARCHAR(30) NOT NULL PRIMARY KEY,
	PhuongThucTT  VARCHAR(30)
)
CREATE TABLE SANPHAM
(
	MaSP VARCHAR(30) NOT NULL PRIMARY KEY,
	MaDM VARCHAR(30) NOT NULL,
	TenSP VARCHAR(30),
	GiaTien DECIMAL(6,3),
	SoLuong INT,
	XuatXu VARCHAR(30)
	FOREIGN KEY (MaDM) REFERENCES DMSANPHAM(MaDM)
)
CREATE TABLE DONHANG
(
	MaDH VARCHAR(30) NOT NULL PRIMARY KEY,
	MaKH VARCHAR(30),
	MaTT VARCHAR(30),
	NgayDat DATETIME
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaTT) REFERENCES THANHTOAN(MaTT)
)
CREATE TABLE CHITIETDONHANG
(
	MaDH VARCHAR(30) NOT NULL,
	MaSP VARCHAR(30) NOT NULL,
	SoLuong INT,
	TongTien INT
	PRIMARY KEY (MaDH, MaSP),
	FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH),
	FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
)
INSERT INTO KHACHHANG VALUES  
(N'KH001',N'Tran Van An',N'antv@gmail.com','0905123564',N'Lang Son'), 
(N'KH002',N'Phan Phuoc',N'phuocp@gmail.com','0932568984',N'Da Nang'),
(N'KH003',N'Tran Huu Anh',N'anhth@gmail.com','0901865232',N'Ha Noi')
INSERT INTO DMSANPHAM VALUES  
(N'DM01',N'Thoi Trang Nu',N'vay, ao danh cho nu'), 
(N'DM02',N'Thoi Trang Nam',N'quan danh cho nam'),
(N'DM03',N'Trang suc',N'danh cho nu va nam')
INSERT INTO SANPHAM VALUES  
(N'SP001',N'DM01',N'Dam Maxi',200,195000,'VN'), 
(N'SP002',N'DM01',N'Tui Da Mỹ',50,3000000,'HK'),
(N'SP003',N'DM02',N'Lac tay Uc',300,300000,'HQ')
INSERT INTO THANHTOAN VALUES  
(N'TT01',N'Visa'), 
(N'TT02',N'Master Card'),
(N'TT03',N'JCB')
INSERT INTO DONHANG VALUES  
(N'DH001',N'KH002',N'TT01','2014-10-20'), 
(N'DH002',N'KH002',N'TT01','2015-5-15'),
(N'DH003',N'KH001',N'TT03','2015-4-20')
INSERT INTO CHITIETDONHANG VALUES  
(N'DH001',N'SP002',3,56000), 
(N'DH003',N'SP001',10,27444),
(N'DH002',N'SP002',10,67144)

--1.a Tạo một khung nhìn có tên là V_KhachHang để thấy được thông tin của tất cả các đơn hàng có ngày 
--đặt hàng nhỏ hơn  ngày 06/15/2015 của những khách hàng có địa chỉ là "Da Nang". 
 drop VIEW V_KHACHHANG
CREATE VIEW V_KHACHHANG
AS
SELECT DONHANG.MaDH,DONHANG.MaKH,DONHANG.MaTT,DONHANG.NgayDat FROM DONHANG
INNER JOIN KHACHHANG ON DONHANG.MaKH=KHACHHANG.MaKH
WHERE (DONHANG.NgayDat<= '2015/06/15' AND KHACHHANG.DiaChi='Da Nang')


--1.b Thông qua khung nhìn V_KhachHang thực hiện việc
-- cập nhật ngày đặt hàng thành 06/15/2015 đối với những khách hang đặt hàng vào ngày 06/15/2014. 
UPDATE V_KHACHHANG
SET NgayDat='06/15/2015' WHERE NgayDat='06/15/2014'

--2. Tạo 2 thủ tục: 
--a.	Thủ tục Sp_1: Dùng để xóa thông tin của những sản phẩm có mã 
--sản phẩm được truyền vào như một tham số của thủ tục.
CREATE proc Sp_1
(
	@MaSP NVARCHAR(50)
)
AS
BEGIN 
DELETE FROM SANPHAM WHERE MaSP = @MaSP
END

exec Sp_1 'SP003'

--b.	Thủ tục Sp_2: Dùng để bổ sung thêm bản ghi mới vào bảng
-- CHITIETDONHANG (Sp_2 phải thực hiện kiểm tra tính hợp lệ của dữ liệu được
-- bổ sung là không trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng có liên quan). 
CREATE proc Sp_2
(
	@MaDH nvarchar(50) ,
	@MaSP nvarchar(50 )	,
	@SoLuong int ,
	@TongTien float
)
AS
BEGIN
if exists (select MaDH from DONHANG where MaDH=@MaDH) and exists (select MaSP from SANPHAM where MaSP=@MaSP)
	begin
		if exists (select MaDH from CHITIETDONHANG where MaDH=@MaDH)
		begin
			print 'đã trùng dữ liệu từ db!!!'
			rollback tran
		end
		else insert into CHITIETDONHANG values(@MaDH,@MaSP,@SoLuong,@TongTien)
	end
	else
	begin
		print 'không tồn tại đơn hàng hoặc sản phẩm update!!!'
		rollback tran
	end
 end

 exec Sp_2 'DH002','SP002',3,30000
--Câu 3: Viết 2 bẫy sự kiện (trigger) cho bảng CHITIETDONHANG theo yêu cầu sau:
--a.	Trigger_1: Khi thực hiện đăng ký mới một đơn đặt hàng cho 
--khách hàng thì cập nhật lại số lượng sản phẩm trong bảng 
--sản phẩm (tức là số lượng sản phẩm còn lại sau khi đã bán). Bẫy sự kiện chỉ xử lý 1 bản ghi.

create trigger trg_1
on CHITIETDONHANG
for insert
as
begin
	declare @SoLuong int
	declare @MaSP nvarchar(50 )
	select @SoLuong = inserted.SoLuong  from inserted
	select @MaSP=inserted.MaSP from inserted
	update SANPHAM set SoLuong=SoLuong-@SoLuong where MaSP=@MaSP
	
end
create trigger trigger_1
on CHITIETDONHANG
after insert
as
begin
	declare @SoLuong int
	declare @MaSP nvarchar(50 )
	select @SoLuong=SoLuong from inserted
	select @MaSP=MaSP from inserted
	update SANPHAM set SoLuong=(SoLuong-@SoLuong) where MaSP=@MaSP
end
--b.	Trigger_2: Khi cập nhập lại số lượng sản phẩm mà khách hàng đã đặt hàng, kiểm 
--tra xem số lượng cập nhật có phù hợp hay không (số lượng phải lớn hơn 1 và nhỏ hơn 100). 
--Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu không thì hiển thị thông báo "số lượng sản
-- phẩm được đặt hàng phải nằm trong khoảng giá trị từ 1 đến 100" và thực hiện quay lui giao tác. 

create trigger trigger_2
on CHITIETDONHANG
for update
as
begin
	declare @SoLuong int
	select @SoLuong=SoLuong from inserted
	if(@SoLuong between 1 and 100) update CHITIETDONHANG set SoLuong=@SoLuong
	else
	begin
		print 'số lượng sản
	phẩm được đặt hàng phải nằm trong khoảng giá trị từ 1 đến 100'
		rollback tran
	end
end
---
---\
--Câu 4: Tạo hàm do người dùng định nghĩa (user-defined function) để tính điểm thưởng cho khách 
--hàng của tất cả các lần đặt hàng trong 
--năm 2014, mã khách hàng sẽ được truyền vào thông qua tham số đầu vào của hàm. Cụ thể như sau:
--	Nếu tổng số tiền khách hàng đã trả cho tất cả các lần mua hàng dưới 2.000.000, thì trả về kết
-- quả là khách hàng được nhận 20 điểm thưởng.
--	Nếu tổng số tiền khách hàng đã trả cho tất cả các lần mua hàng từ 2.000.000 trở đi, thì trả về 
--kết quả là khách hàng được nhận 50 
--điểm thưởng. 

create function user_defined(@MaKH nvarchar(50))
returns nvarchar(100)
as
begin
	declare @Notice nvarchar(100)
	if exists (select KHACHHANG.MaKH from KHACHHANG join DONHANG on KHACHHANG.MaKH=DONHANG.MaKH join CHITIETDONHANG 
	on DONHANG.MaDH=CHITIETDONHANG.MaDH where KHACHHANG.MaKH=@MaKH
	 and YEAR(DONHANG.NgayDat)='2014' group by KHACHHANG.MaKH having sum(CHITIETDONHANG.TongTien)>2000000)
	begin
		set @Notice = 'Khách hàng được nhận 50 điểm thưởng.'
	end
	else
	begin
		set @Notice ='Khách hàng được nhận 20 điểm thưởng.'
	end
	return @Notice
end
---
--
--Câu 5: Tạo thủ tục Sp_SanPham tìm những sản phẩm đã từng được khách hàng đặt mua để 
-- xóa thông tin về những sản phẩm đó trong bảng SANPHAM và xóa thông tin những đơn hàng
-- có liên quan đến những sản phẩm đó (tức là 
--phải xóa những bản ghi trong bảng DONHANG và CHITIETDONHANG có liên quan đến các sản phẩm đó). 

create proc Sp_SanPham1
as
begin
	begin tran deletepro;

	declare contro cursor
	for select MaSP, MaDH 
	from CHITIETDONHANG
	open contro
	declare @masp nchar(10)
	declare @madh nchar(10)

	fetch next from contro
	into @masp, @madh
	while @@FETCH_STATUS = 0
	begin

		delete from CHITIETDONHANG

		if @@ERROR !=0
			begin
				print 'rollback';
				rollback tran deletepro
			end

		delete from SANPHAM where SANPHAM.MaSP = @masp

		if @@ERROR !=0
			begin 
				print 'rollback';
				rollback tran deletepro
			end
		delete from DONHANG where MaDH =@madh

		if @@ERROR !=0
			begin 
				print 'rollback';
				rollback tran deletepro
			end

	fetch next from contro 
	into @madh,@masp

	end
	close contro
	deallocate contro

	commit tran deletepro;

end

exec Sp_SanPham1
