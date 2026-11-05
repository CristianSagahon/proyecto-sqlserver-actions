USE EmpresaDB;
GO

DROP TRIGGER   IF EXISTS trg_AuditarVenta;
DROP PROCEDURE IF EXISTS sp_RegistrarAuditoria;
DROP TYPE      IF EXISTS dbo.VentasTipo;
GO

CREATE TYPE dbo.VentasTipo AS TABLE(
    VentaID  INT PRIMARY KEY,
    Producto VARCHAR(100),
    Cantidad INT
);
GO

CREATE PROCEDURE sp_RegistrarAuditoria
    @Ventas dbo.VentasTipo READONLY
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaVentas(VentaID, Mensaje)
    SELECT VentaID, 'Venta registrada automáticamente'
    FROM @Ventas;
END;
GO