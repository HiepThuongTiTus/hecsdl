CREATE TABLE NHANVIEN
(
	MaNV NVARCHAR(30) NOT NULL PRIMARY KEY,
	TenNV NVARCHAR(30),
	Email NVARCHAR(30),
	SoDT VARCHAR(30),
	DiaChi VARCHAR(30),
	Tinhtrang VARCHAR(30),
)

CREATE TABLE THANHTOAN
(
	MaTT VARCHAR(30) NOT NULL PRIMARY KEY,
	PhuongThucTT  VARCHAR(30)
)

CREATE TABLE HoaDon
(
	MaHoaDon NVARCHAR(30) NOT NULL PRIMARY KEY,
	MaNV NVARCHAR(30),
	MaTT NVARCHAR(30),
	NgayHD NVARCHAR(30)

	FOREIGN KEY (MaTT) REFERENCES THANHTOAN(MaTT),
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

CREATE TABLE LOAIHANG
(
	MaLH NVARCHAR(30) NOT NULL PRIMARY KEY,
	TenLoaiHang NVARCHAR(30) NOT NULL,
	MoTa NVARCHAR(30) NOT NULL
)

CREATE TABLE MATHANG
(
	MaMH NVARCHAR(30) NOT NULL PRIMARY KEY,
	MaLH NVARCHAR(30) NOT NULL,
	TenSP NVARCHAR(30) NOT NULL,
	GiaTien FLOAT,
	SoLuong INT,
	XuatXu NVARCHAR(30)

	FOREIGN KEY (MaLH) REFERENCES LOAIHANG(MaLH)
)

CREATE TABLE CHITIETDONHANG
(
	MaHD NVARCHAR(30) NOT NULL,
	MaMH NVARCHAR(30) NOT NULL,
	SoLuong INT,
	ThanhTien FLOAT
	PRIMARY KEY (MaHD, MaMH),
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	FOREIGN KEY (MaMH) REFERENCES MATHANG(MaMH)
)

--1. Kiểm tra các điều kiện đã cho, không thỏa mãn thì hủy thao tác hiện tại phát sinh sự kiện.
--a. Cho sự kiện thêm mới nhiều bản ghi trên bảng MATHANG, giá tiền còn phải lớn hơn 0 và 
--số lượng phải bằng 0, mã danh mục sản phẩm phải có trong bảng LOAIHANG
create trigger trig1
on MATHANG
for insert
as
begin
	declare @MaMH NVARCHAR(30)
	declare @TenSP NVARCHAR(30)
	declare @GiaTien NVARCHAR(30)
	declare @Xuatxu NVARCHAR(30)
	declare @SoLuong INT
	declare @MaLH NVARCHAR(30)
	begin transaction;

	if exists (select MaLH from LOAIHANG where MaLH=@MaLH)
	begin
		if exists (select MaLH from MATHANG where GiaTien>0 AND SoLuong = 0)
		begin
			print 'đã trùng dữ liệu từ db!!!'
			rollback tran
		end
		else insert into MATHANG values(@MaMH, @MaLH,@TenSP, @GiaTien,@SoLuong,@XuatXu)
	end
	else
	begin
		print 'Hủy thao tác'
		rollback tran
	end
 end