﻿CREATE TABLE GIAOVIEN
(
	MaGV VARCHAR(20) NOT NULL PRIMARY KEY,
)
CREATE TABLE SINHVIEN
(
	MaSV VARCHAR(20) NOT NULL PRIMARY KEY
)

CREATE TABLE MONHOC
(
	MaMH VARCHAR(20) NOT NULL PRIMARY KEY,
	TenMH VARCHAR(50),
	SoTC INT
)

CREATE TABLE LOPTINCHI
(
	MaLopTC VARCHAR(20) NOT NULL PRIMARY KEY,
	MaMH VARCHAR(20) NOT NULL,
	MaGV VARCHAR(20) NOT NULL,

	FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH),
	FOREIGN KEY (MaGV) REFERENCES GIAOVIEN(MaGV)
)

CREATE TABLE BANGDIEM
(
	MaLopTC VARCHAR(20) NOT NULL,
	MaSV VARCHAR(20) NOT NULL,
	DiemTK INT

	PRIMARY KEY (MaLopTC, MaSV),
	FOREIGN KEY (MaLopTC) REFERENCES LOPTINCHI(MaLopTC),
	FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV)
)

INSERT INTO LOPTINCHI VALUES ('LTC1', 'M1', 'GV1')
INSERT INTO LOPTINCHI VALUES ('LTC3', 'M2', 'GV2')
INSERT INTO LOPTINCHI VALUES ('LTC2', 'M2', 'GV2')

INSERT INTO MONHOC VALUES ('M1', 'MH1', 2)
INSERT INTO MONHOC VALUES ('M2', 'MH2', 3)



INSERT INTO BANGDIEM VALUES ('LTC1', 'SV1', 6)
INSERT INTO BANGDIEM VALUES ('LTC3', 'SV1', 7)
INSERT INTO BANGDIEM VALUES ('LTC2', 'SV2', 8)
INSERT INTO BANGDIEM VALUES ('LTC3', 'SV2', 9)
INSERT INTO BANGDIEM VALUES ('LTC2', 'SV1', 8)

INSERT INTO GIAOVIEN VALUES ('GV1')
INSERT INTO GIAOVIEN VALUES ('GV2')

INSERT INTO SINHVIEN VALUES ('SV1')
INSERT INTO SINHVIEN VALUES ('SV2')

--bai 9

SELECT d.MaSV, SUM(d.DiemTK*m.soTC) AS TongDiem,SUM(m.SoTC) AS TongSoTC 
FROM MONHOC AS m INNER JOIN LOPTINCHI AS I ON m.MaMH=I.MaMH INNER JOIN BANGDIEM AS d ON I.MaLopTC=d.MaLopTC GROUP BY MaSV
GO
SELECT d.MaSV, SUM(d.DiemTK*m.soTC)/SUM(m.SoTC) AS DiemTB 
FROM MONHOC AS m INNER JOIN LOPTINCHI AS I ON m.MaMH=I.MaMH INNER JOIN BANGDIEM AS d ON I.MaLopTC=d.MaLopTC GROUP BY MaSV

--bai 10

SELECT MaMH, TenMH, SoTC from MONHOC
SELECT MalopTC, MaMH, MaGV from LOPTINCHI
SELECT MaiLopTC, MaSV, DiemTK from BANGDIEM
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV 
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV 
having SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)>=8

--bai 11
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV 
having SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)>=8.5

--bài 12
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC) as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV 
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC) as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC inner join SINHVIEN as s on d.MaSV having SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC)>=8

--bai 13
SELECT d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC) as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV
SELECT Top 2 d.MaSV, SUM(d.DiemTK*m.SoTC)/SUM(m.SoTC) as DiemTB from MONHOC as m inner join LOPTINCHI as i on m.MaMH=i.MaMH inner join BANGDIEM as d on i.MaLopTC=d.MaLopTC group by MaSV 
order by SUM(d.DiemTK*m.SoTC)/SUM(M.SoTC desc

--Liệt kê danh sách các nhân viên chưa lập hóa đơn nào từ tháng 01/1997
SELECT [EmployeeID], [FirstName] FROM [dbo].[Employees] WHERE 
[EmployeeId] NOT IN (SELECT [EmployeeID] FROM [dbo].[Orders]
WHERE MONTH([OrderDate])=1 AND YEAR ([OrderDate])=1997)
