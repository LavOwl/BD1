USE bbdd1;

SELECT * 
FROM bbdd1.Patient p 
WHERE NOT EXISTS (
	SELECT * 
    FROM bbdd1.Appointment a 
    WHERE p.patient_id = a.patient_id and p.secondary_phone = a.contact_phone);