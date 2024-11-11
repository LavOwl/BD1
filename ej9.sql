USE bbdd1;

CALL bbdd1.load_data(10004427, 1003, 30, '+54 15 2913 9963', 'Necesitaba paracetamol :3', 'Paracetamol');


SELECT * FROM bbdd1.Appointment a NATURAL JOIN bbdd1.Medical_Review NATURAL JOIN bbdd1.Prescribed_Medication WHERE a.observations = 'Necesitaba paracetamol :3';
