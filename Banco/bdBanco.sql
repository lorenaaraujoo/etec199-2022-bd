CREATE DATABASE bdBanco
GO

CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY IDENTITY(1,1),
	nomeCliente VARCHAR (88),
	cpfCliente VARCHAR (15)
);

GO

CREATE TABLE tbContaCorrente (
	codConta INT PRIMARY KEY IDENTITY (1,1),
	numConta INT,
	saldoConta MONEY,
	codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
);
GO

CREATE TABLE tbDeposito (
	codDeposito INT PRIMARY KEY IDENTITY (1,1),
	valorDeposito MONEY,
	codConta INT FOREIGN KEY REFERENCES tbContaCorrente(codConta),
	dataDeposito SMALLDATETIME
);
GO

CREATE TABLE tbSaque (
	codSaque INT PRIMARY KEY IDENTITY (1,1),
	valorSaque MONEY,
	codConta INT FOREIGN KEY REFERENCES tbContaCorrente(codConta),
	dataSaque SMALLDATETIME
);


INSERT tbCliente(nomeCliente, cpfCliente)
Values ( 'Gabriel Goes', '000.000.000-00')
GO 

INSERT tbContaCorrente(numConta, saldoConta, codCliente)
VALUES (1748, 100000, 1) 

INSERT tbSaque(valorSaque, codConta, dataSaque)
VALUES (957, 1, GETDATE())


INSERT tbDeposito(valorDeposito, codConta, dataDeposito)
VALUES (100000, 1, GETDATE())
