--de 1.Thực hành SQL
--cau 1: Tạo TABLE
CREATE TABLE SINHVIEN
(
	MaSV NVARCHAR(30) NOT NULL PRIMARY KEY,
	Lop NVARCHAR(30),
	TenSV NVARCHAR(30),
	NgaySinh DATETIME,
	Nu bit
)
CREATE TABLE MONHOC
(
	MaMH NVARCHAR(30) NOT NULL PRIMARY KEY,
	TenMH NVARCHAR(30)
)
CREATE TABLE DIEMTHI
(
	MaSV NVARCHAR(30),
	MaMH NVARCHAR(30),
	LanThi INT,
	Diem INT,
	PRIMARY KEY (MaSV, MaMH, LanThi),
	FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
	FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)
)

--cau 2: Bổ sung ràng buộc
ALTER TABLE DIEMTHI ADD
DEFAULT 1 FOR LanThi,
CHECK(Diem BETWEEN 0 AND 10)
--------------
insert into SinhVien values ('07ct112','Nguyen','Hoang Long','11/10/1989','True')
insert into SinhVien values ('07ct112','Le','Ngoc Nam','11/10/1989','True')
insert into SinhVien values ('07ct112','Le','Thanh Phuc','12/25/1989','True')
	--------------------
insert into MonHoc values (1,'SQL 2005')
insert into MonHoc values (2,'TTHCM')
	--------------------
insert into DiemThi values(1,1,1,10)
	--------------------
insert into DiemThi values(2,1,1,7)
insert into DiemThi values(2,1,2,9)
	--------------------
insert into DiemThi values(3,1,1,8)
insert into DiemThi values(3,2,1,2)
insert into DiemThi values(3,2,2,6)
insert into DiemThi values(3,2,3,10)

--------------Tạo view vwLanThiCuoi dùng liêt kê danh sách lần thi cuối cùng của các sinh viên gồm: Mã số sinh viên, 
--mã số môn học, lần thi cuối cùng của môn học (ví dụ sinh viên A thi môn học C ba lần thì lần thi cuối cùng là 3).
--câu 3.1: Tạo view vwLanThiCuoi
GO
CREATE VIEW vwLanThiCuoi
AS
SELECT MaSV, MaMH, LanThi = max(LanThi) FROM DIEMTHI
GROUP BY MaSV, MaMH
---Cau3.2.Tạo view vwDiemThiCuoi
--Tạo view vwDiemThiCuoi dùng liêt kê danh sách sinh viên gồm: Mã số sinh viên, mã số môn học, lần thi cuối cùng của môn học 
--(ví dụ sinh viên A thi môn học M ba lần thì lần thi cuối cùng là 3) và điểm của lần thi cuối cùng đó.
GO
CREATE VIEW vwDiemThiCuoi
AS
WITH BANGTAM AS(SELECT MaSV, MaMH, LanThiMax = max(LanThi) FROM DIEMTHI
group by MaSV, MaMH
SELECT D.* FROM BANGTAM B JOIN DIEMTHI D ON (B.MaSV = D.MaMH AND B.MaMH = D.MaMH AND B.LanThiMax=D.LanThi)
--cau4: Tạo trigger 
--Tạo trigger Insert cho table DiemThi dùng điền tự động số thứ tự lần thi khi thêm điểm thi một môn học của một sinh viên.
--Ví dụ sinh viên A đã thi môn học M hai lần thì lần thi mới thêm vào phải là 3.
GO 
CREATE TRIGGER itrg_AutoLanThi 
ON DIEMTHI
FOR INSERT
AS
DECLARE @MaSV NVARCHAR(30)
DECLARE @MaMH NVARCHAR(30)
SELECT @MaSV = MaSV, @MaMH=MaMH FROM inserted 
IF NOT EXISTS ( SELECT * FROM DIEMTHI WHERE MaSV=@MaSV AND MaMH=@MaMH)
BEGIN
	PRINT'Ma Sinh Vien them vao khong ton tai'
	ROLLBACK TRAN
	RETURN 
END
UPDATE DIEMTHI SET DIEMTHI.LanThi= DIEMTHI.LanThi+1
FROM INSERTED I WHERE I.MaSV=@MaSV AND I.MaMH=@MaMH
--CAU5: TAO THU TUC
--Viết thủ tục hoặc hàm liệt kê kết quả thi các môn của một sinh viên khi biết mã số của sinh viên (MSSV)
--gồm các thông tin: mã số môn học, lần thi, điểm thi. Trong đó, mã số sinh viên là giá trị input
GO CREATE PROC ThongTinSV(@MaSV  NVARCHAR(30) = 1)
AS
BEGIN
	SELECT MaMH, LanThi, Diem FROM DIEMTHI
	WHERE MaSV= @MaSV
END

GO
EXEC ThongTinSV 3
GO 
INSERT INTO DIEMTHI(MaSV, MaMH, Diem) values(4,1,7)

