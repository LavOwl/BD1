USE bbdd1;

CREATE TABLE bbdd1.APPOINTMENTS_PER_PATIENT (
    idApP integer(11) auto_increment primary key,
    patient_id integer(11) NOT NULL,
    count_appointments integer(11) NOT NULL DEFAULT 0,
    last_update datetime,
    user varchar(16),
    CONSTRAINT fk_patient_id FOREIGN KEY (`patient_id`) REFERENCES bbdd1.patient(`patient_id`),
    UNIQUE (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;