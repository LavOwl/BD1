USE bbdd1;
SELECT COUNT(a.patient_id)
FROM bbdd1.appointment a, bbdd1.patient p, bbdd1.doctor d, bbdd1.medical_review mr
WHERE a.patient_id= p.patient_id
	and a.patient_id= mr.patient_id
	and a.appointment_date=mr.appointment_date
	and mr.doctor_id = d.doctor_id
	and d.doctor_specialty = 'Cardiology'
	and p.patient_city = 'Rosario';