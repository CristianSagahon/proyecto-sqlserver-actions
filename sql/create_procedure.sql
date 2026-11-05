CREATE PROCEDURE sp_RegistrarAuditoria
    @Ventas dbo.VentasTipo READONLY
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM (SELECT Producto, SUM(Cantidad) AS Total
              FROM @Ventas GROUP BY Producto) v
        LEFT JOIN Inventario i ON i.Producto = v.Producto
        WHERE i.Producto IS NULL OR i.Existencias < v.Total
    )
        THROW 50001, 'Existencias insuficientes o producto inexistente.', 1;

    INSERT INTO AuditoriaVentas(VentaID, Mensaje)
    SELECT VentaID, CONCAT('Venta registrada: ', Cantidad, ' x ', Producto)
    FROM @Ventas;

    UPDATE i
    SET i.Existencias         = i.Existencias - v.Total,
        i.UltimaActualizacion = GETDATE()
    FROM Inventario i
    JOIN (SELECT Producto, SUM(Cantidad) AS Total
          FROM @Ventas GROUP BY Producto) v
      ON v.Producto = i.Producto;
END;
GO