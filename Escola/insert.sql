USE bdEscola

INSERT INTO tbCurso(nomeCurso,cargaHorariaCurso,valorCurso)
VALUES 	('Inglês',2000, 356),
		('Alemão',2000, 356)

INSERT INTO tbTurma(nomeTurma,codCurso,horarioTurma)
VALUES 	('1|A', 1, '1900-01-01 12:00:00'),
		('1|B', 1, '1900-01-01 18:00:00'),
		('1AA', 2, '1900-01-01 19:00:00')
GO
