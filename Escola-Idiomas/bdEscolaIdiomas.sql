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

-- Exercício 01
-- Apresentar os nomes dos alunos ao lado do nome dos cursos que eles fazem;

	SELECT distinct nomeAluno AS Aluno, nomeCurso AS Curso FROM tbAluno
	INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
	INNER JOIN tbTurma ON tbTurma.codTurma = tbTurma.codTurma
	INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso

--Exercício 02
-- Apresentar a quantidade de alunos matriculados por nome do curso
	
	SELECT nomeCurso, COUNT (tbAluno.nomeAluno) AS Alunos FROM tbCurso
	INNER JOIN tbTurma ON tbTurma.codCurso = tbCurso.codCurso
	INNER JOIN tbMatricula ON tbMatricula.codTurma = tbTurma.codTurma
	INNER JOIN tbAluno ON tbAluno.codAluno = tbMatricula.codAluno
	GROUP BY nomeCurso

-- Exercício 03 
-- Apresentar a quantidade de alunos matriculados por nome da turma

	SELECT nomeTurma, COUNT (tbAluno.nomeAluno) AS Alunos FROM tbTurma
	INNER JOIN tbMatricula ON tbMatricula.codTurma = tbTurma.codTurma
	INNER JOIN tbAluno ON tbAluno.codAluno = tbMatricula.codAluno
	GROUP BY nomeTurma

-- Exercício 04
-- Apresentar a quantidade de alunos que fizeram matricula em maio de 2016

	SELECT COUNT (tbAluno.nomeAluno) AS 'ALUNOS MATRICULADOS EM MAIO DE 2016' FROM tbAluno
	INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno 
	WHERE MONTH (dataMatricula) = 05 AND YEAR (dataMatricula) = 2016

-- Exercício 05
-- Apresentar o nome dos alunos em ordem alfabética ao lado do nome das turmas em que estão matriculados

	SELECT distinct nomeAluno, nomeTurma FROM tbAluno
	INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
	INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
	ORDER BY nomeAluno ASC 

-- Exercício 06
-- Apresentar o nome dos cursos e os horários em que eles são oferecidos

	SELECT nomeCurso, horarioTurma FROM tbCurso
	INNER JOIN tbTurma ON tbCurso.codCurso = tbTurma.codTurma

-- Exercício 07
-- Apresentar a quantidade de alunos nascidos por estado

	SELECT natuAluno, COUNT(natuAluno)  AS 'Quantidade de alunos por estado' FROM tbAluno
	GROUP BY natuAluno

-- Exercício 08
-- Apresentar o nome dos alunos ao lado da data de matrícula no formato dd/mm/aaaa

	SELECT nomeAluno, CONVERT(varchar (15), dataMatricula, 103) AS 'Data da Matrícula' FROM tbAluno
	INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno

-- Exercício 09
-- Apresentar os alunos cujo nome comece com A e que estejam matriculados no curso de inglêss

	SELECT nomeAluno, nomeCurso from tbAluno
	INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codTurma
	INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
	INNER JOIN tbCurso ON  tbTurma.codCurso = tbCurso.codCurso
	WHERE nomeAluno LIKE 'M%' and tbCurso.codCurso = 1

-- Exercício 10
-- Apresentar a quantidade de matriculas feitas no ano de 2016
	
	SELECT dataMatricula, COUNT(nomeAluno) FROM tbMatricula
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
	WHERE YEAR(dataMatricula) = 2016
	GROUP BY dataMatricula
