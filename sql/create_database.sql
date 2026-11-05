IF DB_ID('EmpresaDB') IS NULL
    CREATE DATABASE EmpresaDB;
GO
USE EmpresaDB;
GO

DROP TABLE IF EXISTS AuditoriaVentas;
DROP TABLE IF EXISTS Ventas;
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