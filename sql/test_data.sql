USE EmpresaDB;
GO
SET NOCOUNT ON;
GO


INSERT INTO Ventas(Producto, Cantidad) VALUES ('Laptop', 3);
INSERT INTO Ventas(Producto, Cantidad) VALUES ('Monitor', 5);
GO

INSERT INTO Ventas(Producto, Cantidad) VALUES
('Teclado', 4),
('Mouse',   6),
('Laptop',  1);
GO

PRINT '=== Ventas ===';
SELECT VentaID, Producto, Cantidad FROM Ventas;

PRINT '=== AuditoriaVentas ===';
SELECT AuditoriaID, VentaID, Mensaje FROM AuditoriaVentas;

PRINT '=== Comparacion ===';
SELECT
    (SELECT COUNT(*) FROM Ventas)          AS TotalVentas,
    (SELECT COUNT(*) FROM AuditoriaVentas) AS TotalAuditorias;
GO

IF (SELECT COUNT(*) FROM AuditoriaVentas) <> (SELECT COUNT(*) FROM Ventas)
    RAISERROR('ERROR: hay ventas sin auditoria', 16, 1);
ELSE
    PRINT 'OK: todas las ventas fueron auditadas';
GO