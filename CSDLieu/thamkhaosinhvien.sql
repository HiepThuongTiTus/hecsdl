
--Liet ke ds cac nhan vien chua lap hoa doon nao tu thang 1/1997
SELECT MaNV FROM NHANVIEN WHERE MaNV
NOT IN (SELECT MaNV FROM ORDERS
WHERE MONTH([OrderDate])=1 AND YEAR ([OrderDate])=1997)





--Cho luoc doCSDL QL diem SV, 
--Sinh Vien(MASV, HoTen, Nu, NgaySinh,MaLop,HocBong,Tinh)
--Lop(MaLop,TenLop,MaKhoa)
--Khoa(MaKhoa,TenKhoa,SoCBGD)
--MonHoc(MaMH,TenMH,SoTiet)
--KetQua(MaSV,MaMH,DiemThi)

--VD1: Liet ke ds cac lop cua khoa, thong tin can MaLop,TenLop,MaKHoa
SELECT *FROM Lop

--VD2: Lap DS SV Gom MASV,HoTen,HocBong
SELECT MASV,HoTen, HocBong FROM SinhVien

--VD3: Lap DS SV co hoc bong. DS Gom MASV,Nu,HocBong
SELECT MASV,NU,HocBong FROM SinhVien WHERE HocBong>0

--VD4:Lap ds sv nu. DS can cac thuoc tinh cua quan he sv
SELECT * FROM SinhVien WHERE Nu=Yes

--VD5: Lap ds sv co ho 'Tran'
SELECT *FROM SinhVien WHERE HoTen LIKE 'Tran*'

--VD6: Lap ds sv nu co hoc bong
SELECT *FROM SinhVien WHERE Nu=Yes AND HocBong>0

--VD7: Lap DS sv nu hoac ds sv co hoc bong
SELECT * FROM SinhVien WHERE Nu=YES OR HocBong>0

--VD8: Lap ds dv co nam tu 1978 den 1985. Danh sach can cac thuoc tinh cua quan he SinhVien
SELECT *FROM SinhVien WHERE YEAR(NgaySinh) BETWEEN 1978 AND 1985

--VD9: Liet ke danh sach sinh vien duoc sap xep tang dan theo MaSV
SELECT *FROM SinhVien 
ORDER BY MaSV ASC

--VD10: Liet ke ds sv duoc sap xep giam dan theo Hoc Bong
SELECT *FROM SinhVien 
ORDER BY HocBong DESC

--VD11:Lap ds sv co diem thi mon CSDL>=8
SELECT SinhVien.MaSV, HoTen,Nu,NgaySinh,DiemThi FROM SinhVien 
INNER JOIN KetQua ON SinhVien.MaSV=KetQua.MaSV
WHERE MaMH='CSDL' AND DiemThi>=8

--VD12: Lap ds sv co hoc bong cua khoa CNTT. Thong tin can: MASV, HoTen,HocBong,TenLop
SELECT MaSV,HoTen,HocBong,TenLop
FROM Lop INNER JOIN SinhVien ON Lop.MaLop=SinhVien.MaLop
WHERE HocBong>0 AND MaKhoa='CNTT'

--VD13: Lap ds sv co hb cua khoa CNTT. Thong tin can: MaSV, HoTen,HocBong,TenLop,TenKhoa
SELECT MaSV,HoTen,HocBong, TenLop, TenKhoa FROM ((Lop INNER JOIN SinhVien ON Lop.MaLop=SinhVien.MaLop)
INNER JOIN Khoa ON Khoa.MaKhoa=Lop.MaKhoa)
WHERE HocBong>0 AND Khoa.MaKhoa='CNTT'

--VD14: Cho biet so sv cua lop
SELECT Lop.MaLop, TenLop, COUNT(MaSV) AS SLSinhVien FROM Lop 
INNER JOIN SinhVien ON Lop.MaLop=SinhVien.MaLop 
GROUP BY Lop.MaLop,TenLop

--VD15: Cho Biet So luong sv cua moi khoa
SELECT Khoa.MaKhoa, TenKhoa, COUNT(MaSV) AS SLSinhVien FROM ((Khoa INNER JOIN Lop ON Khoa.MaKhoa=Lop.MaKhoa) 
INNER JOIN SinhVien ON Lop.MaLop=SinhVien.MaLop)
GROUP BY Khoa.MaKhoa, TenKhoa

--VD16: Cho biet so luong sv nu cua moi khoa
SELECT Khoa.MaKhoa, TenKhoa,Count(MaSV) AS SLSinhVien
FROM ((SinhVien INNER JOIN Lop ON Lop.MaLop= SinhVien.MaLop)
INNER JOIN Khoa ON Khoa.MaKhoa = SinhVien.MaKhoa)
WHERE Nu= YesGROUP BY Khoa.MaKhoa, TenKhoa

--VD17: Cho biet tong tien hoc bong cua moi lop
SELECT Lop.MaLop, TenLop, SUM(HocBong) AS TongHB
FROM (Lop INNER JOIN SinhVien ON  Lop.MaLop=SinhVien.MaLop)
GROUP BY Lop.MaLop, TenLop

--VD18: cho biet tong so tien hoc bong cua moi khoa
SELECT Khoa.MaKhoa, TenKhoa, SUM(HocBong) AS TongHB
FROM ((Khoa INNER JOIN Lop ON Khoa.MaKhoa=Lop.MaKhoa)
INNER JOIN SinhVien ON Lop.MaLop= SinhVien.MaLop)
GROUP BY Khoa.MaKhoa,TenKhoa

--VD19: Lap ds cua nhung khoa co nhieu hon 100 sv. DS can MaKhoa, TenKhoa, SoLuong
SELECT Khoa.MaKhoa, TenKhoa, COUNT(MaSV) AS SLSinhVien
FROM ((Khoa INNER JOIN Lop ON Khoa.MaKhoa=Lop.MaKhoa) 
INNER JOIN SinhVien ON Lop.MaLop= SinhVien.MaLop)
GROUP BY Khoa.MaKhoa, TenKhoa HAVING COUNT (MaSV)>100

--VD20: Lap ds nhung khoa co nhieu hon 50 nu. ds can makhoa, ten khoa, so luong
SELECT Khoa.MaKhoa, TenKhoa, COUNT(MaSV) AS SLSinhVien FROM ((Khoa INNER JOIN Lop ON Khoa.Makhoa =Lop.MaKhoa)
INNER JOIN SinhVien ON Lop.MaLop= Sinhvien.MaLop)
WHERE Nu=Yes
GROUP BY Khoa.MaKhoa, TenKhoa
HAVING COUNT(MaSV)>=50

--VD21: Lap ds nhung khoa co tong tien hoc bong >=1000000
SELECT Khoa.MaKhoa, TenKhoa, SUM(HocBong) AS TongHB 
FROM ((Khoa INNER JOIN Lop ON Khoa.MaKhoa=Lop.MaKhoa) 
INNER JOIN SinhVien ON Lop.MaLop= SinhVien.MaLop)
GROUP BY Khoa.MaKhoa, TenKhoaHAVING SUM(HocBong)>=1000000

--VD22: Lap ds sv co hb cao nhat
SELECT SinhVien *FROM SinhVien WHERE HocBong>= ALL(SELECT HocBong FROM SinhVien)

--VD23: Lap ds sv co diem thi mon CSDL cao nhat
SELECT SinhVien.MaSV, HoTen, DiemThi
FROM SinhVien INNER JOIN KetQua ON SinhVien.MaSV=KetQUa.MaSV
WHERE KetQua.MaMH='CSDL' AND DiemThi>=ALL(SELECT DiemThi FROM KetQa WHERE MaMH ='CSDL')

--VD24: Lap DS nhung sv khong co diem thi mon csdl
SELECT SinhVien.MaSV, HoTen, DiemThi, MaMH
FROM SinhVien INNER JOIN KetQua ON SinhVien.MaSV= KetQua.MaSV 
WHERE SinhVien.MaSV NOT IN (SELECT MaSV FROM KETQUA WHERE MaMH='CSDL')

--VD25: Cho biet nhung khoa co nhieu sv nhat :
SELECT Khoa.MaKhoa, TenKhoa, COUNT ([MaSV]) AS SoLuongSV FROM 
(Khoa INNER JOIN Lop ON Khoa.MaKhoa=Lop.MaKhoa) INNER JOIN SinhVien ON lop.MaLop= SinhVien.MaLop
GROUP BY Khoa.MaKhoa, Khoa, TenKhoa
Having Count(MaSV)>= ALL(SELECT COUNT(MaSV) FROM ((SinhVien INNER JOIN Lop ON Lop.MaLop=SinhVien.MaLop) 
INNER Khoa ON Khoa.MaKhoa= Lop.MaKhoa) GROUP BY Khoa.MakHoa)
