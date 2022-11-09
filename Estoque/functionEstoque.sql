-- Criar uma função que retorne o dia de semana da venda (no formato segunda, terça, etc) ao lado do código da venda, valor total da venda e sua data.
CREATE FUNCTION fc_diaVenda (@codVenda INT)
RETURNS VARCHAR(190) AS
BEGIN
	DECLARE @data DATE
		SET @data = (SELECT dataVenda FROM tbVenda WHERE codVenda = @codVenda)
	DECLARE @dia INT
		SET @dia = DATEPART(dw, @data)
	DECLARE @diaSemana VARCHAR(90)
	DECLARE @retorno VARCHAR(190)
		if @dia = 1
			BEGIN
				SET @diaSemana	= 'Domingo'
			END
		if @dia = 2
			BEGIN
				SET @diaSemana	= 'Segunda-Feira'
			END
		if @dia = 3
			BEGIN
				SET @diaSemana	= 'Terça-Feira'
			END
		if @dia = 4
			BEGIN
				SET @diaSemana	= 'Quarta-Feira'
			END
		if @dia = 5
			BEGIN
				SET @diaSemana	= 'Quinta-Feira'
			END
		if @dia = 6
			BEGIN
				SET @diaSemana	= 'Sexta-Feira'
			END
		if @dia = 7
			BEGIN
				SET @diaSemana	= 'Sabado'
			END
	SET @retorno = (SELECT @diaSemana +' | '+ CONVERT(VARCHAR(10), codVenda) +' | '+ CONVERT(VARCHAR(20), valorTotalVenda) +' | '+ CONVERT(VARCHAR(40), dataVenda) FROM tbVenda WHERE codVenda = @codVenda)
	RETURN @retorno
END

SELECT MinhaFunção=dbo.fc_diaVenda(1)

-- Criar uma função que receba o código do cliente e retorne o total de vendas/compras que o cliente já realizou.
CREATE FUNCTION fc_comprasCliente(@codCliente INT)
RETURNS VARCHAR(90) AS
BEGIN
	DECLARE @retorno VARCHAR(90)
	DECLARE @valorTotalCompras MONEY
	SET @valorTotalCompras = (SELECT SUM(valorTotalVenda) FROM tbVenda WHERE codCliente = @codCliente)
	DECLARE @quantidadeCompras INT
	SET @quantidadeCompras = (SELECT COUNT(codVenda) FROM tbVenda WHERE codCliente = @codCliente)

	SET @retorno = (SELECT CONVERT(VARCHAR(30), @codCliente) +'   | Valor total das Compras  '+ CONVERT(VARCHAR(30), @valorTotalCompras) +'  | Total de Compras  '+ CONVERT(VARCHAR(30), @quantidadeCompras) FROM tbVenda WHERE codCliente = @codCliente GROUP BY codCliente)
	RETURN @retorno
END

SELECT MinhaFunção=dbo.fc_comprasCliente(2)

-- Criar uma função que receba o código de um vendedor e o mês e informe o total de vendas do vendedor no mês informado.
ALTER FUNCTION fc_vendasVendedor(@codVendedor INT, @mes DATE)
	RETURNS VARCHAR(100) AS
BEGIN
	DECLARE @retorno VARCHAR(100)
	DECLARE @Vendas INT = (SELECT COUNT(codVendedor) FROM tbVenda WHERE dataVenda LIKE @mes)
	DECLARE @data DATE = (SELECT dataVenda FROM tbVenda WHERE codVendedor = @codVendedor and dataVenda = @mes)

	SET @retorno =(SELECT 'DATA: '+CONVERT(VARCHAR(20), @data) +'|Total de vendas  '+ CONVERT(VARCHAR(10), @Vendas) FROM tbVenda WHERE codVendedor = @codVendedor)

	RETURN @retorno
END

SELECT MinhaFunção=dbo.fc_vendasVendedor(1,'0000-05-00')

-- Criar uma função que usando o bdEstoque diga se o cpf do cliente é ou não válido.
CREATE FUNCTION fc_ValidaCPF(@codCliente INT)
    RETURNS VARCHAR(15) AS
BEGIN

    DECLARE @cpfCli VARCHAR(15) = (SELECT cpfCliente FROM tbCliente WHERE @codCliente = codCliente),
    @Soma INT,
    @Indice INT,
    @Digito1 INT,
    @Digito2 INT,
    @cpf_temp VARCHAR(11),
    @DigitosIguais CHAR(1),
    @resultado VARCHAR(30)

    SET @resultado = 'N'
    SET @cpf_temp = SUBSTRING(@cpfCli,1,1)
    SET @Indice = 1
    SET @DigitosIguais = 'S'

    WHILE (@indice <= 11) BEGIN 
        IF SUBSTRING(@cpfCli,@Indice,1) <> @cpf_temp 
        SET @DigitosIguais = 'N'
        SET @Indice = @Indice + 1
    END

    IF @DigitosIguais = 'N' BEGIN
        SET @Soma = 0 
        SET @Indice = 1

    WHILE (@INDICE <= 9)BEGIN
        SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpfCli,@Indice,1)) * (11 -@INDICE);
        SET @INDICE = @INDICE + 1

    END

    SET @Digito1 = 11 -(@soma % 11)
        IF @Digito1 > 9
        SET @Digito1 = 0;

    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 10) BEGIN
        SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpfCli,@Indice,1)) * (12 -@Indice);
        SET @Indice = @Indice + 1
    END

    SET @Digito2 = 11 -(@Soma % 11)
        IF @Digito2 > 9
        SET @Digito2 = 0;

    IF (@Digito1 = SUBSTRING(@cpfCli,LEN(@cpfCli)-1,1)) AND (@Digito2 = SUBSTRING(@cpfCli,LEN(@cpfCli),1))
        SET @resultado = 'CPF VÁLIDO   | '+@cpfCli
    ELSE
        SET @resultado = 'CPF INVÁLIDO  | '+@cpfCli
    END

    RETURN @resultado
    END

    SELECT CPF=dbo.fc_ValidaCPF(5)