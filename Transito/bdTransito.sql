CREATE DATABASE bdTransito
GO
USE bdTransito

CREATE TABLE tbMotorista(
	codMotorista INT PRIMARY KEY IDENTITY (1,1),
	nomeMotorista VARCHAR(90),
	dataNascMotorista SMALLDATETIME,
	cpfMotorista VARCHAR (14),
	CNHMotorista INT,
	pontuacaoAcumulada INT
);
GO

CREATE TABLE tbVeiculo(
	codVeiculo INT PRIMARY KEY IDENTITY (1,1),
	modeloVeiculo VARCHAR (90),
	placa VARCHAR (10),
	renavam INT,
	anoVeiculo INT,
	codMotorista INT FOREIGN KEY REFERENCES tbMotorista(codMotorista)
);
GO

CREATE TABLE tbMultas(
	codMulta INT PRIMARY KEY IDENTITY (1,1),
	dataMulta SMALLDATETIME,
	horaMulta SMALLDATETIME,
	pontosMulta INT,
	codVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(codVeiculo)
);
GO

