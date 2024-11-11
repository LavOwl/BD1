USE bbdd1;

CREATE VIEW bbdd1.doctors_per_patient AS (SELECT p.patient_id, d.doctor_id FROM bbdd1.Patient p LEFT JOIN bbdd1.Doctor d ON (d.doctor_city = p.patient_city));