CREATE DATABASE bdEscolaIdiomas
GO
USE bdEscolaIdiomas

CREATE TABLE tbAluno(
	codAluno INT PRIMARY KEY IDENTITY(1,1)
	,nomeAluno VARCHAR (90) 
	,dataNascAluno SMALLDATETIME 
	,rgAluno VARCHAR (15) 
	,natuAluno VARCHAR (2) 
);

CREATE TABLE tbCurso(
	codCurso INT PRIMARY KEY IDENTITY(1,1)
	,nomeCurso VARCHAR (90) 
	,cargaHorariaCurso INT
	,valorCurso MONEY
);

CREATE TABLE tbTurma (
	codTurma INT PRIMARY KEY IDENTITY (1,1)
	,nomeTurma VARCHAR (90)
	,codCurso INT FOREIGN KEY REFERENCES tbCurso(codCurso)
	,horarioTurma SMALLDATETIME
);

CREATE TABLE tbMatricula(
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	,dataMatricula SMALLDATETIME
	,codAluno INT FOREIGN KEY REFERENCES tbAluno(codAluno)
	,codTurma INT FOREIGN KEY REFERENCES tbTurma(codTurma)
);

INSERT INTO tbAluno ( nomeAluno, dataNascAluno, rgAluno, natuAluno)
VALUES ('Paula Santos','2000-10-03','82.292.122-0','SP'),
		('Maria da Gloria','1999-03-10','45.233.123-0','SP'),
		('Perla Nogueira Silva','1998-04-04','23.533.211-9','SP'),
		('Gilson Barros Sailva','1995-09-09','34.221.111-X','PE'),
		('Mariana Barbosa Santos','2001-10-10','54.222.122-9','RJ')

INSERT INTO tbCurso(nomeCurso,cargaHorariaCurso,valorCurso)
VALUES 	('Inglês',2000, 356),
		('Alemão',2000, 356)

INSERT INTO tbTurma(nomeTurma,codCurso,horarioTurma)
VALUES 	('1|A', 1, '1900-01-01 12:00:00'),
		('1|B', 1, '1900-01-01 18:00:00'),
		('1AA', 2, '1900-01-01 19:00:00')

INSERT INTO tbMatricula(dataMatricula,codAluno,codTurma)
VALUES 	('2015-03-10 12:00:00', 1, 1),
		('2014-04-05 12:00:00', 2, 1),
		('2012-03-05 12:00:00', 3, 2),
		('2016-03-03 12:00:00', 1, 3),
		('2015-07-05 12:00:00', 4, 2),
		('2015-05-07 12:00:00', 4, 3),
		('2015-06-06 12:00:00', 5, 1),
		('2015-05-05 12:00:00', 5, 3)
