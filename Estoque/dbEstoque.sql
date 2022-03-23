CREATE DATABASE dbEstoque
GO
USE dbEstoque

CREATE TABLE tbFabricante (
	codFabricante INT PRIMARY KEY IDENTITY(1,1)
	,nomeFabricante VARCHAR(100) NOT NULL
);
GO

CREATE TABLE tbFornecedor (
	codFornecedor INT PRIMARY KEY IDENTITY(1,1)
	,nomeFornecedor VARCHAR(100) NOT NULL
	,contatoFornecedor NVARCHAR(100) NOT NULL 
);
GO

CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	,nomeCliente VARCHAR(100) NOT NULL
	,cpfCliente VARCHAR(11) NOT NULL 
	,emailCliente VARCHAR(50) NOT NULL  
	,sexoCliente VARCHAR(1) NOT NULL 
	,dataNascimentoCliente DATE NOT NULL 
);
GO

CREATE TABLE tbVenda (
	codVenda INT PRIMARY KEY IDENTITY(1,1)
	,dataVenda DATE NOT NULL
	,valorTotalVenda MONEY NOT NULL 
	,codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente) NOT NULL 
);
GO

CREATE TABLE tbProduto (
	codProduto INT PRIMARY KEY IDENTITY(1,1)
	,descricaoProduto VARCHAR(100) NOT NULL
	,valorProduto MONEY NOT NULL 
	,quantidadeProduto INT NOT NULL 
	,codFabricante INT FOREIGN KEY REFERENCES tbFabricante(codFabricante) NOT NULL
	,codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor(codFornecedor) NOT NULL 
);
GO

CREATE TABLE tbItensVenda (
	codItensVenda INT PRIMARY KEY IDENTITY(1,1)
	,codVenda INT FOREIGN KEY REFERENCES tbVenda(codVenda) NOT NULL 
	,codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto) NOT NULL 
	,quantidadeItensVenda INT NOT NULL
	,subTotalItensVenda MONEY NOT NULL 	
);
GO


INSERT INTO tbFabricante (nomeFabricante) VALUES
	('Unilever')
	,('P&G')
	,('Bunge');
GO

INSERT INTO tbFornecedor (nomeFornecedor, contatoFornecedor) VALUES
	('Atacadão', 'Carlos Santos')
	,('Assai','Maria Stella')
	,('Roldão','Paulo César');
GO

INSERT INTO tbCliente (nomeCliente, cpfCliente, emailCliente, sexoCliente, dataNascimentoCliente) VALUES
	('Armando José Santana', '12345678900', 'armandojsantana@outlook.com', 'm', '1961-02-21')
	,('Sheila Carvalho Leal','45678909823','scarvalho@ig.com.br','f','1978-09-13')
	,('Carlos Henrique Souza','76598278299','chenrique@ig.com.br','m','1981-09-08')
	,('Maria Aparecida Souza','87365309899','mapdasouza@outlook.com','f','1962-07-07')
	,('Adriana Nogueira Silva','76354309388','drica1977@ig.com.br','f','1977-04-09')
	,('Paulo Henrique Silva','87390123111','phsilva80@hotmail.com','m','1987-02-02');
GO

INSERT INTO tbProduto (descricaoProduto, valorProduto, quantidadeProduto, codFabricante, codFornecedor) VALUES
	('Amaciante Downy', 5.76, 1500, 2, 1)
	,('Amaciante Comfort', 5.45, 2300, 1, 1)
	,('Sabão em pó OMO', 5.99, 1280, 1, 2)
	,('Margarina Qualy', 4.76, 2500, 3, 1)
	,('Salsicha Hot Dog Sadia', 6.78, 2900, 3, 2)
	,('Mortadela Perdigão', 2.50, 1200, 3, 3)
	,('Hamburguer Sadia', 9.89, 1600, 3, 1)
	,('Fralda Pampers', 36.00, 340, 2, 3)
	,('Xampu Seda', 5.89, 800, 1, 2)
	,('Condicionador Seda', 6.50, 700, 1, 3);
GO

INSERT INTO tbVenda(dataVenda, valorTotalVenda, codCliente) VALUES 
	('2014-02-01', 4500, 1)
	,('2014-02-03', 3400, 1)
	,('2014-02-10', 2100, 2)
	,('2014-02-15', 2700, 3)
	,('2014-03-17', 560, 3)
	,('2014-04-09', 1200, 4)
	,('2014-05-07', 3500, 5)
	,('2014-05-07', 3400, 1)
	,('2014-05-05', 4000, 2);
GO

INSERT INTO tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda) VALUES 
	(1, 1, 200, 4500)
	,(1, 2, 300, 3000)
	,(2, 4, 120, 1400)
	,(2, 2, 200, 1000)
	,(2, 3, 130, 1000)
	,(3, 5, 200, 2100)
	,(4, 4, 120, 1000)
	,(4, 5, 450, 700)
	,(1, 2, 300, 3000)
	,(5, 5, 300, 3000)
	,(6, 7, 200, 600)
	,(6, 6, 300, 600)
	,(8, 1, 300, 2500)
	,(8, 2, 200, 1000)
	,(9, 6, 250, 1700)
	,(9, 5, 200, 1700)
	,(9, 4, 1000, 4000);
GO

-- exercicio A
-- Listar as descrições dos produtos ao lado do nome dos fabricantes
SELECT descricaoProduto AS DESCRICAO_PRODUTO, nomeFabricante AS FABRICANTE FROM tbProduto 
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante

-- exercicio B
-- Listar as descrições dos produtos ao lado do nome dos fornecedores;
SELECT descricaoProduto AS DESCRICAO_PRODUTO, nomeFornecedor AS FORNECEDOR FROM tbProduto 
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- exercicio C
-- Listar a soma das quantidades dos produtos agrupadas pelo nome do fabricante;
SELECT DISTINCT nomeFabricante AS FABRICANTE, COUNT(tbProduto.codProduto) AS QTD_PRODUTO FROM tbProduto
INNER JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante                                                                                                                                            
GROUP BY nomeFabricante

-- exercicio D
-- Listar o total das vendas ao lado do nome do cliente;
SELECT DISTINCT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS TOTAL FROM tbVenda
INNER JOIN  tbCliente ON tbCliente.codCliente = tbVenda.codCliente
GROUP BY nomeCliente

-- exercicio E
-- Listar a média dos preços dos produtos agrupados pelo nome do fornecedor;
SELECT nomeFornecedor AS FORNECEDOR, AVG(tbProduto.valorProduto) AS MEDIA FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor
GROUP BY nomeFornecedor

-- exercicio F
-- Listar todas a soma das vendas agrupadas pelo nome do cliente em ordem alfabética;
SELECT DISTINCT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS TOTAL FROM tbVenda
INNER JOIN  tbCliente ON tbCliente.codCliente = tbVenda.codCliente
GROUP BY nomeCliente
ORDER BY nomeCliente ASC

-- exercicio G
-- Listar a soma dos preços dos produtos agrupados pelo nome do fabricante;
SELECT nomeFabricante AS FABRICANTE, SUM(tbProduto.valorProduto) AS SOMA_PRODUTOS FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante
GROUP BY nomeFabricante

-- exercicio H
-- Listar a média dos preços dos produtos agrupados pelo nome do fornecedor;
SELECT nomeFornecedor AS FORNECEDOR, SUM(tbProduto.valorProduto) AS MEDIA_PRODUTOS FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor
GROUP BY nomeFornecedor

-- exercicio I
-- Listar a soma das vendas agrupadas pelo nome do produto
SELECT descricaoProduto AS PRODUTO, SUM(tbItensVenda.subTotalItensVenda) AS TOTAL_VENDAS FROM tbProduto
INNER JOIN tbItensVenda ON tbItensVenda.codProduto = tbProduto.codProduto
GROUP BY descricaoProduto

-- exercicio J
-- Listar a soma das vendas pelo nome do cliente somente das vendas realizadas em fevereiro de 2014
SELECT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS SOMA_VENDAS FROM tbVenda
INNER JOIN tbCliente ON tbVenda.codCliente = tbCliente.codCliente
WHERE MONTH(tbVenda.dataVenda) = 2 AND YEAR(tbVenda.dataVenda) = 2014
GROUP BY nomeCliente
