CREATE DATABASE GestionHospital
GO
use
GestionHospital
GO

CREATE TABLE Pacientes (
    IdPaciente INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
    ApellidoPaterno NVARCHAR(100),
    ApellidoMaterno NVARCHAR(100),
    FechaNacimiento DATE,
    Sexo CHAR(1),
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100),
    Direccion NVARCHAR(200),
	FotoPerfilRuta NVARCHAR(255) NULL
);

CREATE TABLE Especialidades (
    IdEspecialidad INT PRIMARY KEY IDENTITY(1,1),
    NombreEspecialidad NVARCHAR(100)
);

CREATE TABLE Doctores (
    IdDoctor INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
	ApellidoPaterno NVARCHAR(100),
    ApellidoMaterno NVARCHAR(100),
    EspecialidadId INT,
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100),
	FotoPerfilRuta NVARCHAR(255) NULL,
    FOREIGN KEY (EspecialidadId) REFERENCES Especialidades(IdEspecialidad)
);


CREATE TABLE Consultas (
    IdConsulta INT PRIMARY KEY IDENTITY(1,1),
    IdPaciente INT,
    IdDoctor INT,
    FechaConsulta DATETIME,
    Diagnostico NVARCHAR(500),
    FOREIGN KEY (IdPaciente) REFERENCES Pacientes(IdPaciente),
    FOREIGN KEY (IdDoctor) REFERENCES Doctores(IdDoctor)
);


CREATE TABLE Recetas (
    IdReceta INT PRIMARY KEY IDENTITY(1,1),
    IdConsulta INT UNIQUE,
    Medicamentos NVARCHAR(500),
    Indicaciones NVARCHAR(500),
    FechaEntrega DATETIME,
    FOREIGN KEY (IdConsulta) REFERENCES Consultas(IdConsulta)
);


CREATE TABLE Expedientes (
    IdExpediente INT PRIMARY KEY IDENTITY(1,1),
    IdPaciente INT,
    IdConsulta INT,
    Observaciones NVARCHAR(500),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IdPaciente) REFERENCES Pacientes(IdPaciente),
    FOREIGN KEY (IdConsulta) REFERENCES Consultas(IdConsulta)
);


CREATE TABLE UsuariosSistema (
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Usuario NVARCHAR(50) UNIQUE,
    Contrasena NVARCHAR(100),
    Rol NVARCHAR(50) -- Ej: "Administrador", "Doctor"
);

GO
CREATE TRIGGER TRG_InsertarExpedienteDesdeConsulta
ON Consultas
AFTER INSERT
AS
BEGIN
    INSERT INTO Expedientes (IdPaciente, IdConsulta, Observaciones)
    SELECT i.IdPaciente, i.IdConsulta, 'Consulta registrada automáticamente'
    FROM inserted i;
END;
GO

GO
CREATE TRIGGER TRG_ValidarUnaRecetaPorConsulta
ON Recetas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Recetas r
        JOIN inserted i ON r.IdConsulta = i.IdConsulta
    )
    BEGIN
        RAISERROR('Ya existe una receta para esta consulta.', 16, 1);
        RETURN;
    END

    INSERT INTO Recetas (IdConsulta, Medicamentos, Indicaciones, FechaEntrega)
    SELECT IdConsulta, Medicamentos, Indicaciones, FechaEntrega FROM inserted;
END;
GO


GO
CREATE TABLE BitacoraConsultas (
    IdLog INT PRIMARY KEY IDENTITY(1,1),
    IdPaciente INT,
    FechaEvento DATETIME DEFAULT GETDATE(),
    Mensaje NVARCHAR(255)
);
GO

GO
CREATE TRIGGER TRG_NotificarNuevaConsulta
ON Consultas
AFTER INSERT
AS
BEGIN
    INSERT INTO BitacoraConsultas (IdPaciente, Mensaje)
    SELECT IdPaciente, 
           CONCAT('Se registró una nueva consulta médica el ', CONVERT(NVARCHAR, GETDATE(), 120))
    FROM inserted;
END;
GO

GO
CREATE VIEW vw_ResumenConsultaPacientes AS
SELECT 
    c.IdConsulta,
    p.Nombre + ' ' + p.ApellidoPaterno + ' ' +p.ApellidoMaterno AS Paciente,
    d.Nombre + ' ' + d.ApellidoPaterno + ' ' + d.ApellidoMaterno AS Doctor,
    e.NombreEspecialidad,
    c.FechaConsulta,
    c.Diagnostico
FROM Consultas c
JOIN Pacientes p ON c.IdPaciente = p.IdPaciente
JOIN Doctores d ON c.IdDoctor = d.IdDoctor
JOIN Especialidades e ON d.EspecialidadId = e.IdEspecialidad;
GO

GO
CREATE VIEW vw_HistorialMedicamentosPacientes AS
SELECT 
    p.Nombre + ' ' + p.ApellidoPaterno + ' ' +p.ApellidoMaterno AS Paciente,
    d.Nombre + ' ' + d.ApellidoPaterno + ' ' + d.ApellidoMaterno AS Doctor,
    r.Medicamentos,
    r.Indicaciones,
    r.FechaEntrega
FROM Recetas r
JOIN Consultas c ON r.IdConsulta = c.IdConsulta
JOIN Pacientes p ON c.IdPaciente = p.IdPaciente
JOIN Doctores d ON c.IdDoctor = d.IdDoctor;
GO

GO
CREATE VIEW vw_ProximasConsultasPorEspecialidad AS
SELECT 
    e.NombreEspecialidad,
    d.Nombre + ' ' + d.ApellidoPaterno + ' ' + d.ApellidoMaterno AS Doctor,
    p.Nombre + ' ' + p.ApellidoMaterno + ' ' + p.ApellidoMaterno AS Paciente,
    c.FechaConsulta,
    c.Diagnostico
FROM Consultas c
JOIN Pacientes p ON c.IdPaciente = p.IdPaciente
JOIN Doctores d ON c.IdDoctor = d.IdDoctor
JOIN Especialidades e ON d.EspecialidadId = e.IdEspecialidad
WHERE CAST(c.FechaConsulta AS DATE) >= CAST(GETDATE() AS DATE);
GO


CREATE PROCEDURE Pacientes_Insertar
    @Nombre NVARCHAR(100),
    @ApellidoPaterno NVARCHAR(100),
    @ApellidoMaterno NVARCHAR(100),
    @FechaNacimiento DATE,
    @Sexo CHAR(1),
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @FotoPerfilRuta NVARCHAR(255) = NULL
AS
BEGIN
    INSERT INTO Pacientes (
        Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento,
        Sexo, Telefono, Correo, Direccion, FotoPerfilRuta
    )
    VALUES (
        @Nombre, @ApellidoPaterno, @ApellidoMaterno, @FechaNacimiento,
        @Sexo, @Telefono, @Correo, @Direccion, @FotoPerfilRuta
    );
END;
GO

CREATE PROCEDURE Pacientes_Actualizar
    @IdPaciente INT,
    @Nombre NVARCHAR(100) = null,
    @ApellidoPaterno NVARCHAR(100) = null,
    @ApellidoMaterno NVARCHAR(100) = null,
    @FechaNacimiento DATE = null,
    @Sexo CHAR(1) = null,
    @Telefono NVARCHAR(20) = null,
    @Correo NVARCHAR(100) = null,
    @Direccion NVARCHAR(200) = null,
    @FotoPerfilRuta NVARCHAR(255) = NULL
AS
BEGIN
    UPDATE Pacientes
    SET 
        Nombre = ISNULL(@Nombre, Nombre),
        ApellidoPaterno = ISNULL(@ApellidoPaterno, ApellidoPaterno),
        ApellidoMaterno = ISNULL(@ApellidoMaterno, ApellidoMaterno),
        FechaNacimiento = ISNULL(@FechaNacimiento, FechaNacimiento),
        Sexo = ISNULL(@Sexo, Sexo),
        Telefono = ISNULL(@Telefono,Telefono),
        Correo = ISNULL(@Correo, Correo),
        Direccion = ISNULL(@Direccion, Direccion),
        FotoPerfilRuta = ISNULL(@FotoPerfilRuta, FotoPerfilRuta)
    WHERE IdPaciente = @IdPaciente;
END;
GO

CREATE PROCEDURE Pacientes_Eliminar
    @IdPaciente INT
AS
BEGIN
    DELETE FROM Pacientes WHERE IdPaciente = @IdPaciente;
END;
GO

CREATE PROCEDURE Pacientes_ObtenerPorId
    @IdPaciente INT
AS
BEGIN
    SELECT * FROM Pacientes WHERE IdPaciente = @IdPaciente;
END;
GO

CREATE PROCEDURE Pacientes_ObtenerTodos
AS
BEGIN
    SELECT * FROM Pacientes;
END;
GO
--------

CREATE PROCEDURE Especialidades_Insertar
    @NombreEspecialidad NVARCHAR(100)
AS
BEGIN
    INSERT INTO Especialidades (NombreEspecialidad)
    VALUES (@NombreEspecialidad);
END;
GO

-- Procedimiento para actualizar una especialidad existente
CREATE PROCEDURE Especialidades_Actualizar
    @IdEspecialidad INT,
    @NombreEspecialidad NVARCHAR(100) = NULL
AS
BEGIN
    UPDATE Especialidades
    SET 
        NombreEspecialidad = ISNULL(@NombreEspecialidad, NombreEspecialidad)
    WHERE IdEspecialidad = @IdEspecialidad;
END;
GO

-- Procedimiento para eliminar una especialidad
CREATE PROCEDURE Especialidades_Eliminar
    @IdEspecialidad INT
AS
BEGIN
    DELETE FROM Especialidades 
    WHERE IdEspecialidad = @IdEspecialidad;
END;
GO

-- Procedimiento para obtener una especialidad por su ID
CREATE PROCEDURE Especialidades_ObtenerPorId
    @IdEspecialidad INT
AS
BEGIN
    SELECT * FROM Especialidades 
    WHERE IdEspecialidad = @IdEspecialidad;
END;
GO

-- Procedimiento para obtener todas las especialidades
CREATE PROCEDURE Especialidades_ObtenerTodos
AS
BEGIN
    SELECT * FROM Especialidades;
END;
GO

-- Procedimiento para buscar especialidades por nombre (búsqueda parcial)
CREATE PROCEDURE Especialidades_BuscarPorNombre
    @TextoBusqueda NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Especialidades
    WHERE NombreEspecialidad LIKE '%' + @TextoBusqueda + '%'
END;
GO

----------

CREATE PROCEDURE Doctores_Insertar
    @Nombre NVARCHAR(100),
    @ApellidoPaterno NVARCHAR(100),
    @ApellidoMaterno NVARCHAR(100),
    @EspecialidadId INT,
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @FotoPerfilRuta NVARCHAR(255) = NULL
AS
BEGIN
    INSERT INTO Doctores (
        Nombre, ApellidoPaterno, ApellidoMaterno, EspecialidadId, Telefono, Correo, FotoPerfilRuta
    )
    VALUES (
        @Nombre, @ApellidoPaterno, @ApellidoMaterno, @EspecialidadId, @Telefono, @Correo, @FotoPerfilRuta
    );
END;
GO

CREATE PROCEDURE Doctores_Actualizar
    @IdDoctor           INT,
    @Nombre             NVARCHAR(100)        = NULL,
    @ApellidoPaterno    NVARCHAR(100)        = NULL,
    @ApellidoMaterno    NVARCHAR(100)        = NULL,
    @EspecialidadId     INT                  = NULL,
    @Telefono           NVARCHAR(20)         = NULL,
    @Correo             NVARCHAR(100)        = NULL,
    @FotoPerfilRuta     NVARCHAR(255)        = NULL
AS
BEGIN
    UPDATE Doctores
    SET 
        Nombre          = ISNULL(@Nombre,          Nombre),
        ApellidoPaterno = ISNULL(@ApellidoPaterno, ApellidoPaterno),
        ApellidoMaterno = ISNULL(@ApellidoMaterno, ApellidoMaterno),
        EspecialidadId  = ISNULL(@EspecialidadId,  EspecialidadId),
        Telefono        = ISNULL(@Telefono,        Telefono),
        Correo          = ISNULL(@Correo,          Correo),
        FotoPerfilRuta  = ISNULL(@FotoPerfilRuta,  FotoPerfilRuta)
    WHERE IdDoctor = @IdDoctor;
END;
GO


CREATE PROCEDURE Doctores_Eliminar
    @IdDoctor INT
AS
BEGIN
    DELETE FROM Doctores WHERE IdDoctor = @IdDoctor;
END;
GO

CREATE PROCEDURE Doctores_ObtenerPorId
    @IdDoctor INT
AS
BEGIN
    SELECT * FROM Doctores WHERE IdDoctor = @IdDoctor;
END;
GO

CREATE PROCEDURE Doctores_ObtenerTodos
AS
BEGIN
    SELECT * FROM Doctores;
END;
GO


------

CREATE PROCEDURE Consultas_Insertar
    @IdPaciente INT,
    @IdDoctor INT,
    @FechaConsulta DATETIME,
    @Diagnostico NVARCHAR(500)
AS
BEGIN
    INSERT INTO Consultas (IdPaciente, IdDoctor, FechaConsulta, Diagnostico)
    VALUES (@IdPaciente, @IdDoctor, @FechaConsulta, @Diagnostico);
END;
GO

CREATE PROCEDURE Consultas_Actualizar
    @IdConsulta INT,
    @IdPaciente INT,
    @IdDoctor INT,
    @FechaConsulta DATETIME,
    @Diagnostico NVARCHAR(500)
AS
BEGIN
    UPDATE Consultas
    SET 
        IdPaciente = @IdPaciente,
        IdDoctor = @IdDoctor,
        FechaConsulta = @FechaConsulta,
        Diagnostico = @Diagnostico
    WHERE IdConsulta = @IdConsulta;
END;
GO

CREATE PROCEDURE Consultas_Eliminar
    @IdConsulta INT
AS
BEGIN
    DELETE FROM Consultas WHERE IdConsulta = @IdConsulta;
END;
GO

CREATE PROCEDURE Consultas_ObtenerPorId
    @IdConsulta INT
AS
BEGIN
    SELECT * FROM Consultas WHERE IdConsulta = @IdConsulta;
END;
GO

CREATE PROCEDURE Consultas_ObtenerTodos
AS
BEGIN
    SELECT * FROM Consultas;
END;
GO


------------

CREATE PROCEDURE Recetas_Insertar
    @IdConsulta INT,
    @Medicamentos NVARCHAR(500),
    @Indicaciones NVARCHAR(500),
    @FechaEntrega DATETIME
AS
BEGIN
    INSERT INTO Recetas (IdConsulta, Medicamentos, Indicaciones, FechaEntrega)
    VALUES (@IdConsulta, @Medicamentos, @Indicaciones, @FechaEntrega);
END;
GO

CREATE PROCEDURE Recetas_Actualizar
    @IdReceta INT,
    @Medicamentos NVARCHAR(500),
    @Indicaciones NVARCHAR(500),
    @FechaEntrega DATETIME
AS
BEGIN
    UPDATE Recetas
    SET 
        Medicamentos = @Medicamentos,
        Indicaciones = @Indicaciones,
        FechaEntrega = @FechaEntrega
    WHERE IdReceta = @IdReceta;
END;
GO

CREATE PROCEDURE Recetas_Eliminar
    @IdReceta INT
AS
BEGIN
    DELETE FROM Recetas WHERE IdReceta = @IdReceta;
END;
GO

CREATE PROCEDURE Recetas_ObtenerPorId
    @IdReceta INT
AS
BEGIN
    SELECT * FROM Recetas WHERE IdReceta = @IdReceta;
END;
GO

CREATE PROCEDURE Recetas_ObtenerTodos
AS
BEGIN
    SELECT * FROM Recetas;
END;
GO


-------------

CREATE PROCEDURE Expedientes_Insertar
    @IdPaciente INT,
    @IdConsulta INT,
    @Observaciones NVARCHAR(500)
AS
BEGIN
    INSERT INTO Expedientes (IdPaciente, IdConsulta, Observaciones)
    VALUES (@IdPaciente, @IdConsulta, @Observaciones);
END;
GO

CREATE PROCEDURE Expedientes_Actualizar
    @IdExpediente INT,
    @Observaciones NVARCHAR(500)
AS
BEGIN
    UPDATE Expedientes
    SET Observaciones = @Observaciones
    WHERE IdExpediente = @IdExpediente;
END;
GO

CREATE PROCEDURE Expedientes_Eliminar
    @IdExpediente INT
AS
BEGIN
    DELETE FROM Expedientes WHERE IdExpediente = @IdExpediente;
END;
GO

CREATE PROCEDURE Expedientes_ObtenerPorId
    @IdExpediente INT
AS
BEGIN
    SELECT * FROM Expedientes WHERE IdExpediente = @IdExpediente;
END;
GO

CREATE PROCEDURE Expedientes_ObtenerTodos
AS
BEGIN
    SELECT * FROM Expedientes;
END;
GO
----------
CREATE PROCEDURE UsuariosSistema_Insertar
    @Usuario NVARCHAR(50),
    @Contrasena NVARCHAR(100),
    @Rol NVARCHAR(50)
AS
BEGIN
    INSERT INTO UsuariosSistema (Usuario, Contrasena, Rol)
    VALUES (@Usuario, @Contrasena, @Rol);
END;
GO

CREATE PROCEDURE UsuariosSistema_Actualizar
    @IdUsuario INT,
    @Usuario NVARCHAR(50),
    @Contrasena NVARCHAR(100),
    @Rol NVARCHAR(50)
AS
BEGIN
    UPDATE UsuariosSistema
    SET 
        Usuario = @Usuario,
        Contrasena = @Contrasena,
        Rol = @Rol
    WHERE IdUsuario = @IdUsuario;
END;
GO

CREATE PROCEDURE UsuariosSistema_Eliminar
    @IdUsuario INT
AS
BEGIN
    DELETE FROM UsuariosSistema WHERE IdUsuario = @IdUsuario;
END;
GO

CREATE PROCEDURE UsuariosSistema_ObtenerPorId
    @IdUsuario INT
AS
BEGIN
    SELECT * FROM UsuariosSistema WHERE IdUsuario = @IdUsuario;
END;
GO

CREATE PROCEDURE UsuariosSistema_ObtenerTodos
AS
BEGIN
    SELECT * FROM UsuariosSistema;
END;
GO
