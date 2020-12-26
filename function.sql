--doanh thu thuần dựa trên số lượng 
CREATE FUNCTION sales.udfNetSale
(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;