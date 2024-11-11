USE bbdd1;

DROP TRIGGER IF EXISTS update_appointments_per_person;
DELIMITER //
CREATE TRIGGER update_appointments_per_person
AFTER INSERT ON bbdd1.Appointment
FOR EACH ROW
BEGIN
	DECLARE fecha DATETIME;
    DECLARE user VARCHAR(16);
    DECLARE counted INTEGER;
    SET user = USER();
    SET fecha = NOW();
    SELECT count_appointments INTO counted
    FROM bbdd1.Appointments_Per_Patient p
    WHERE NEW.patient_id = p.patient_id;
    IF counted IS NOT NULL THEN
        UPDATE bbdd1.Appointments_Per_Patient
        SET count_appointments = counted + 1, last_update = fecha, user = user
        WHERE patient_id = NEW.patient_id;
    ELSE
        INSERT INTO bbdd1.Appointments_Per_Patient(patient_id, count_appointments, last_update, user)
        VALUES (NEW.patient_id, 1, fecha, user);
    END IF;
END //
DELIMITER ;
INSERT INTO bbdd1.patient (patient_id, patient_name, patient_address, patient_city, primary_phone, secondary_phone) VALUES
(1, 'Daguerre Elgarte Ivy', 'Avenida 3 N° 531, San Salvador de Jujuy 4600, Jujuy', 'Salta', '+54 9 3646 2798', '+54 15 2836 0667');
INSERT INTO bbdd1.appointment(patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card)
VALUES (1, NOW(), 15, 'holis', 'holis2', 'holis_pay'); 

SELECT * 
FROM bbdd1.appointments_per_patient ap 
WHERE ap.patient_id = 10000036 OR ap.patient_id = 10000132 OR ap.patient_id = 1;