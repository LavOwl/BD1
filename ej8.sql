USE bbdd1;


DELIMITER //
CREATE PROCEDURE load_data(IN patient_id INTEGER, IN doctor_id INTEGER, IN appointment_duration INTEGER, IN contact_phone VARCHAR(45), IN observations VARCHAR(255), IN medication_name VARCHAR(30))
BEGIN
    DECLARE fecha DATETIME;
    SET fecha = NOW();
    START TRANSACTION;
        INSERT INTO bbdd1.appointment(patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
        VALUES (patient_id, fecha, appointment_duration, contact_phone, observations, NULL);
        INSERT INTO bbdd1.Medical_Review(patient_id, appointment_date, doctor_id)
        VALUES (patient_id, fecha, doctor_id);
        INSERT INTO bbdd1.Prescribed_Medication(patient_id, appointment_date, medication_name)
        VALUES (patient_id, fecha, medication_name);
    COMMIT;
END //
DELIMITER ;