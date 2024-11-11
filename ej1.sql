-- CREATE USER 'appointments_user'@'localhost' IDENTIFIED WITH CACHING_SHA2_PASSWORD BY 'IvyPsswd';
GRANT ALL ON bbdd1.* TO 'appointments_user'@'localhost';

-- CREATE USER 'appointments_select'@'localhost' IDENTIFIED WITH CACHING_SHA2_PASSWORD BY 'IvyPsswd';
GRANT SELECT ON bbdd1.* TO 'appointments_select'@'localhost';

-- CREATE USER 'appointments_update'@'localhost' IDENTIFIED WITH CACHING_SHA2_PASSWORD BY 'IvyPsswd';
GRANT SELECT, INSERT, DELETE, UPDATE ON bbdd1.* TO 'appointments_update'@'localhost';

-- CREATE USER 'appointments_schema'@'localhost' IDENTIFIED WITH CACHING_SHA2_PASSWORD BY 'IvyPsswd';
GRANT SELECT, INSERT, DELETE, UPDATE ON bbdd1.* TO 'appointments_schema'@'localhost';
GRANT CREATE, DROP, ALTER ON bbdd1 TO 'appointments_schema'@'localhost';