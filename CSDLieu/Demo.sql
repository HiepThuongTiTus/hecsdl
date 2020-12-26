CREATE TABLE PHONGBAN
(
	MaPB VARCHAR(20) NOT NULL PRIMARY KEY,
	TenPB VARCHAR(20),
	Dienthoai CHAR(11),
	Diachi VARCHAR(50),
)

CREATE TABLE NHANVIEN
(
	MaNV VARCHAR(20) NOT NULL PRIMARY KEY,
	TenNV VARCHAR(20),
	NS VARCHAR(50),
	QQ VARCHAR(20),
	MaPB VARCHAR(20),
	FOREIGN KEY (MaPB) REFERENCES PHONGBAN(MaPB)
)

INSERT INTO NHANVIEN VALUES ('N1','NV1', 'NS1', 'Q1','P1')
INSERT INTO NHANVIEN VALUES ('N2','NV1', 'NS1', 'Q1','P1')
INSERT INTO NHANVIEN VALUES ('N3','NV2', 'NS3', 'Q1','P2')
INSERT INTO NHANVIEN VALUES ('N4','NV4', 'NS4', 'Q2','P1')
INSERT INTO NHANVIEN VALUES ('N5','NV5', 'NS5', 'Q1','P2')
INSERT INTO NHANVIEN VALUES ('N6','NV6', 'NS6', 'Q1','P1')

--VD1:
SELECT MaNV, TenNV, NS, QQ FROM NHANVIEN WHERE MaPB='P1' 

--VD2:
SELECT MaNV, TenNV, NS, QQ, MaPB FROM NHANVIEN 
ORDER BY MaPB ASC, QQ

--VD3: 
SELECT MaNV, TenNV, NS, QQ, MaPB FROM NHANVIEN 
WHERE QQ = 'Q1'
ORDER BY MaPB DESC, TenNV

--VD4: 
SELECT MaPB, 
COUNT(MaNV) AS SoNV FROM NHANVIEN 
GROUP BY MaPB 

--VD5:
SELECT MaPB, QQ,
COUNT(MaNV) AS SoNV FROM NHANVIEN 
GROUP BY MaPB,QQ 

--VD6:
SELECT MaPB,
COUNT(MaNV) AS SoNV FROM NHANVIEN 
WHERE QQ='Q1' 
GROUP BY MaPB

--VD7:
SELECT  n.MaPB, TenPB, Dienthoai, Diachi,
COUNT(MaNV) AS SoNV FROM NHANVIEN n
JOIN PHONGBAN p 
ON n.MaPB =p.MaPB
GROUP BY n.MaPB, TenPB, Dienthoai, Diachi

--vd8
SELECT MaPB, 
COUNT(MaNV) AS SONV FROM NHANVIEN GROUP BY MaPB 
HAVING COUNT(MaNV)>3

--VD9
SELECT MaPB,
COUNT(MaNV) AS SoNV FROM NHANVIEN WHERE QQ='Q1'
GROUP BY MaPB HAVING COUNT(MaNV)>2


