USE bdTransito
GO
-- Criar um trigger que ao veículo tomar uma multa os pontos da multa sejam  atualizados na tabela do motorista no campo pontuacao acumulada. Caso o motorista alcance 20 pontos informar via mensagem que o mesmo poderá ter sua habilitação suspensa.
CREATE TRIGGER tgMulta
ON tbMultas AFTER INSERT
AS
	DECLARE @pontos INT;
	DECLARE @codMulta INT;
	DECLARE @codMotorista INT;
	SET @codMulta = (SELECT codMulta FROM inserted)
	SET @codMotorista = (SELECT tbMotorista.codMotorista FROM tbMotorista INNER JOIN tbVeiculo ON tbMotorista.codMotorista = tbVeiculo.codMotorista 
						INNER JOIN tbMultas ON tbVeiculo.codVeiculo = tbMultas.codVeiculo WHERE codMulta = @codMulta)
	SET @pontos = (SELECT pontosMulta FROM inserted)
	UPDATE tbMotorista 
	SET pontuacaoAcumulada = pontuacaoAcumulada + @pontos
	WHERE codMotorista = @codMotorista
GO


