USE EmpresaDB;
GO

DROP TRIGGER IF EXISTS trg_AuditarVenta;
GO

CREATE TRIGGER trg_AuditarVenta
ON Ventas
AFTER INSERT
AS
BEGIN
    DECLARE @VentaID INT;
    SELECT @VentaID = VentaID FROM inserted;
    EXEC sp_RegistrarAuditoria @VentaID;
END;
GO