Create database Agencia_de_viajes
use Agencia_de_viajes

-- Tabla Clientes
CREATE TABLE Clientes (
    ClienteID VARCHAR (50)PRIMARY KEY,
    Nombre VARCHAR(50),
	Apellido VARCHAR(50), 
    Email VARCHAR(50),
	Telefono VARCHAR (50)
);
INSERT INTO Clientes (ClienteID, Nombre, Apellido, Email, Telefono)
VALUES
    ('C1', 'Juan', 'P�rez', 'juan@example.com', '77591262'),
    ('C2', 'Mar�a', 'G�mez', 'maria@example.com', '98591262'),
    ('C3', 'Carlos', 'L�pez', 'carlos@example.com', '71585720');


-- Tabla Destinos
CREATE TABLE Destinos (
    DestinoID VARCHAR (50) PRIMARY KEY,
    NombreDestino VARCHAR(50),
    Descripcion VARCHAR(50),
	PrecioBase VARCHAR (50)
);
INSERT INTO Destinos (DestinoID, NombreDestino, Descripcion, PrecioBase)
VALUES
    ('D1', 'Par�s', 'Ciudad del amor', '1000.00'),
    ('D2', 'Nueva York', 'La ciudad que nunca duerme', '1200.00'),
    ('D3', 'Tokio', 'Capital tecnol�gica de Asia', '1500.00');
-- Tabla Paquetes
CREATE TABLE Paquetes (
    PaqueteID VARCHAR (50)PRIMARY KEY,
    NombrePaquete VARCHAR(50),
    Descripcion VARCHAR (50),
	FechaInicio DATE,
	FechaFin DATE,
    DestinoID VARCHAR (50),
	Precio_Total Varchar (50)
);
INSERT INTO Paquetes (PaqueteID, NombrePaquete, Descripcion, FechaInicio, FechaFin, DestinoID, Precio_Total)
VALUES
    ('P1', 'Vacaciones en Par�s', 'Explora la belleza de Par�s', '2023-01-01', '2023-01-10', 'D1', '2500.00'),
    ('P2', 'Aventura en Nueva York', 'Descubre la vida en la Gran Manzana', '2023-02-15', '2023-02-25', 'D2', '2800.00'),
    ('P3', 'Tokio Tech Tour', 'Sum�rgete en la tecnolog�a japonesa', '2023-03-20', '2023-03-30', 'D3', '3000.00');

-- Tabla Reservas
CREATE TABLE Reservas (
    ReservaID VARCHAR (50)PRIMARY KEY,
	DestinoID VARCHAR (50),
    ClienteID VARCHAR (50),
    PaqueteID VARCHAR (50),
    FechaReserva DATE,
	Cantidadpersonas VARCHAR (50),
	Preciototal VARCHAR (50),
	Estadoreserva VARCHAR (50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (DestinoID) REFERENCES Destinos(DestinoID),
    FOREIGN KEY (PaqueteID) REFERENCES Paquetes(PaqueteID)
);
INSERT INTO Reservas (ReservaID, DestinoID, ClienteID, PaqueteID, FechaReserva, CantidadPersonas, PrecioTotal, EstadoReserva)
VALUES
    ('R1', 'D1', 'C1', 'P1', '2023-01-05', '2', '3000.00', 'Confirmada'),
    ('R2', 'D2', 'C2', 'P2', '2023-02-20', '1', '2800.00', 'Pendiente'),
    ('R3', 'D3', 'C3', 'P3', '2023-03-25', '4', '12000.00', 'Confirmada');

-- Tabla Empleados
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    NombreEmpleado VARCHAR(50),
	ApellidoEmpleado VARCHAR(50),
	emailempleado VARCHAR(50),
    Cargo VARCHAR(50)
);
INSERT INTO Empleados (EmpleadoID, NombreEmpleado, ApellidoEmpleado, EmailEmpleado, Cargo)
VALUES
    (1, 'Juan', 'Garc�a', 'juan.garcia@example.com', 'Gerente'),
    (2, 'Mar�a', 'L�pez', 'maria.lopez@example.com', 'Agente de Viajes'),
    (3, 'Carlos', 'Mart�nez', 'carlos.martinez@example.com', 'Asistente');


select*from Empleados
select*from Reservas
select*from Paquetes
select*from Destinos
select*from Clientes

--Consultas--
--�Cu�les son los empleados que tienen el t�tulo "Agente de Ventas"?--
SELECT *
FROM Empleados
WHERE Cargo = 'Agente de Viajes';

--�Cu�les son los destinos de los paquetes tur�sticos reservados por el cliente con ID 1?--
SELECT D.NombreDestino
FROM Reservas R
JOIN Paquetes P ON R.PaqueteID = P.PaqueteID
JOIN Destinos D ON P.DestinoID = D.DestinoID
WHERE R.ClienteID = '1';
--�Cu�les son los paquetes tur�sticos reservados por el cliente llamado "Jane Smith"?--

SELECT P.NombrePaquete
FROM Reservas R
JOIN Clientes C ON R.ClienteID = C.ClienteID
JOIN Paquetes P ON R.PaqueteID = P.PaqueteID
WHERE C.Nombre = 'Jane Smith';
--�Cu�les son los nombres de los clientes, los destinos de sus paquetes tur�sticos y los nombres de los empleados que gestionaron esas reservas?--
SELECT
    C.Nombre AS NombreCliente,
    D.NombreDestino AS NombreDestino,
    E.NombreEmpleado AS NombreEmpleado
FROM
    Clientes C
JOIN
    Reservas R ON C.ClienteID = R.ClienteID
JOIN
    Paquetes P ON R.PaqueteID = P.PaqueteID
JOIN
    Destinos D ON P.DestinoID = D.DestinoID
JOIN
    Empleados E ON E.EmpleadoID = E.EmpleadoID;


--�Cu�l es la cantidad total de personas que han reservado paquetes tur�sticos en la agencia?--
SELECT SUM(CAST(CantidadPersonas AS INT)) AS CantidadTotalPersonas
FROM Reservas;

--�Cu�ntas reservas se han realizado para el paquete tur�stico llamado "Aventura en Tokio"?--
SELECT COUNT(*) AS TotalReservas
FROM Paquetes P
JOIN Reservas R ON P.PaqueteID = R.PaqueteID
WHERE P.NombrePaquete = 'Aventura en Tokio';


