# 📊 Avaliação N2 — Análise Preditiva

**Aluno:** José Victor de Farias  
**Disciplina:** Análise Preditiva  

---

## 📘 Sobre a Atividade

Esta avaliação é composta por duas partes principais:
- **Questão 1**: Análise multidimensional de dados, utilizando o modelo Star Schema com consultas OLAP (`ROLLUP`, `CUBE`, etc.).
- **Questões 2 e 3**: Implementação de um ambiente Data Warehouse (PostgreSQL) e carga de dados clínicos reais (sintéticos) para análise preditiva de insuficiência cardíaca.

---

## 🐘 Ambiente de Execução

O ambiente foi montado utilizando **Docker** com uma instância do **PostgreSQL** configurada para rodar localmente via `docker-compose`.

### 🔧 Como subir o ambiente:

```bash
docker-compose up -d
```

- Banco: `analise-preditiva`
- Porta: `5433`
- Usuário: `postgres`
- Senha: `admin123`

---

## 📦 Questão 1 — Star Schema e Consultas OLAP (Online Analytical Processing)

Tabelas criadas:
- `Estudante(estudanteID, nome, curso)`
- `Instrutor(instrutorID, curso)`
- `Aula(aulaID, instituicao, cidade, estado)`
- `Aulas_assistidas(estudanteID, instrutorID, aulaID, notas)` → **tabela fato**

As queries analíticas foram construídas com `ROLLUP`, `CUBE`, `GROUP BY`, `JOIN` e filtros, para responder perguntas como:
- Qual média por curso?
- Alunos com melhor desempenho em Joinville?
- Agrupamentos hierárquicos por geografia e cursos?

Scripts disponíveis em `questao-1/`.

---

## 🩺 Questões 2 e 3 — DW com Dataset de Saúde (ETL)

### 📁 Dataset:
- **Fonte**: [Kaggle - Heart Failure Prediction Dataset](https://www.kaggle.com/datasets/miadul/heart-failure-prediction-synthetic-dataset)
- **Formato**: `.csv`
- **Registros**: +10.000 pacientes
- **Colunas**: 20 atributos clínicos/demográficos

### 🧱 Tabela `heart_data` criada com os campos:
- age, gender, chest_pain_type, resting_bp, cholesterol, fasting_blood_sugar,
  resting_ecg, max_heart_rate, exercise_induced_angina, oldpeak, slope,
  num_major_vessels, thalassemia, diabetes, smoking_history,
  alcohol_consumption, physical_activity_level, family_history, bmi, heart_failure

### ⚙️ Processo ETL:
- EXTRAÇÃO: leitura do `.csv` original com todas as colunas
- TRANSFORMAÇÃO: ajuste de tipos (ex: BOOLEAN, NUMERIC, VARCHAR)
- CARGA: comando `COPY` via `load_heart_data.sql`

Scripts disponíveis em `questao-2-e-3/`.

---

## 📁 Estrutura do Repositório

```
.
├── docker-compose.yml
├── .gitignore
├── copiar_arquivos.sh
├── executar_scripts.sh
├── questao-1/
│   ├── star_schema_postgres.sql
│   ├── consultas.sql
│   └── Relatorio-questao-1.pdf
├── questao-2-e-3/
│   ├── create_dw.sql
│   ├── load_heart_data.sql
│   ├── heart_failure_prediction.csv
│   └── Relatorio-questao-2-e-3.pdf
│
└── README.md
```
---

## 🧠 Observações Finais

Para facilitar a execução dos scripts SQL, foram criado dois shell scripts.
### copiar_arquivos.sh
### executar_scripts.sh

O script copiar_arquivos.sh é responsável por copiar arquivos do seu repositório local para dentro do container Docker onde está rodando o PostgreSQL.

    Arquivos copiados:

    -star_schema_postgres.sql → criação das tabelas da Questão 1

    -create_dw.sql → criação da tabela heart_data da Questão 2

    -load_heart_data.sql → comando COPY da Questão 3

    -heart_failure_prediction.csv → o dataset com mais de 10.000 registros


O script executar_scripts.sh executa todos os scripts SQL diretamente no banco de dados sem entrar no container manualmente.

    Scripts executados:

    star_schema_postgres.sql → cria o Star Schema da Questão 1

    create_dw.sql → cria a estrutura da tabela heart_data

    load_heart_data.sql → insere os dados via COPY


Este projeto foi desenvolvido como parte da Avaliação N2 da disciplina de Análise Preditiva.  
Todas as soluções foram testadas em ambiente PostgreSQL Dockerizado, com ETL manual validado.  
