create database prueba;

use prueba;

drop table personas;

create table personas (
	id_persona int NOT NULL auto_increment,
    nombre varchar(40),
    apellido varchar(55),
    edad int,
    fech_acc datetime default current_timestamp(),
    UNIQUE(id_persona),
    PRIMARY KEY(id_persona),
    CHECK (edad>=18)
    );

alter table personas
add email varchar(100);

alter table personas
rename column apellido to descripcion;

alter table personas
modify column descripcion varchar(250);

alter table personas
drop column descripcion;

create table dni (
	id_dni int auto_increment not null primary key,
    numero_dni varchar(9) not null,
    id_persona int,
    unique(id_dni, numero_dni),
    foreign key (id_persona) references personas(id_persona)
    );
    
alter table dni
add constraint fk_persona
foreign key (id_persona) references personas(id_persona)
;

create table empresa (
	id_empresa int not null auto_increment primary key,
	nombre varchar(30) not null
	);

-- alter table personas
-- add id_empresa varchar(25);

alter table personas
add constraint fk_empresa
foreign key (id_empresa) references empresa (id_empresa);

alter table personas
modify column id_empresa int not null;

create table lenguajes (
	id_lenguaje int auto_increment primary key,
	name varchar(20) not null
    );

create table personas_lenguajes (
	id_persona_lenguaje int auto_increment primary key,
    id_persona int,
    id_lenguaje int,
    foreign key (id_persona) references personas (id_persona),
    foreign key (id_lenguaje) references lenguajes (id_lenguaje),
    unique (id_persona, id_lenguaje)
    );

-- o

create table personas_lenguajes (
    id_persona int,
    id_lenguaje int,
    primary key (id_persona, id_lenguaje),
    foreign key (id_persona) references personas (id_persona) on delete cascade on update cascade,
    foreign key (id_lenguaje) references lenguajes (id_lenguaje),
    unique (id_persona, id_lenguaje)
    );

insert into dni (numero_dni, id_persona) values ('11111111A', 1);


