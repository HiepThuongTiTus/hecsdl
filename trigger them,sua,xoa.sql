--TRIGGER THÊM
--Cập nhật hàng trong kho sau khi đặt hàng hoặc cập nhật
CREATE TRIGGER trg_Dathang 
ON DATHANG
AFTER INSERT 
AS
BEGIN
	UPDATE KHOHANG
	SET SoLuongTon= SoLuongTon-(SELECT Soluongdat FROM inserted 
	WHERE MaHang = KHOHANG.MaHang)
	FROM KHOHANG
	INNER JOIN inserted 
	ON KHOHANG.MaHang = inserted.MaHang
END

--TRIGGER XÓA
--Cập nhật hàng trong kho sau khi hủy đặt hàng
CREATE TRIGGER Huydathang
ON DATHANG
FOR DELETE 
AS
BEGIN
	UPDATE KHOHANG
	SET Soluongton = SoluongTon +(SELECT Soluongdat FROM deleted 
	WHERE MaHang = KHOHANG.MaHang)
	FROM KHOHANG
	INNER JOIN deleted
	ON KHOHANG.MaHang = deleted.MaHang
END

--TRIGGER SỬA
--Cập nhật hàng trong kho sau khi cập nhật đặt hàng
CREATE TRIGGER Capnhatdathang 
ON DATHANG
AFTER UPDATE
AS
BEGIN
	UPDATE KHOHANG
	SET Soluongton = SoluongTon - (SELECT Soluongdat FROM inserted 
	WHERE MaHang = KHOHANG.MaHang) + (SELECT Soluongdat FROM deleted 
	WHERE MaHang = KHOHANG.MaHang)
	FROM KHOHANG
	INNER JOIN deleted
	ON KHOHANG.MaHang = deleted.MaHang
END

