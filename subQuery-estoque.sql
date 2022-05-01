USE bdEstoque

-- Criar uma consulta que retorne o código do produto, o nome do produto e o nome do fabricante somente daqueles produtos que 
-- custam igual ao valor mais alto.

SELECT codProduto, descricaoProduto, nomeFabricante FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante
WHERE valorProduto IN (SELECT MAX(valorProduto) FROM tbProduto)


-- Criar uma consulta que retorne o nome do produto, o nome do fabricante e o valor somente dos produtos que custem acima do valor
-- médio dos produtos em estoque.

SELECT descricaoProduto, nomeFabricante, valorProduto FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante = tbProduto.codFabricante
WHERE valorProduto > (SELECT AVG(valorProduto) FROM tbProduto)

-- Criar uma consulta que retorne o nome dos clientes tiveram vendas com valor acima do valor médio das vendas.

SELECT nomeCliente, valorTotalVenda FROM tbCliente
INNER JOIN tbVenda ON tbCliente.codCliente = tbVenda.codCliente
WHERE valorTotalVenda > (SELECT AVG(valorTotalVenda) FROM tbVenda)


-- Criar uma consulta quer retorne o nome e o preço dos produtos mais caros.

SELECT descricaoProduto, valorProduto FROM tbProduto
WHERE valorProduto > (SELECT AVG(valorProduto) FROM tbProduto)


-- Criar uma consulta que retorne o nome e o preço do produto mais barato.

SELECT descricaoProduto, valorProduto FROM tbProduto
WHERE valorProduto < (SELECT AVG(valorProduto) FROM tbProduto)
