-- Exeríicio A
-- Listar as descrições dos produtos ao lado do nome dos fabricantes
SELECT descricaoProduto AS DESCRICAO_PRODUTO, nomeFabricante AS FABRICANTE FROM tbProduto 
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante

-- Exercício B
-- Listar as descrições dos produtos ao lado do nome dos fornecedores;
SELECT descricaoProduto AS DESCRICAO_PRODUTO, nomeFornecedor AS FORNECEDOR FROM tbProduto 
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- Exercício C
-- Listar a soma das quantidades dos produtos agrupadas pelo nome do fabricante;
SELECT DISTINCT nomeFabricante AS FABRICANTE, COUNT(tbProduto.codProduto) AS QTD_PRODUTO FROM tbProduto
INNER JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante                                                                                                                                           
GROUP BY nomeFabricante

-- exercicio D
-- Listar o total das vendas ao lado do nome do cliente;
SELECT DISTINCT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS TOTAL FROM tbVenda
INNER JOIN  tbCliente ON tbCliente.codCliente = tbVenda.codCliente
GROUP BY nomeCliente

-- Exercício E
-- Listar a média dos preços dos produtos agrupados pelo nome do fornecedor;
SELECT nomeFornecedor AS FORNECEDOR, AVG(tbProduto.valorProduto) AS MEDIA FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor
GROUP BY nomeFornecedor

-- Exercício F
-- Listar todas a soma das vendas agrupadas pelo nome do cliente em ordem alfabética;
SELECT DISTINCT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS TOTAL FROM tbVenda
INNER JOIN  tbCliente ON tbCliente.codCliente = tbVenda.codCliente
GROUP BY nomeCliente
ORDER BY nomeCliente ASC

-- Exercício G
-- Listar a soma dos preços dos produtos agrupados pelo nome do fabricante;
SELECT nomeFabricante AS FABRICANTE, SUM(tbProduto.valorProduto) AS SOMA_PRODUTOS FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante
GROUP BY nomeFabricante

-- exercicio H
-- Listar a média dos preços dos produtos agrupados pelo nome do fornecedor;
SELECT nomeFornecedor AS FORNECEDOR, SUM(tbProduto.valorProduto) AS MEDIA_PRODUTOS FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor = tbProduto.codFornecedor
GROUP BY nomeFornecedor

-- Exercício I
-- Listar a soma das vendas agrupadas pelo nome do produto
SELECT descricaoProduto AS PRODUTO, SUM(tbItensVenda.subTotalItensVenda) AS TOTAL_VENDAS FROM tbProduto
INNER JOIN tbItensVenda ON tbItensVenda.codProduto = tbProduto.codProduto
GROUP BY descricaoProduto

-- Exercício J
-- Listar a soma das vendas pelo nome do cliente somente das vendas realizadas em fevereiro de 2014
SELECT nomeCliente AS CLIENTE, SUM(tbVenda.valorTotalVenda) AS SOMA_VENDAS FROM tbVenda
INNER JOIN tbCliente ON tbVenda.codCliente = tbCliente.codCliente
WHERE MONTH(tbVenda.dataVenda) = 2 AND YEAR(tbVenda.dataVenda) = 2014
GROUP BY nomeCliente