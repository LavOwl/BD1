USE bbdd1;

DROP PROCEDURE IF EXISTS nombre_epico;
DROP PROCEDURE IF EXISTS load_ApP;

DELIMITER //
CREATE PROCEDURE load_ApP()
BEGIN
    DECLARE stop_sign INT DEFAULT 0;
    DECLARE aux_patient_id INT;
    DECLARE aux_count INT;
    DECLARE fecha DATETIME;
    DECLARE update_user VARCHAR(16);
    DECLARE my_cursor CURSOR FOR    SELECT p.patient_id, COUNT(*)
                                    FROM bbdd1.Patient p LEFT JOIN bbdd1.Appointment a ON (p.patient_id = a.patient_id)
                                    GROUP BY p.patient_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET stop_sign = 1;
    
    SET update_user = USER();
    SET fecha = NOW();
    
    START TRANSACTION;
    OPEN my_cursor;
    loop_my_cursor : LOOP
        FETCH NEXT FROM my_cursor INTO aux_patient_id, aux_count;
        IF stop_sign = 1 THEN
            LEAVE loop_my_cursor;
        END IF;
        INSERT INTO bbdd1.Appointments_Per_Patient(patient_id, count_appointments, last_update, user) VALUES (aux_patient_id, aux_count, fecha, update_user); 
    END LOOP;
    CLOSE my_cursor;
    COMMIT;
END //
DELIMITER ;

CALL bbdd1.load_ApP();

SELECT * FROM bbdd1.Appointments_Per_Patient;