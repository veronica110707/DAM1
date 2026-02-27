DROP DATABASE IF EXISTS obras_musicales;
CREATE DATABASE obras_musicales;
USE obras_musicales;

-- DROP TABLE IF EXISTS compositor;

CREATE TABLE compositor (
	id_compositor SMALLINT UNSIGNED,
	nombre varchar(50) NOT NULL,
    año_nacimiento YEAR,
    nacionalidad CHAR(4), -- como codigo de pais: ES, FR, IT, CHAPUZA
    CONSTRAINT pk_compositor PRIMARY KEY (id_compositor)
);

CREATE TABLE director (
	id_director SMALLINT UNSIGNED,
	nombre varchar(50) NOT NULL,
    -- nombre varchar(50) NOT NULL UNIQUE
    -- unique no está en el modelo relacional pero hemos pensado q hay q ponerlo
    año_nacimiento YEAR,
    nacionalidad CHAR(4), -- como codigo de pais: ES, FR, IT, CHAPUZA
    CONSTRAINT pk_director PRIMARY KEY (id_director),
    CONSTRAINT uq_director_nombre UNIQUE(nombre), -- tambien se puede poner asi
    CONSTRAINT chk_nombre_not_null CHECK (nombre IS NOT NULL) -- permite comprobar las condiciones q quieras
);

CREATE TABLE interprete (
	id_interprete SMALLINT UNSIGNED,
	nombre varchar(50) NOT NULL,
    año_nacimiento YEAR,
    tipo CHAR(45), -- como codigo de pais: ES, FR, IT, CHAPUZA
    CONSTRAINT pk_interprete PRIMARY KEY (id_interprete)
);

CREATE TABLE obras(
	id_obra SMALLINT UNSIGNED,
	titulo VARCHAR(50) NOT NULL,
    tipo VARCHAR(25),
    modo VARCHAR(25),
    tono ENUM('domayor', 'domenor', 'do#mayor', 'do#menor'),
    id_compositor SMALLINT UNSIGNED,
    CONSTRAINT pk_obras PRIMARY KEY (id_obra),
    CONSTRAINT fk_obra_compositor FOREIGN KEY (compositor) -- campo de esta tabla
		REFERENCES compositor(compositor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE -- por defecto
);

CREATE TABLE version (
	id_version MEDIUMINT UNSIGNED, -- como kkeva un constraint de pk no hace falta indicar not null ni unique
	id_obra SMALLINT UNSIGNED NOT NULL,
    id_interprete SMALLINT UNSIGNED NOT NULL,
    id_director SMALLINT UNSIGNED,
     -- id_version SMALLINT UNSIGNED -- ERROR DE DISEÑO		
	CONSTRAINT pk_version PRIMARY KEY (id_version),
	CONSTRAINT fk_version_obra FOREIGN KEY (id_obra)
		REFERENCES obra (id_obra)
		ON DELETE RESTRICT ON UPDATE CASCADE, -- restrict hace q si version tiene asociada una obra, version no se puede borrar, primero habria q borrar obra
	CONSTRAINT fk_version_interprete FOREIGN KEY (id_interprete)
		REFERENCES interprete (id_interprete)
        ON DELETE RESTRICT ON UPDATE CASCADE, 
	CONSTRAINT fk_version_director FOREIGN KEY (id_director)
		REFERENCES director (id_director)
        -- las dos opciones puedes ser validas dependiendo del contexto
		ON DELETE RESTRICT ON UPDATE CASCADE
        -- ON DELETE SET NULL ON UPDATE CASCADE
    
    
    -- ctrl + b 
);



