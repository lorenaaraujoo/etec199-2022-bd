USE bdEscolaIdiomas
-- Exercício 1 - Crie uma visão “Preço_Baixo” que exiba o código, nome do curso, carga horária e o valor do curso de todos os cursos que tenha preço inferior ao preço médio.​
	CREATE VIEW vwPreco_Baixo as
		SELECT codCurso, nomeCurso, cargaHorariaCurso, valorCurso FROM tbCurso
		WHERE valorCurso <= (SELECT AVG(valorCurso) FROM tbCurso)

		SELECT * FROM vwPreco_Baixo

-- Exercício 2 - Usando a visão “Preço_Baixo”, mostre todos os cursos ordenados por carga horária.​
	SELECT * FROM vwPreco_Baixo ORDER BY cargaHorariaCurso ASC

-- Exercício 3 - Crie uma visão “Alunos_Turma” que exiba o curso e a quantidade de alunos por turma.​
	CREATE VIEW vwAlunos_Turma AS
		SELECT nomeTurma, COUNT(tbMatricula.codMatricula) Alunos FROM tbTurma
		INNER JOIN tbMatricula ON tbMatricula.codTurma = tbTurma.codTurma
		GROUP BY nomeTurma

		SELECT * FROM vwAlunos_Turma

-- Exercício 4 - Usando a visão “Alunos_Turma” exiba a turma com maior número de alunos.​
	SELECT * FROM vwAlunos_Turma WHERE Alunos = (SELECT MAX (tbMatricula.codMatricula) FROM tbMatricula
		INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
	)

-- Exercício 5 - Crie uma visão “Turma_Curso que exiba o curso e a quantidade de turmas.​
	CREATE VIEW vwTurma_Curso AS 
		SELECT nomeCurso, COUNT(tbCurso.codCurso) Turma FROM tbCurso
		INNER JOIN tbTurma ON tbTurma.codCurso = tbCurso.codCurso
		GROUP BY nomeCurso

		SELECT * FROM vwTurma_Curso

-- Exercício 6 - Usando a visão “Turma_Curso exiba o curso com menor número de turmas.​
	SELECT MIN([nomeCurso]) AS 'Curso', MIN([Turma]) AS 'Turma' FROM vwTurma_Curso