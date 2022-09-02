USE bdBanco
-- Ao ser feito um depósito atualize o saldo da conta corrente somando a quantia depositada. Ao ser feito um saque atualize o saldo da conta corrente descontando o valor caso tenha saldo suficiente.
CREATE TRIGGER tgDeposito
ON tbDeposito AFTER INSERT
AS	
	DECLARE @deposito MONEY;
	DECLARE @conta INT;
	SET @conta = (SELECT codConta FROM inserted)
	SET @deposito = (SELECT valorDeposito FROM inserted)
	UPDATE tbContaCorrente
	SET saldoConta = saldoConta + @deposito
	WHERE codConta = @conta

CREATE TRIGGER tgSaque
ON tbSaque AFTER INSERT
AS	
	DECLARE @saque MONEY;
	DECLARE @conta INT;
	SET @conta = (SELECT codConta FROM inserted)
	SET @saque = (SELECT valorSaque FROM inserted)
	UPDATE tbContaCorrente
	SET saldoConta = saldoConta - @saque
	WHERE codConta = @conta
