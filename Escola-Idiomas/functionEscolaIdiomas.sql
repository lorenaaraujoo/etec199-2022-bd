USE bdEscolaIdiomas

-- Crie uma fun��o que informada uma data da matr�cula , retorne o dia da semana.
CREATE FUNCTION fc_dataMatricula (@Data date)
RETURNS VARCHAR (40) AS
BEGIN
	DECLARE @diaMatricula VARCHAR(40)
	DECLARE @dia INT

	SET @dia = DATEPART(dw, @Data)

	IF @dia = 1
	BEGIN
		SET @diaMatricula = 'Domingo'
	END 

	IF @dia = 2
	BEGIN
		SET @diaMatricula = 'Segunda-Feira'
	END 

	IF @dia = 3
	BEGIN
		SET @diaMatricula = 'Ter�a-Feira'
	END 

	IF @dia = 4
	BEGIN
		SET @diaMatricula = 'Quarta-Feira'
	END 

	IF @dia = 5
	BEGIN
		SET @diaMatricula = 'Quinta-Feira'
	END 

	IF @dia = 6
	BEGIN
		SET @diaMatricula = 'Sexta-Feira'
	END 

	IF @dia = 7
	BEGIN
		SET @diaMatricula = 'S�bado'
	END
	
	RETURN @diaMatricula 
END

SELECT MinhaFuncao=dbo.fc_dataMatricula('05/03/2005')

-- Crie uma fun��o que de acordo com a carga hor�ria do curso exiba curso r�pido ou curso extenso. (R�pido menos de 1000 horas).
CREATE FUNCTION fc_cargaHoraria (@codCurso INT)
RETURNS VARCHAR (50) AS
BEGIN
	DECLARE @cargaHorariaCurso INT
	SET @cargaHorariaCurso = (SELECT cargaHorariaCurso FROM tbCurso WHERE codCurso = @codCurso)
	DECLARE @divisao INT 
	DECLARE @retorno VARCHAR(50)
	SET @divisao = 1000

	IF @cargaHorariaCurso <= @divisao
	BEGIN
		SET @retorno = 'Curso R�pido'
	END

	IF @cargaHorariaCurso >= @divisao
	BEGIN
		SET @retorno = 'Curso Extenso'
	END
	RETURN @retorno
END

SELECT MinhaFuncao=dbo.fc_cargaHoraria(2)

-- Crie uma fun��o que de acordo com o valor do curso exiba  curso caro ou curso barato. (Curso caro acima de 400).
CREATE FUNCTION fc_valorCurso (@codCurso INT)
RETURNS VARCHAR (50) AS
BEGIN
	DECLARE @valorCurso INT
	SET @valorCurso = (SELECT valorCurso FROM tbCurso WHERE codCurso = @codCurso)
	DECLARE @divisao INT 
	DECLARE @retorno VARCHAR(50)
	SET @divisao = 400

	IF @valorCurso <= @divisao
	BEGIN
		SET @retorno = 'Curso Barato'
	END

	IF @valorCurso >= @divisao
	BEGIN
		SET @retorno = 'Curso Caro'
	END
	RETURN @retorno
END

SELECT MinhaFuncao=dbo.fc_valorCurso(2)

-- Criar uma fun��o que informada a data da matr�cula converta-a no formato dd/mm/aaaa.
CREATE FUNCTION fc_converteData (@codMatricula INT)
RETURNS VARCHAR (12) AS
BEGIN 

	DECLARE @dataMatricula DATE
	SET @dataMatricula = (SELECT dataMatricula FROM tbMatricula WHERE codMatricula = @codMatricula)
	DECLARE @dia VARCHAR(12)
	DECLARE @mes VARCHAR(12)
	DECLARE @ano VARCHAR(12)
	DECLARE @retorno VARCHAR(12)

	SET @dia = DATEPART(DAY, @dataMatricula)
	SET @mes = DATEPART(MONTH, @dataMatricula)
	SET @ano = DATEPART(YEAR, @dataMatricula)

	SET @retorno = @dia+ '/' +@mes+ '/' +@ano

	RETURN @retorno
END

SELECT MinhaFuncao=dbo.fc_converteData(2)
