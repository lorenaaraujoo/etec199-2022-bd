USE bdEscolaIdiomas

-- Criar uma consulta que retorno o nome e o preço dos cursos que custam abaixo do valor médio

SELECT nomeCurso, valorCurso FROM tbCurso
WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbCurso)

-- Criar uma consulta que retorne o nome e o RG do aluno mais novo.

SELECT nomeAluno, RgAluno, dataNascAluno FROM tbAluno
WHERE dataNascAluno = (SELECT MAX (dataNascAluno)FROM tbAluno)

-- Criar uma consulta que retorne o nome do aluno mais velho.
SELECT nomeAluno, RgAluno, dataNascAluno FROM tbAluno
WHERE dataNascAluno = (SELECT MIN (dataNascAluno)FROM tbAluno)

-- Criar uma consulta que retorne o nome e o valor do curso mais caro.
SELECT nomeCurso, valorCurso FROM tbCurso
WHERE valorCurso = (SELECT MAX(valorCurso) FROM tbCurso)

-- Criar uma consulta que retorne o nome do aluno e o nome do curso, do aluno que fez a última matrícula.
SELECT nomeAluno, nomeCurso FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso = tbTurma.codCurso
WHERE dataMatricula = (SELECT MAX(dataMatricula) FROM tbMatricula)

-- Criar uma consulta que retorne o nome do primeiro aluno a ser matriculado na escola de Idiomas.
SELECT nomeAluno, nomeCurso FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso = tbTurma.codCurso
WHERE dataMatricula = (SELECT MIN(dataMatricula) FROM tbMatricula)

-- Criar uma consulta que retorne o nome, rg e data de nascimento de todos os alunos que estejam matriculados no curso de inglês.

SELECT nomeAluno, rgAluno, dataNascAluno, nomeCurso FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso = tbTurma.codCurso
WHERE nomeCurso IN (SELECT (nomeCurso) FROM tbCurso WHERE nomeCurso LIKE 'Inglês')


