-- Carregando os dados do CSV para a tabela heart_data
COPY heart_data (
    age, gender, chest_pain_type, resting_bp, cholesterol,
    fasting_blood_sugar, resting_ecg, max_heart_rate, exercise_induced_angina,
    oldpeak, slope, num_major_vessels, thalassemia, diabetes,
    smoking_history, alcohol_consumption, physical_activity_level,
    family_history, bmi, heart_failure
)
FROM '/tmp/heart_failure_prediction.csv'
DELIMITER ','
CSV HEADER;