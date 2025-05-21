#!/bin/bash

echo "Copiando arquivos para dentro do container Docker..."

# Questão 1
docker cp ./questao-1/star_schema_postgres.sql analise-preditiva:/tmp/star_schema_postgres.sql

# Questão 2
docker cp ./questao-2-e-3/create_dw.sql analise-preditiva:/tmp/create_dw.sql

# Questão 3
docker cp ./questao-2-e-3/load_heart_data.sql analise-preditiva:/tmp/load_heart_data.sql
docker cp ./questao-2-e-3/heart_failure_prediction.csv analise-preditiva:/tmp/heart_failure_prediction.csv

echo "Arquivos copiados com sucesso!"
