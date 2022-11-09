MERGE tbTurma3A dest
	USING tbTurma2A ori
	ON ori.RM = dest.RM
	WHEN NOT MATCHED AND ori.statusAprovado = 1 THEN
	INSERT VALUES(ori.RM, ori.nomeAluno, ori.statusAprovado);

MERGE tbTurma3A dest
	USING tbTurma2B ori
	ON ori.RM = dest.RM
	WHEN NOT MATCHED AND ori.statusAprovado = 1 THEN
	INSERT VALUES(ori.RM, ori.nomeAluno, ori.statusAprovado);