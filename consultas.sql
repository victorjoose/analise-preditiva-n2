-- Consultas analíticas
-- a)
SELECT e.nome, a.instituicao, aa.notas
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.estado = 'Santa Catarina'
  AND i.curso <> e.curso
  AND aa.notas > 70;

-- b)
SELECT e.nome AS aluno, i.curso AS curso_instrutor, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.cidade = 'Joinville'
GROUP BY e.nome, i.curso;

-- c)
SELECT i.curso AS curso_instrutor, e.nome AS aluno, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.cidade = 'Joinville'
GROUP BY ROLLUP (i.curso, e.nome);

-- d)
SELECT e.curso, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
GROUP BY e.curso;

-- e)
SELECT e.curso AS curso_estudante, i.curso AS curso_instrutor, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
GROUP BY e.curso, i.curso;

-- f)
SELECT a.estado, a.cidade, a.instituicao, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Aula a ON aa.aulaID = a.aulaID
GROUP BY ROLLUP (a.estado, a.cidade, a.instituicao);

-- g)
SELECT a.estado, a.cidade, a.instituicao, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Aula a ON aa.aulaID = a.aulaID
GROUP BY CUBE (a.estado, a.cidade, a.instituicao);
