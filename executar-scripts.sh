#!/bin/bash

echo "Executando star_schema_postgres.sql..."
docker exec -i analise-preditiva psql -U postgres -d analise-preditiva < ./questao-1/star_schema_postgres.sql

echo "Executando create_dw.sql..."
docker exec -i analise-preditiva psql -U postgres -d analise-preditiva < ./questao-2-e-3/create_dw.sql

echo "Executando load_heart_data.sql (COPY)..."
docker exec -i analise-preditiva psql -U postgres -d analise-preditiva < ./questao-2-e-3/load_heart_data.sql

echo "Todos os scripts foram executados com sucesso!"
