
# 📊 Avaliação N2 — Análise Preditiva

**Aluno:** José Victor de Farias   
**Disciplina:** Análise Preditiva  

---

## 📘 Sobre a Atividade

Esta avaliação é composta por uma análise multidimensional de dados, utilizando o modelo Star Schema em um banco de dados relacional com suporte à função `ROLLUP` (PostgreSQL).

---

## 🐘 Ambiente de Execução

O ambiente foi montado utilizando **Docker** com uma instância do **PostgreSQL** configurada para rodar localmente via `docker-compose`.

### 🔧 Como subir o ambiente:

```bash
docker-compose up -d
```

- Banco: `PostgreSQL`
- Porta: `5433`
- Usuário padrão: `postgres`
- Senha: `admin123`

---

## 🧱 Estrutura do Banco (Star Schema)

- `Estudante(estudanteID, nome, curso)`
- `Instrutor(instrutorID, curso)`
- `Aula(aulaID, instituicao, cidade, estado)`
- `Aulas_assistidas(estudanteID, instrutorID, aulaID, notas)` → **tabela fato**

As tabelas foram criadas e populadas com dados fictícios utilizando o script SQL [`star_schema_postgresql.sql`](./star_schema_postgresql.sql).

---

## 📌 Consultas Analíticas

### a) Alunos que tiveram aulas em SC com instrutores de curso diferente e pontuação > 70

🎯 Objetivo: identificar conflitos positivos: estudantes que tiveram bons desempenhos (nota > 70) em aulas com instrutores de outra área, no estado de Santa Catarina.
🧠 Lógica:
Juntamos todas as tabelas para cruzar as informações.
Filtramos por estado e diferença entre o curso do aluno e o curso do instrutor.
Isso revela cenários onde a interdisciplinaridade ainda assim resultou em bom desempenho.

```sql
SELECT e.nome, a.instituicao, aa.notas
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.estado = 'Santa Catarina'
  AND i.curso <> e.curso
  AND aa.notas > 70;
```

### b) Média de pontuação por aluno e instrutor (Joinville)
🎯 Objetivo: descobrir qual aluno tem melhor média de notas com instrutores de cada curso em Joinville.
🧠 Lógica:
Filtramos apenas aulas ocorridas em Joinville.
Agrupamos por aluno e curso do instrutor.
Calculamos a média de notas por combinação.

```sql
SELECT e.nome AS aluno, i.curso AS curso_instrutor, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.cidade = 'Joinville'
GROUP BY e.nome, i.curso;
```

### c) Rollup por instrutor (continuação da b)
🎯 Objetivo: gerar subtotais por curso do instrutor, além das médias individuais de aluno + instrutor.
🧠 Lógica:
O ROLLUP cria:
Nível 1: aluno + curso
Nível 2: curso (total por instrutor)
Nível 3: total geral
Ideal para visão hierárquica de dados.

```sql
SELECT i.curso AS curso_instrutor, e.nome AS aluno, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
JOIN Aula a ON aa.aulaID = a.aulaID
WHERE a.cidade = 'Joinville'
GROUP BY ROLLUP (i.curso, e.nome);
```

### d) Média de notas por curso do estudante
🎯 Objetivo: medir o desempenho médio por área de formação dos estudantes.
🧠 Lógica:
Agrupamos por curso do aluno.
Extraímos a média de notas em todas as aulas que ele frequentou.

```sql
SELECT e.curso, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
GROUP BY e.curso;
```

### e) Drill-down por curso do estudante e do instrutor
🎯 Objetivo: analisar detalhadamente as interações entre cursos dos alunos e dos professores.
🧠 Lógica:
A ideia de "drill-down" é aprofundar a análise da d).
Agora observamos o cruzamento: curso do estudante X curso do instrutor.
Permite responder perguntas como: “alunos de Psicologia têm melhor desempenho com instrutores de que área?”.

```sql
SELECT e.curso AS curso_estudante, i.curso AS curso_instrutor, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Estudante e ON aa.estudanteID = e.estudanteID
JOIN Instrutor i ON aa.instrutorID = i.instrutorID
GROUP BY e.curso, i.curso;
```

### f) ROLLUP nas regiões geográficas
🎯 Objetivo: avaliar a média de notas por localização, de forma hierárquica.
🧠 Lógica:
Agrupa primeiro por instituição, depois cidade, depois estado.
Cria:
Média por instituição
Média por cidade
Média por estado
Média geral

```sql
SELECT a.estado, a.cidade, a.instituicao, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Aula a ON aa.aulaID = a.aulaID
GROUP BY ROLLUP (a.estado, a.cidade, a.instituicao);
```

### g) CUBO de médias
🎯 Objetivo: gerar todas as combinações possíveis de agregações por localização.
🧠 Lógica:
O CUBE é uma análise multidimensional total.
Permite ver:
média por estado
por cidade
por instituição
por estado + cidade
estado + instituição
cidade + instituição
e a média geral

```sql
SELECT a.estado, a.cidade, a.instituicao, AVG(aa.notas) AS media
FROM Aulas_assistidas aa
JOIN Aula a ON aa.aulaID = a.aulaID
GROUP BY CUBE (a.estado, a.cidade, a.instituicao);
```

---

## 📁 Estrutura do Repositório

```
├── docker-compose.yml          # Ambiente Docker com PostgreSQL
├── star_schema_postgresql.sql  # Script SQL com tabelas e dados
├── consulas.sql                # Script SQL com as consultas
├── .gitignore                  # Ignora dados persistentes do Docker
└── README.md                   # Este arquivo
```

---

## ✅ Como Avaliar

Durante a apresentação, serão mostradas:
1. Execução do ambiente Docker
2. Acesso ao banco via pgAdmin ou cliente SQL
3. Execução de cada consulta com explicação e saída
4. Demonstração do uso de `ROLLUP`, `CUBE`, `DRILLDOWN`, etc.

---

## 🧠 Observações Finais

Este projeto é parte da Avaliação N2 da disciplina de Análise Preditiva, e será apresentado presencialmente conforme orientações do professor.
