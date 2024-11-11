USE bbdd1;


SELECT pat.patient_id 
FROM bbdd1.Patient pat
WHERE NOT EXISTS (
    SELECT *
    FROM bbdd1.Doctor d
    WHERE pat.patient_city = d.doctor_city and NOT EXISTS(
        SELECT *
        FROM bbdd1.Medical_Review mr
        WHERE mr.patient_id = pat.patient_id and mr.doctor_id = d.doctor_id
    )
);


SELECT pat.patient_id
FROM bbdd1.Patient pat
WHERE 
    ((SELECT COUNT(DISTINCT doc.doctor_id) -- Calcula con cuantos se trató DISTINTOS DAMN IT, que sean de su ciudad
    FROM bbdd1.Medical_Review mr NATURAL JOIN bbdd1.Doctor doc
    WHERE mr.patient_id = pat.patient_id and pat.patient_city = doc.doctor_city
    GROUP BY pat.patient_id)
    =
    (SELECT COUNT(*) -- Calcula La cantidad de doctores en la misma ciudad que el paciente
    FROM bbdd1.Patient p INNER JOIN bbdd1.Doctor d ON (d.doctor_city = p.patient_city)
    WHERE p.patient_id = pat.patient_id
    GROUP BY pat.patient_id));

SELECT pat.patient_id
FROM bbdd1.Patient pat
WHERE 
    ((SELECT COUNT(DISTINCT doc.doctor_id) -- Calcula con cuantos se trató DISTINTOS DAMN IT, que sean de su ciudad
    FROM bbdd1.Medical_Review mr NATURAL JOIN bbdd1.Doctor doc
    WHERE mr.patient_id = pat.patient_id and pat.patient_city = doc.doctor_city
    GROUP BY pat.patient_id)
    =
    (SELECT COUNT(*) -- Calcula La cantidad de doctores en la misma ciudad que el paciente
    FROM bbdd1.doctors_per_patient dpp
    WHERE dpp.patient_id = pat.patient_id
    GROUP BY pat.patient_id));

-- SOLUCION ALTERNATIVA

SELECT p.patient_id -- Al seleccionar de un group by solo podés mostrar una tupla por grupo, por lo que tiene que solo mostrar atributos comunes al grupo entero (los de filtrado, que nunca cambian en todo el grupo) o de valores agregados (min, max, count, etc.)
FROM bbdd1.Medical_Review mr 
    NATURAL JOIN bbdd1.Patient p 
    INNER JOIN bbdd1.Doctor d
        ON (mr.doctor_id = d.doctor_id and d.doctor_city = p.patient_city)
GROUP BY p.patient_id, p.patient_city
    HAVING COUNT(DISTINCT d.doctor_id) = ( -- El primer Count 
        SELECT COUNT(*)
        FROM bbdd1.Doctor doc
        WHERE doc.doctor_city = p.patient_city
    );