USE EmpresaDB;
GO

DROP PROCEDURE IF EXISTS sp_RegistrarAuditoria;
GO

CREATE PROCEDURE sp_RegistrarAuditoria
    @VentaID INT
AS
BEGIN
    INSERT INTO AuditoriaVentas(VentaID, Mensaje)
    VALUES (@VentaID, 'Venta registrada automáticamente');
END;
GO