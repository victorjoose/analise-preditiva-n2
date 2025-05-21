-- ================================================
-- Estrutura DW - Questões 2 e 3 - Avaliação N2
-- Tabela para armazenar dados do dataset Heart Failure Prediction
-- ================================================

CREATE TABLE heart_data (
    id SERIAL PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    chest_pain_type VARCHAR(50),
    resting_bp INT,
    cholesterol INT,
    fasting_blood_sugar BOOLEAN,
    resting_ecg VARCHAR(50),
    max_heart_rate INT,
    exercise_induced_angina BOOLEAN,
    oldpeak NUMERIC(3,1),
    slope VARCHAR(20),
    num_major_vessels INT,
    thalassemia VARCHAR(50),
    diabetes BOOLEAN,
    smoking_history VARCHAR(50),
    alcohol_consumption VARCHAR(50),
    physical_activity_level VARCHAR(50),
    family_history BOOLEAN,
    bmi NUMERIC(4,1),
    heart_failure BOOLEAN
);
