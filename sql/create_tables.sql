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
