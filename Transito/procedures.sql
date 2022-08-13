USE bdTransito

-- 1) Criar 3 procedures para inserir 2 motoristas, 3 veículos e 5 multa. 

CREATE PROCEDURE spInserirMotorista
	@nomeMotorista VARCHAR(90),@dataNascMotorista SMALLDATETIME, @cpfMotorista VARCHAR(14), @cnhMotorista INT, @pontuacaoAcumulada INT
AS
	IF EXISTS(SELECT cpfMotorista FROM tbMotorista WHERE cpfMotorista = @cpfMotorista)
	BEGIN
		PRINT('Motorista já está cadastrado no sistema!')
	END
	ELSE
	BEGIN
		INSERT tbMotorista(nomeMotorista, dataNascMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
		VALUES (@nomeMotorista, @dataNascMotorista, @cpfMotorista, @cnhMotorista, @pontuacaoAcumulada)
		PRINT ('Motorista '+@nomeMotorista+' cadastrado com sucesso!')
	END

	EXEC spInserirMotorista 'Gabriel Goes','05-03-2005', '134.434.235-01', 00000000001, 3
	EXEC spInserirMotorista 'Lorena Araujo','25-04-2005', '444.540.764-02', 00000000002, 15

CREATE PROCEDURE spInserirVeiculo
	@modeloVeiculo VARCHAR(90), @placa VARCHAR(10), @renavam INT, @anoVeiculo INT, @codMotorista INT
AS
	IF EXISTS(SELECT renavam FROM tbVeiculo WHERE renavam = @renavam)
	BEGIN
		PRINT('Veículo já está cadastrado no sistema!')
	END
	ELSE
	BEGIN
		INSERT tbVeiculo(modeloVeiculo, placa, renavam, anoVeiculo, codMotorista)
		VALUES (@modeloVeiculo, @placa, @renavam, @anoVeiculo, @codMotorista)
		PRINT ('Veículo '+@modeloVeiculo+' cadastrado com sucesso!')
	END

	EXEC spInserirVeiculo 'BMW M5', 'UAI0W47', 00000000001, 2022, 1  
	EXEC spInserirVeiculo 'MCLaren Senna', 'BRA8Z13', 00000000002, 2021, 1  
	EXEC spInserirVeiculo 'Chevrolet Beetle', 'BRU7L18', 00000000003, 2015, 2

CREATE PROCEDURE spInserirMulta
	@pontosMulta INT, @codVeiculo INT
AS
	IF EXISTS(SELECT dataMulta FROM tbMultas WHERE dataMulta = GETDATE())
	BEGIN
		PRINT('Multa já existente no sistema!')
	END
	ELSE
	BEGIN
		INSERT tbMultas (dataMulta, pontosMulta, codVeiculo)
		VALUES (GETDATE(), @pontosMulta, @codVeiculo)
		PRINT('Multa Cadastrada com sucesso!')
	END

	EXEC spInserirMulta 10, 3
	EXEC spInserirMulta 2, 1
	EXEC spInserirMulta 1, 2
	EXEC spInserirMulta 3, 3
	EXEC spInserirMulta 2, 3

	-- 2) Criar uma stored procedure que ao ser colocada a placa do veículo apresente-se a quantidade demultas do veículo.
	DROP PROCEDURE spVerificarCarro
CREATE PROCEDURE spVerificarCarro
	@placa VARCHAR(10)
AS
	IF EXISTS(SELECT placa FROM tbVeiculo WHERE placa LIKE @placa)
	BEGIN
		SELECT modeloVeiculo Carro, placa Placa, tbMultas.pontosMulta 'Pontos Multa' FROM tbVeiculo 
		INNER JOIN tbMultas ON tbVeiculo.codVeiculo = tbMultas.codVeiculo
		WHERE tbVeiculo.placa = @placa
	END
	ELSE
	BEGIN
		PRINT('Veiculo não encontrado no sistema!')
	END

	EXEC spVerificarCarro 'UAI0W47'
	EXEC spVerificarCarro 'BRA8Z13'
	EXEC spVerificarCarro 'BRU7L18'

	-- 3) Criar uma procedure que receba o cpf do motorista e apresenta a sua pontuação acumulada

CREATE PROCEDURE spExibePontuacao
	@cpfMotorista VARCHAR(15)
AS
	IF NOT EXISTS(SELECT cpfMotorista FROM tbMotorista WHERE cpfMotorista = @cpfMotorista) 
	BEGIN
		PRINT('Este motorista não existe!')
	END
	ELSE 
	BEGIN
		SELECT nomeMotorista AS 'Motorista', pontuacaoAcumulada AS 'Pontos acumulados' FROM tbMotorista WHERE cpfMotorista = @cpfMotorista
	END

	EXEC spExibePontuacao '134.434.235-10'