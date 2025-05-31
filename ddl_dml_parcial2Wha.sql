CREATE DATABASE Parcial2Wha;
GO
USE [master]
GO
CREATE LOGIN [usrparcial2] WITH PASSWORD = N'12345678',
	DEFAULT_DATABASE = [Parcial2Wha],
	CHECK_EXPIRATION = OFF,
	CHECK_POLICY = ON;
GO
USE Parcial2Wha;
GO
CREATE USER [usrparcial2] FOR LOGIN [usrparcial2];
GO
ALTER ROLE [db_owner] ADD MEMBER [usrparcial2];
GO

DROP TABLE Serie;

CREATE TABLE Serie (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(250) NOT NULL,
	sinopsis VARCHAR(5000) NOT NULL,
	director VARCHAR(100) NOT NULL,
	episodios INT NOT NULL,
	fechaEstreno DATE NOT NULL,
	estado SMALLINT NOT NULL DEFAULT 1 -- -1:Eliminado, 0: Inactivo, 1: Activo)
);

GO
CREATE PROC paSerieListar @parametro VARCHAR (100)
AS
BEGIN
SELECT * FROM Serie
    WHERE estado <> -1 AND titulo+sinopsis LIKE '%' + REPLACE(@parametro, ' ', '%') + '%'
	ORDER BY estado DESC, titulo ASC;
END
GO

EXEC paSerieListar '';

INSERT INTO Serie (titulo, sinopsis, director, episodios, fechaEstreno)
VALUES ('La Casa de Papel', 
    'Un grupo de criminales se encierra en la Fábrica Nacional de Moneda y Timbre con el objetivo de realizar el atraco perfecto.', 
    'Álex Pina', 
    41, 
    '2017-05-02');

INSERT INTO Serie (titulo, sinopsis, director, episodios, fechaEstreno)
VALUES ('Stranger Things', 
    'Un grupo de niños se enfrenta a fenómenos sobrenaturales en un pequeño pueblo, mientras buscan a su amigo desaparecido y descubren una niña con poderes psíquicos.', 
    'The Duffer Brothers', 
    34, 
    '2016-07-15');

SELECT * FROM Serie;
