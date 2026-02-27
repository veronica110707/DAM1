CREATE DATABASE obras_musicales;
USE obras_musicales;
CREATE TABLE obras(
	titulo VARCHAR(50) NOT NULL,
    tipo VARCHAR(25),
    modo VARCHAR(25),
    tono ENUM('domayor', 'domenor', 'do#mayor', 'do#menor'),
    compositor SMALLINT UNSIGNED,
    CONSTRAINT 'fk_obra compositor'
		FOREIGN KEY(compositor) -- campo de esta tabla
		REFERENCES compositor(compositor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE -- por defecto


