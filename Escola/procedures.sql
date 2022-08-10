USE bdEscola

-- 1) Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e data de nascimento.​
CREATE PROCEDURE spBuscaAluno 
	@codAluno INT
AS
	IF EXISTS(SELECT codAluno FROM tbAluno WHERE codAluno LIKE @codAluno)
	BEGIN
		SELECT * FROM tbAluno
		WHERE codAluno LIKE @codAluno
	END
	ELSE
	BEGIN
		PRINT('Aluno não encontrado!')
	END

	EXEC spBuscaAluno 5

-- 2) Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.​
CREATE PROCEDURE spInsereAluno 
	@nomeAluno VARCHAR(90), @dataNascAluno SMALLDATETIME, @rgAluno VARCHAR(15), @natuAluno VARCHAR(2)
AS
	IF EXISTS(SELECT rgAluno FROM tbAluno WHERE rgAluno like @rgAluno)
		BEGIN
			PRINT('Erro ao cadastrar aluno! Este aluno já está cadastrado.')
		END
	ELSE
		BEGIN
			INSERT tbAluno(nomeAluno, dataNascAluno, rgAluno, natuAluno)
			values (@nomeAluno, @dataNascAluno, @rgAluno, @natuAluno);
		PRINT('Aluno '+@nomeAluno+' cadastrado com sucesso!')
		END

	EXEC spInsereAluno 'Lorena Araujo', '25-04-2005', '00.000.000-00', 'SP'

	SELECT * FROM tbAluno

-- 3) Criar uma stored procedure “Aumenta_Preco” que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada​
CREATE PROCEDURE spAumentaPreco
	@nomeCurso VARCHAR(90), @porcentagemI DECIMAL
AS
	IF EXISTS(SELECT nomeCurso FROM tbCurso WHERE nomeCurso LIKE @nomeCurso)
	BEGIN
		UPDATE tbCurso SET valorCurso = valorCurso + valorCurso*@porcentagemI/100 
			WHERE nomeCurso LIKE @nomeCurso
		SELECT * FROM tbCurso WHERE nomeCurso LIKE @nomeCurso
	END
	ELSE
	BEGIN
		PRINT('Curso não encontrado!')
	END

	EXEC spAumentaPreco 'Alemão', 50
	
	SELECT * FROM tbCurso

-- 4) Criar uma stored procedure “Exibe_Turma” que, dado o nome da turma exiba todas as informações dela.​
CREATE PROCEDURE spExibeTurma 
	@nomeTurma VARCHAR(90)
AS
	IF EXISTS(SELECT nomeTurma FROM tbTurma WHERE nomeTurma LIKE @nomeTurma)
	BEGIN
		SELECT * FROM tbTurma
		WHERE nomeTurma LIKE @nomeTurma
	END
	ELSE
	BEGIN
		PRINT('Turma não encontrada!')
	END
	
	EXEC spExibeTurma '1AA'

-- 5) Criar uma stored procedure “Exibe_AlunosdaTurma” que, dado o nome da turma exiba os seus alunos.​
CREATE PROCEDURE spExibeAlunosTurma
	@nomeTurma VARCHAR(90)
AS
	IF EXISTS(SELECT nomeTurma FROM tbTurma WHERE nomeTurma Like @nomeTurma)
	BEGIN
		SELECT nomeTurma, nomeAluno FROM tbTurma
		INNER JOIN tbMatricula on tbTurma.codTurma = tbMatricula.codTurma
		INNER JOIN tbAluno on tbAluno.codAluno = tbMatricula.codAluno
		WHERE nomeTurma Like @nomeTurma
	END
	ELSE
	BEGIN
		PRINT('Turma não encontrada!')
	END

	EXEC spExibeAlunosTurma '1AA'

-- 6) Criar uma stored procedure para inserir alunos, verificando pelo cpf se o aluno existe ou não, e informar essa condição via mensagem.
CREATE PROCEDURE sp_InsereAlunoCpf
	@nomeAluno VARCHAR(50), @dataNascAluno SMALLDATETIME, @rgAluno VARCHAR(15), @naturalidade VARCHAR(30), @cpfAluno VARCHAR(15)

	AS
		IF EXISTS(SELECT cpfAluno FROM tbAluno WHERE cpfAluno LIKE @cpfAluno)
		BEGIN 
			PRINT('CPF já existe no banco de dados!')
		END
		ELSE BEGIN
			INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno, cpfAluno)
				VALUES 
					(@nomeAluno, @dataNascAluno, @rgAluno, @naturalidade, @cpfAluno)
			PRINT('Aluno cadastrado com sucesso!')
		END

	EXEC sp_InsereAlunoCpf 'Lorena Araujo', '25-04-2005', '75.232.424-40', 'Brasil', '123.456.876-09'

	SELECT * FROM tbAluno

-- 7) Criar uma stored procedure que receba o nome do curso e o nome do aluno e matricule o mesmo no curso pretendido​​
CREATE PROCEDURE spInserirAlunoNoCurso 
	@nomeAluno VARCHAR(90), @nomeCurso VARCHAR(90)
AS
	DECLARE @codAluno INT
	DECLARE @codTurma INT
	SET @codAluno = (SELECT codAluno FROM tbAluno WHERE nomeAluno Like @nomeAluno)
	SET @codTurma = (SELECT codTurma FROM tbTurma INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso WHERE nomeCurso Like @nomeCurso)
	IF EXISTS(SELECT codAluno FROM tbMatricula WHERE codAluno = @codAluno)
	BEGIN
		PRINT('O aluno já está cadastrado em uma turma!')
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT nomeAluno FROM tbAluno WHERE nomeAluno like @nomeAluno)
		BEGIN
			INSERT tbMatricula(dataMatricula, codAluno, codTurma)
			VALUES	(GETDATE(), @codAluno, @codTurma)
			PRINT ('Aluno(a) '+@nomeAluno+' matriculado no curso de '+@nomeCurso+' com sucesso!')
		END
		ELSE
		BEGIN
			PRINT('Turma ou aluno não encontrado!')
		END
	END

	EXEC spInserirAlunoNoCurso 'Gabriel Goes', 'Alemão'