-- ===================================================
-- Esquema Star Schema para Análise Multidimensional
-- ===================================================

-- Tabela dimensão: Estudante
CREATE TABLE Estudante (
    estudanteID SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    curso VARCHAR(100)
);

-- Tabela dimensão: Instrutor
CREATE TABLE Instrutor (
    instrutorID SERIAL PRIMARY KEY,
    curso VARCHAR(100)
);

-- Tabela dimensão: Aula
CREATE TABLE Aula (
    aulaID SERIAL PRIMARY KEY,
    instituicao VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(100)
);

-- Tabela fato: Aulas_assistidas
CREATE TABLE Aulas_assistidas (
    estudanteID INT REFERENCES Estudante(estudanteID),
    instrutorID INT REFERENCES Instrutor(instrutorID),
    aulaID INT REFERENCES Aula(aulaID),
    notas NUMERIC(5,2)
);

-- Inserção de dados nas tabelas
INSERT INTO Estudante (nome, curso) VALUES
('Ana Clara', 'Enfermagem'),
('Bruno Souza', 'Medicina'),
('Carlos Dias', 'Educação Física'),
('Daniela Lima', 'Psicologia'),
('Eduardo Martins', 'Biomedicina');

INSERT INTO Instrutor (curso) VALUES
('Medicina'),
('Psicologia'),
('Educação Física'),
('Biomedicina'),
('Fisioterapia');

INSERT INTO Aula (instituicao, cidade, estado) VALUES
('Univille', 'Joinville', 'Santa Catarina'),
('UFSC', 'Florianópolis', 'Santa Catarina'),
('USP', 'São Paulo', 'São Paulo'),
('UNIVALI', 'Itajaí', 'Santa Catarina'),
('UTFPR', 'Curitiba', 'Paraná');

INSERT INTO Aulas_assistidas (estudanteID, instrutorID, aulaID, notas) VALUES
(1, 2, 1, 75),
(2, 1, 1, 80),
(3, 4, 3, 65),
(4, 3, 2, 85),
(5, 5, 4, 90),
(2, 3, 1, 60),
(1, 5, 2, 72),
(3, 2, 2, 74),
(4, 1, 4, 76);