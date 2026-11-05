USE EmpresaDB;
GO

DROP TABLE IF EXISTS AuditoriaVentas;
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Inventario;
GO

CREATE TABLE Ventas(
    VentaID  INT IDENTITY(1,1) PRIMARY KEY,
    Producto VARCHAR(100),
    Cantidad INT,
    Fecha    DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE AuditoriaVentas(
    AuditoriaID   INT IDENTITY(1,1) PRIMARY KEY,
    VentaID       INT,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Mensaje       VARCHAR(255)
);
GO
CREATE TABLE Inventario(
    Producto            VARCHAR(100) PRIMARY KEY,
    Existencias         INT NOT NULL CHECK (Existencias >= 0),
    UltimaActualizacion DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Inventario(Producto, Existencias) VALUES
('Laptop',  10),
('Monitor', 20),
('Teclado', 50),
('Mouse',   50);
GO
BEGIN TRY
    INSERT INTO Ventas(Producto, Cantidad) VALUES ('Laptop', 100);
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    PRINT CONCAT('Rechazada como se esperaba: ', ERROR_MESSAGE());
END CATCH;
GO

PRINT '=== Inventario ===';
SELECT Producto, Existencias FROM Inventario;

IF (SELECT Existencias FROM Inventario WHERE Producto = 'Laptop') <> 6
    RAISERROR('ERROR: existencias de Laptop incorrectas', 16, 1);
ELSE
    PRINT 'OK: inventario correcto';
GO